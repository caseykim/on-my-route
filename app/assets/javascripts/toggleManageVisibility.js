$(function(){
  $(".manage-reminders").on("click", function(){
    var $ul = $(this).siblings(".reminder-list");
    var $a = $ul.find(".delete");
    $a.toggleClass("hide");
  });
});

$(function(){
  $("body").on("click", ".show-options", function(){
    $(this).siblings(".options").toggle();
  });
});
