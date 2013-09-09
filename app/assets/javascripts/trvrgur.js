window.Trvrgur = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($el, user, albums, comments) {
    Trvrgur.$el = $el;
    Trvrgur.current_user = user;
    Trvrgur.albums = new Trvrgur.Collections.Albums(albums);
    Trvrgur.comments = new Trvrgur.Collections.Comments(comments);
    console.log(Trvrgur);
  }
};