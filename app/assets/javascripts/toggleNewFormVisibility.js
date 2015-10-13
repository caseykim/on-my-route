$(function(){
  $(".button-new-form").on("click", function(){
    var $div = $(this).closest(".content");
    var $form = $div.find(".newform");
    $form.slideToggle("slow");
  });
});
