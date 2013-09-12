Trvrgur.Collections.Images = Backbone.Collection.extend({

  model: Trvrgur.Models.Image,

  comparator: function (image) {
    return image.id;
  }

});
