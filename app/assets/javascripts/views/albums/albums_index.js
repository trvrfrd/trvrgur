Trvrgur.Views.AlbumsIndex = Backbone.View.extend({

  template: JST['albums/index'],

  render: function () {
    this.$el.html(this.template({ albums: this.collection }));
    return this;
  }

});
