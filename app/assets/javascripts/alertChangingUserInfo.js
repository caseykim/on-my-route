$(document).ready(function(){
  $('#user_name').focus(function() {
    prev_val = $(this).val();
  }).change(function() {
    $(this).blur();
    var response = confirm('Changing name will permanently update name on your account and for existing reminders. Would you like to preceed?');
    if (!response) {
      $(this).val(prev_val);
    }
  });
});

$(document).ready(function(){
  $('#user_phone_number').focus(function() {
    prev_val = $(this).val();
  }).change(function() {
    $(this).blur();
    var response = confirm('Changing number will permanently update phone number on your account and for existing reminders. Would you like to preceed?');
    if (!response) {
      $(this).val(prev_val);
    }
  });
});
