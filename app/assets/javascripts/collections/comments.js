Trvrgur.Collections.Comments = Backbone.Collection.extend({
  initialize: function (albumId) {
    this.albumId = albumId;
  },

  model: Trvrgur.Models.Comment,

  url: function () {
    return '/albums/' + this.albumId + '/comments';
  }

});
