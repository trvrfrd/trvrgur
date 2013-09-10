Trvrgur.Routers.Albums = Backbone.Router.extend({
  initialize: function ($el) {
    this.$el = $el;
  },

  routes: {
    ""          : "index",
    "albums"    : "index",
    "albums/:id": "show"
  },

  index: function () {
    var albumsIndex = new Trvrgur.Views.AlbumsIndex({
      collection: Trvrgur.albums
    });
    this.$el.html(albumsIndex.render().$el);
  },

  show: function (id) {
    var album = Trvrgur.albums.get(id);
    var albumShow = new Trvrgur.Views.AlbumShow({ model: album });
    this.$el.html(albumShow.render().$el);
  }
});
