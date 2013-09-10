window.Trvrgur = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($el, user, comments) {
    Trvrgur.$el = $el;
    Trvrgur.current_user = user;
    Trvrgur.comments = new Trvrgur.Collections.Comments(comments);
    Trvrgur.albums = new Trvrgur.Collections.Albums();
    Trvrgur.albums.fetch({
      success: function (response) {
        Trvrgur.router = new Trvrgur.Routers.Albums($("#content"));
        Backbone.history.start();
      }
    });
  }
};