/* Admin JS */

$(function(){
	
	if($("form ul#article").length != 0){
		
		$("#content-tabs").tabs();
		$("#content-tabs").bind("tabsselect", function(event, ui){
			if(ui.index == 2){
				var content=$("textarea#article_body").val();
				$.getJSON('/admin/articles/preview.js',
					{content: content},
					function(data){
						$("#article-preview .body").html(data.content);
					});
				
			};
		});
		
	};
	
});