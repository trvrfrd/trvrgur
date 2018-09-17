Trvrgur.Views.ImageShow = Backbone.View.extend({

  template: JST['images/show'],

  render: function () {
    this.$el.html(this.template({ image: this.model }));
    return this;
  }

});
