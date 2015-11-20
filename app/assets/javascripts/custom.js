$(document).on("ready", function(){
	if($(window).width > 767)
	{
		$(".navbar-nav > li > a").click(function(){
			$("#bs-example-navbar-collapse-1").removeClass("in");										 
		});
	}		
	$(".btn-red2").click(function(){
		$("body").toggleClass("bdyfixed");
	});
});
