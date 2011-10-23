// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(".star").click(function() {
	
	var clicked = $(this).attr('id');
	
	$('.star').each(function(index){
		
		var realIndex = (index + 1);
		
		if(realIndex < clicked){
			
			$('#' + realIndex).attr('src','/assets/star_on.png');
		}else if(realIndex == clicked){
			
			if($('#' + clicked).attr('src') == '/assets/star_off.png'){
				$('#' + realIndex).attr('src','/assets/star_on.png');
			}else{
				$('#' + realIndex).attr('src','/assets/star_off.png');
				clicked -= 1;
			}
		}else{
			$('#' + realIndex).attr('src','/assets/star_off.png');
		}
	});
	
	$('#rating_value').val(clicked);
});
