window.Trvrgur = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($el, user, top_comments) {
    Trvrgur.$el = $el;
    Trvrgur.current_user = user;
    Trvrgur.top_comments = new Trvrgur.Collections.Comments(top_comments);
    Trvrgur.albums = new Trvrgur.Collections.Albums();
    Trvrgur.albums.fetch({
      success: function (response) {
        Trvrgur.router = new Trvrgur.Routers.Albums($("#content"));
        Backbone.history.start();
      }
    });
  }
};