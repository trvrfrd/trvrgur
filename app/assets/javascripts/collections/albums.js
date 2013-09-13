Trvrgur.Collections.Albums = Backbone.Collection.extend({

  model: Trvrgur.Models.Album,

  comparator: function (album) {
    return album.id;
  },

  url: "/albums"

});
