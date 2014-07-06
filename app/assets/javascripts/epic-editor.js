function start_epiceditor_edit_mode() {
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

function start_epiceditor_preview_mode() {
    var opts = {
    textarea: 'epiceditor-textarea',
    clientSideStorage: false,
    button: {
      bar: false
    },
    autogrow: true
  }
  var editor = new EpicEditor(opts).load();
  editor.preview();
}
