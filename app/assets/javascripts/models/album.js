Trvrgur.Models.Album = Backbone.Model.extend({
  parse: function (data) {
    data.images = new Trvrgur.Collections.Images(data.images);
    data.comments = new Trvrgur.Collections.Comments(data.comments);
    return data;
  },

  getCommentsByParentId: function () {
    var result = {};
    this.get('comments').each(function (comment) {
      var id = comment.get("parent_comment_id");
      result[id] || (result[id] = []);
      result[id].push(comment);
    });
    return result;
  }
});
