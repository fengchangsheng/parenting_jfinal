/***************************************************
			SUPER FISH MENU
***************************************************/
jQuery.noConflict()(function($){
$(document).ready(function() {
   $("ul.sf-menu").superfish({ 
            pathClass:  'current',
			autoArrows	: false,
			delay:300,
			speed: 'normal',
			animation:   {opacity:'show'}

        }); 


    });

/***************************************************
					Flickr
***************************************************/
	
	$('#cbox').jflickrfeed({
		limit: 9,
		qstrings: {
			id: '47257185@N03'
		},
		itemTemplate: '<li>'+
						'<a rel="colorbox" href="{{image_b}}" title="{{title}}">' +
							'<img src="{{image_s}}" alt="{{title}}" />' +
						'</a>' +
					  '</li>'
	}, function(data) {
		$('#cbox a').colorbox();
	});
	
/* Sidebar widget */	
	$('#cbox-sidebar').jflickrfeed({
		limit: 9,
		qstrings: {
			id: '47257185@N03'
		},
		itemTemplate: '<li>'+
						'<a rel="colorbox" href="{{image_b}}" title="{{title}}">' +
							'<img src="{{image_s}}" alt="{{title}}" />' +
						'</a>' +
					  '</li>'
	}, function(data) {
		$('#cbox-sidebar a').colorbox();
	});
	
});

/***************************************************
					Item ColorBox
***************************************************/
jQuery.noConflict()(function($){
$('#slider-item a').colorbox({rel:'project-item'});
});

/***************************************************
			Item ColorBox - Recent Projects
***************************************************/
jQuery.noConflict()(function($){
$(document).ready(function() {	
	$('.mask a[data-rel="zoom-img"]').colorbox();
	});	
});

/***************************************************
					Twitter
***************************************************/
jQuery.noConflict()(function($){
$(document).ready(function() {

	
	  /*---- Footer Twitter----*/
	  $("#footer .tweet").tweet({
        	count: 3,
        	username: "zesky",
        	loading_text: "loading twitter..."      
		});

	  /*---- Sidebar Twitter ----*/
	  $("#twitter-widget .tweet").tweet({
        	count: 3,
        	username: "envato",
        	loading_text: "loading twitter..."      
		});

	  /*---- Homepage Twitter ----*/
	  $("#top-gag .tweet").tweet({
        	count: 1,
        	username: "zesky",
        	loading_text: "loading twitter..."      
		});

	 });
});