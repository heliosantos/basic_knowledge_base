var articles_keeper = function ( ) {
  // an array to keep articles
  var articles = {};
  
  // add article to articles array
  var add = function ( article ) {
    articles[article['_id']] = article;
  }
  
  // get article from articles array
  var get = function ( permalink ) {
    return articles[permalink];
  }

  return {'add': add, 'get': get};
}();

function add_article(article, show_link, edit_link) {
  var append_to = $('#articles');
  if( $(".article").length > 0 ) {
    append_to = $(".article:last");
  }

  articles_keeper['add'](article);

  edit_href = edit_link === null ? '' : '<a href="' + edit_link + '">Edit</a>'; 

  append_to.after(
    '<div class="article" onclick="window.location = \'' + show_link + '\';" >\
      <div class="article-title">' + article['title'] + '</div>\
      <div class="article-edit">' + edit_href + '</div>' +  
    '</div>');
}

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
