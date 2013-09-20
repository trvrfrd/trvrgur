Trvrgur.Collections.Albums = Backbone.Collection.extend({

  model: Trvrgur.Models.Album,

  comparator: function (album) {
    return album.id;
  },

  sortByPoints: function () {
    return this.models.sort(function (a, b) {
      return b.get("points") - a.get("points");
    });
  },

  sortByNewest: function () {
    return this.models.sort(function (a, b) {
      return Date.parse(b.get("created_at")) - Date.parse(a.get("created_at"));
    });
  },

  url: "/albums"

});
