class SHIORI_WORKER_CLASS extends NativeShioriWorkerClient
  @url = URL.createObjectURL(new Blob([worker_code], {type:"text/javascript"}))
  worker: -> @_worker
  load: (dirpath) ->
    @_worker = new URLWorkerClient SHIORI_WORKER_CLASS.url, false
    super(dirpath)
  _push: (dirpath) ->
    @storage.ghost_master(@ghostpath)
    .then (directory) ->
      directory.asArrayBuffer()
    .then (directory) =>
      transferable = []
      for path, data of @_satori_ignore_saori(directory)
        transferable.push data
      @worker().request('push', [dirpath, directory], transferable)
  _satori_ignore_saori: (directory) ->
    for path of directory
      if /\bsatori_conf\.txt$/.test(path)
        uint8arr = new Uint8Array(directory[path])
        filestr = Encoding.codeToString(Encoding.convert(uint8arr, 'UNICODE', 'SJIS'))
        if /＠SAORI/.test(filestr)
          filestr = filestr.replace(/＠SAORI/, '＠NO__SAORI')
          directory[path] = new Uint8Array(Encoding.convert(Encoding.stringToCode(filestr), 'SJIS', 'UNICODE')).buffer
        break
    return directory

if @ShioriLoader?.shiories?
	@ShioriLoader.shiories.SHIORI_NAME = SHIORI_WORKER_CLASS
else
	throw "load ShioriLoader first"
