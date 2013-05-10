// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

function postHandler (res) {
	// var $res = $(res);
	var $res = $(res);
	var $err = $res.find('#error_explanation');

	if ($err.length) {
		$('#error_explanation').remove();
		$err.insertBefore('#new_pledge');
	}
	else {
		$('table.pledges tr:first').after($res);
		$('#new-pledge-link').next('.well').remove();
		$('#new-pledge-link').show();
	}
}
$(document).ready(function() {
	$(".close").click( function(e) {
		$(".close").parent().hide();
	});

	$(".profile-pic").load(function() {
		$(".profile-follow-btn input[type=submit]").width($(this).width() - 22);
		$(".profile-follow-btn input[type=submit]").height(25);
	});

	$('#new-pledge-link').click( function(e) {
		e.preventDefault();
		$well = $("<div class='well'>").
					load(this.href).
					insertAfter(this);
		$(this).hide();
		$well.on('submit', '#new_pledge',
			function (e) {
				e.preventDefault();

				var body = $(this).serialize();
				$.post(this.action, body, postHandler);
			});
	});
});