function start_editor() {
    var opts = {
    textarea: 'epiceditor-textarea',
    clientSideStorage: false,
    button: {
      preview: true,
      fullscreen: true,
      bar: true
    }
  }
  var editor = new EpicEditor(opts).load();
}
