$(document).ready(function(){
  $('#new-construction').click(function(e){
    $.ajax({
        type: "GET",
        url: "/constructions/new",
        dataType: "script"
    })
    .done(function(data){
      return false;
    });
  });
  $('form').submit(function () {
      var url = $(this).attr('action');
      var valuesToSubmit = $(this).serialize();
      $.ajax({
          type: "POST",
          url: $(this).attr('action'),
          data: valuesToSubmit,
          dataType: "script"
      })
      .done(function(){
        return false;
      });
  });
});
