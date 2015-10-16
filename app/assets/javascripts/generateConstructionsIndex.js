$(document).ready(function(){
  $(".side-column li").click(function(){
    event.preventDefault();
    var url = $(this).find('a').attr('href');
    $.ajax({
          type: "GET",
          url: url,
          dataType: "script"
        });
  });
});
