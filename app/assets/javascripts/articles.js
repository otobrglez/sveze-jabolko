$(function(){
	
	function split( val ) {
		return val.split( /,\s*/ );
	};
	
	function extractLast( term ) {
		return split( term ).pop();
	};

	
	if($("form ul#article #article_tag_list").length != 0){
		$("form ul#article #article_tag_list").bind( "keydown", function( event ) {
			if ( event.keyCode === $.ui.keyCode.TAB &&
				$(this).data("autocomplete").menu.active){
					event.preventDefault();
			}
		}).autocomplete({
			source: function( request, response ) {
				$.getJSON( "/admin/tags/search.json", {
					term: extractLast( request.term )
				}, response );
			},
			search: function() {
				// custom minLength
				var term = extractLast( this.value );
				if(term.length<2) return false;
			},
			focus: function() {
				// prevent value inserted on focus
				return false;
			},
			select: function( event, ui ) {
				var terms = split( this.value );
				terms.pop();
				terms.push( ui.item.value );
				// add placeholder to get the comma-and-space at the end
				terms.push('');
				this.value = terms.join( ", " );
				return false;
			}
		});
		
	};
});