$(function(){
  $('body').on('change', 'select#construction_line_id', function(){
    $.ajax({
      type: 'GET',
      url: '/lines/' + $(this).val() + '/stations',
      dataType: 'html'
    })
    .done(function(data){
      $('#construction_start_station_id').html(data);
      $('#construction_end_station_id').html(data);
    });
  });
});
