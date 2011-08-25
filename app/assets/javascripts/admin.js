/* Admin JS */

$(function(){
	
	if($("form ul#article").length != 0){
		$("#content-tabs").tabs();
		$("#content-tabs").bind("tabsselect", function(event, ui){
			var content = "";

			if(ui.index == 1){
				content=$("textarea#article_intro").val();
				$.getJSON('/admin/articles/preview.js',
					{content: content},
					function(data){
						$("#intro-preview .body").html(data.content);
					});
			};

			if(ui.index == 3){
				content=$("textarea#article_body").val();
				$.getJSON('/admin/articles/preview.js',
					{content: content},
					function(data){
						$("#article-preview .body").html(data.content);
					});
			};
		});
	};
	
	if($("a[data-method=delete]").length != 0){
		$("a[data-method=delete]").bind("click",function(e){
			e.preventDefault();
			return confirm("Hej bimbo, res želiš odstraniti vsebino?");
		});
	};
	
});