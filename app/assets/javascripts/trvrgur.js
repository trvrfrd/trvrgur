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
        console.log("successful fetch!");
        console.log(Trvrgur.albums);
        // start router and stuff
      }
    });
  }
};