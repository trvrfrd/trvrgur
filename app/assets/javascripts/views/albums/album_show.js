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

  downvote: function () {},
  favorite: function () {},
  upvote: function () {}

});