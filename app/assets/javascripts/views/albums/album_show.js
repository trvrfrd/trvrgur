Trvrgur.Views.AlbumShow = Backbone.View.extend({

  template: JST['albums/show'],

  events: {
    "click .upvote"  : "upvote",
    "click .downvote": "downvote",
    "click .favorite": "favorite"
  },

  render: function () {
    this.$el.html(this.template({ album: this.model }));
    return this;
  },

  downvote: function (event) {
    var that = this;
    $.ajax({
      url: this.model.url() + '/downvote',
      success: function () {
        that.model.fetch({ success: that.render.bind(that) });
      }
    });
  },

  favorite: function (event) {
    var that = this;
    $.ajax({
      url: this.model.url() + '/favorite',
      success: function () {
        that.model.fetch({ success: that.render.bind(that) });
      }
    });
  },

  upvote: function (event) {
    var that = this;
    $.ajax({
      url: this.model.url() + '/upvote',
      success: function () {
        that.model.fetch({ success: that.render.bind(that) });
      }
    });
  }

});