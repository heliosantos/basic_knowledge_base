var articles_keeper = function ( ) {
  var articles = {};

  var add = function ( article ) {
    articles[article['_id']] = article;
  }

  var get = function ( permalink ) {
    return articles[permalink];
  }

  return {'add': add, 'get': get};
}();

function add_article(article, edit_link) {
  var append_to = $('#articles');
  if( $(".article").length > 0 ) {
    append_to = $(".article:last");
  }

  articles_keeper['add'](article);

  append_to.after(
    '<div class="article">\
      <div class="article-title" onclick="show_details_dialog(\'' + article['_id'] + '\');">' + article['title'] + '</div>\
      <div class="article-edit"><a href="' + edit_link + '">Edit</a></div>' +  
    '</div>');
}


function show_details_dialog(permalink) {

  var article = articles_keeper['get'](permalink);

  $('#details-dialog').html(article['body']);
  $('#details-dialog').dialog({width: 800, draggable: false, minHeight: 600, title: article['title']});

}

