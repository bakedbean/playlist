// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(".rating").bind('ajax:success', function() {
	var url = this.getAttribute('href');
	$.ajax({
		url: url,
		cache: false,
		success: function(html){
			$('#set_rating').html(html).show();
		}
	});
});