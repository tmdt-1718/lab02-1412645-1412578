	document.addEventListener("turbolinks:load", function() {
  $("#user_email").keyup(function(e){
  	if ($("#user_email").val() != '')
  		$("#submit").click();
  });
});