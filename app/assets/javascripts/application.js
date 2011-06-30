// By Oto Brglez - <oto.brglez@opalab.com>
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .

$(function(){
	
	/* Switching tabs */
	if($("#tabed_module").length != 0){
		
		$("#tabed_module .tabNav a").bind("click",function(e){
			if(e.preventDefault) e.preventDefault();
			$("#tabed_module .tabNav a").parent().removeClass("selected");
			$(this).parent().addClass("selected");
			
			var who = $(this).parent().hasClass("blog")?"blog":"forum";
			$("#tabed_module .tabContent #blog, #tabed_module .tabContent #forum").css("display","none");
			$("#tabed_module .tabContent #"+who).css("display","block");
		});
	};
	
	/* Switching feeds */
	if($("#feedParser").length != 0){
		$("#feedParser .tabNav li a").bind("click",function(e){
			if(e.preventDefault) e.preventDefault();
			$("#feedParser .tabNav li a").parent().removeClass("selected");
			$(this).parent().addClass("selected");
			
			var who = $(this).attr("class");
			$("#feedParser .tabContent .feed").css("display","none");
			$("#feedParser .tabContent .feed#"+who).css("display","block");
			
		});
	};
	
});
