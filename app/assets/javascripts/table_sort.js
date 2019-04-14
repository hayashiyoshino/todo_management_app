
$(function() {
  return $('.table-sortable').sortable({
    axis: 'y',
    items: '.item',
    update: function(e, ui) {
      console.log(ui)
      item = ui.item
      itemm = ui.item.context
      console.log(itemm)
      item_data = itemm.dataset
      params = { _method: 'put' }
      params[item_data.model_name] = { row_order_position: ui.item.index() }
      $.ajax({
        type: 'PUT',
        url: item_data.updata_url,
        dataType: 'json',
        data: params
      });
    },
  });
});

