window.Trvrgur = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($el, user, albums, comments) {
    Trvrgur.$el = $el;
    Trvrgur.current_user = user;
    Trvrgur.albums = albums;
    Trvrgur.comments = comments;
    console.log(Trvrgur);
  }
};