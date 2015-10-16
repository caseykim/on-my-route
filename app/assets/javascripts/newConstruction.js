$(document).ready(function(){
  $("#new-construction").click(function(){
    $.ajax({
        type: "GET",
        url: "/constructions/new",
        dataType: "script"
    })
    .done(function(){
      return false;
    });
  });
  $("form").submit(function () {
      var valuesToSubmit = $(this).serialize();
      $.ajax({
          type: "POST",
          url: $(this).attr("action"),
          data: valuesToSubmit,
          dataType: "script"
      })
      .done(function(){
        return false;
      });
  });
});
