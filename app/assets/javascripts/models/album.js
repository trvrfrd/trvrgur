Trvrgur.Models.Album = Backbone.Model.extend({
  parse: function (data) {
    data.images = new Trvrgur.Collections.Images(data.images);
    return data;
  }
});
