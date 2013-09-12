Trvrgur.Views.AlbumShow = Backbone.View.extend({

  template: JST['albums/show'],

  events: {
    "click .upvote"  : "handleClick",
    "click .downvote": "handleClick",
    "click .favorite": "handleClick"
  },

  render: function () {
    this.$el.html(this.template({ album: this.model }));
    return this;
  },

  handleClick: function (event) {
    var that = this;
    $.ajax({
      url: $(event.currentTarget).attr("data-url"),
      success: function () {
        that.model.fetch({ success: that.render.bind(that) });
      }
    });
  }
  
});