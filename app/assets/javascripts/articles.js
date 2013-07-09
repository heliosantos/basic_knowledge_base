var articles_keeper = function ( ) {
  var articles = {};

  var add_article = function ( article ) {
    articles[article['_id']] = article;
  }

  var get_article = function ( permalink ) {
    return articles[permalink];
  }

  return {'add_article': add_article, 'get_article': get_article};
}();

function add_article(article) {
  var append_to = $('#articles');
  if( $(".article").length > 0 ) {
    append_to = $(".article:last");
  }

  articles_keeper['add_article'](article);

  append_to.after('<div class="article" onclick="show_details_dialog(\'' + article['_id'] + '\');"><div class="article-content">' + article['title'] + '</div></div>');
}


function show_details_dialog(permalink) {

  var article = articles_keeper['get_article'](permalink);

  $('#details-dialog').html(article['body']);
  $('#details-dialog').dialog({width: 800, draggable: false, minHeight: 600, title: article['title']});

}

