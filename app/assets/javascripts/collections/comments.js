Trvrgur.Collections.Comments = Backbone.Collection.extend({

  model: Trvrgur.Models.Comment,

  comparator: function (comment) {
    return comment.id;
  },

  url: function () {
    return '/albums/' + this.albumId + '/comments';
  }

});
