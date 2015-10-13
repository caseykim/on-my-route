var prevVal;
$(document).ready(function(){
  $('#user_name').focus(function() {
    prevVal = $(this).val();
  }).change(function() {
    $(this).blur();
    var message = 'Changing name will permanently update name on your account' +
      ' and for existing reminders. Would you like to preceed?';
    var response = confirm(message);
    if (!response) {
      $(this).val(prevVal);
    }
  });
});

$(document).ready(function(){
  $('#user_phone_number').focus(function() {
    prevVal = $(this).val();
  }).change(function() {
    $(this).blur();
    var message = 'Changing name will permanently update name on your account' +
      ' and for existing reminders. Would you like to preceed?';
    var response = confirm(message);
    if (!response) {
      $(this).val(prevVal);
    }
  });
});
