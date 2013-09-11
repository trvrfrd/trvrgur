Trvrgur.Models.Album = Backbone.Model.extend({
  parse: function (data) {
    data.images = new Trvrgur.Collections.Images(data.images);
    data.comments = new Trvrgur.Collections.Comments(data.comments);
    return data;
  },

  commentsByParentId: function () {
    var result = {};
    return result;
  }
});
