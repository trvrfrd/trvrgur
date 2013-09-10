Trvrgur.Views.AlbumShow = Backbone.View.extend({

  template: JST['albums/show'],

  render: function () {
    this.$el.html(this.template({ album: this.model }));
    return this;
  }

});