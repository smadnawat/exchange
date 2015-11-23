$(document).on("ready", function(){
	$("a").click(function(){
		$("#bs-example-navbar-collapse-1").removeClass("in");
	});
});

$(".btn-red2").on("click", function(){
	$("body").toggleClass("bdyfixed");
});