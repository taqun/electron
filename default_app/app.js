const {dialog, localFile} = require('electron').remote

dialog.showOpenDialog(
  {
    'properties': ['openFile', 'openDirectory']
  },
  function(filenames){
    let filepath = filenames[0];
    let bookmark = localFile.createBookmark(filepath);
    console.log(filepath);
    console.log(bookmark);
  }
);
