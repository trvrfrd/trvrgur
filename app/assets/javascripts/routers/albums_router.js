Trvrgur.Routers.Albums = Backbone.Router.extend({
  initialize: function ($el) {
    this.$el = $el;
  },

  routes: {
    ""                           : "albumsIndex",
    "albums"                     : "albumsIndex",
    "albums/:id"                 : "albumShow",
    "albums/:album_id/images/:id": "imageShow"
  },

  albumsIndex: function () {
    var albumsIndex = new Trvrgur.Views.AlbumsIndex({
      collection: Trvrgur.albums
    });
    this.$el.html(albumsIndex.render().$el);
  },

  albumShow: function (id) {
    var album = Trvrgur.albums.get(id);
    var albumShow = new Trvrgur.Views.AlbumShow({ model: album });
    this.$el.html(albumShow.render().$el);
  },

  imageShow: function(album_id, id) {
    var image = Trvrgur.albums.get(album_id).get('images').get(id);
    var imageShow = new Trvrgur.Views.ImageShow({ model: image });
    this.$el.html(imageShow.render().$el);
  }
});
