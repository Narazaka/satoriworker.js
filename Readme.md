SatoriWorker - WebWorker SHIORI subsystem Satori
==========================

Install
--------------------------
```
npm install satoriworker.js
```

Usage
--------------------------
node.js
```javascript
var ShioriLoader = require("shioriloader");
var SatoriWorker = require("satoriworker.js");
```

browser
```javascript
<script src="browserfs.js"></script>
<script src="shioriloader.js"></script>
<script src="satoriworker-webworker-all.js"></script>
```

then
```javascript
var shiori = new SatoriWorker();
shiori.load(dirpath).then(...);

// or

ShioriLoader.shiori_detectors = [
  function(fs, dirpath, shiories) {
    return new Promise(function(resolve) { resolve(new shiories.satori(fs)) });
  },
];

ShioriLoader
  .detect_shiori(fs, dirpath)
  .then((shiori) => shiori.load(dirpath))
  .then(...);
```

License
--------------------------

This is released under [MIT License](http://narazaka.net/license/MIT?2016).
