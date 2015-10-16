$(document).ready(function(){
  $(".side-column").click(function(){
    event.preventDefault();
    var url = $(event.target).attr("href");
    $.ajax({
          type: "GET",
          url: url,
          dataType: "script"
        });
  });
});
