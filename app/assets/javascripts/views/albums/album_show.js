Trvrgur.Views.AlbumShow = Backbone.View.extend({

  initialize: function() {
    var that = this;
  },

  template: JST['albums/show'],

  events: {
    "click .upvote"  : "handleClick",
    "click .downvote": "handleClick",
    "click .favorite": "handleClick",
    "click .submit"  : "submitCommentForm"
  },

  render: function () {
    $(".content").empty();
    this.$el.html(this.template({ album: this.model }));
    return this;
  },

  handleClick: function (event) {
    var that = this;
    var $target = $(event.currentTarget);
    $.ajax({
      url: $target.attr("data-url"),
      type: ($target.attr("data-method") || "GET"),
      success: function () {
        that.model.fetch({ success: that.render.bind(that) });
      }
    });
  },

  submitCommentForm: function (event) {
    var that = this;
    event.preventDefault();
    var formData = $(event.currentTarget.form).serializeJSON();
    var comment = new Trvrgur.Models.Comment(formData["comment"]);
    comment.set("author_id", Trvrgur.current_user.id);
    comment.set("album_id", that.model.id);
    comment.save({}, {
      success: function (model) {
        that.model.get("comments").add(model);
        that.render.bind(that)();
      }
    });
  }
  
});