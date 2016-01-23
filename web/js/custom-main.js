/***************************************************
			CUSTOM SCRIPTS FOR MHOME PAGE
***************************************************/




/***************************************************
			CarouFredSel
***************************************************/
jQuery.noConflict()(function($){
$("#cl-carousel").carouFredSel({
    auto        : false,
    width		: 480,
    height		: 106,
    scroll		: {
    	items		: 2,
    	duration    : 500
/*    	fx			: "fade"*/
    },
	prev    : {
        button  : "#cl-carousel_prev",
        key     : "left"
    },
    next    : {
        button  : "#cl-carousel_next",
        key     : "right"
    }

	});
	
$("#rp-carousel").carouFredSel({
	circular: false,
    infinite: false,
    auto    : false,
/*    width		: 720,*/
    width		: 480,
    height		: 213,
    scroll		: {
    	items		: 2,
    	duration    : 500
    },
	prev    : {
        button  : "#rp-carousel_prev",
        key     : "left"
    },
    next    : {
        button  : "#rp-carousel_next",
        key     : "right"
    }
	});

$("#ra-carousel").carouFredSel({
	circular: false,
    infinite: false,
    auto    : false,
    width		: 480,
    height		: 213,
    scroll		: {
    	items		: 2,
    	duration    : 500
    },
	prev    : {
        button  : "#ra-carousel_prev",
        key     : "left"
    },
    next    : {
        button  : "#ra-carousel_next",
        key     : "right"
    }
	});

$("#testmain_carousel").carouFredSel({
    auto        : false,
    width		: 440,
    height		: "auto",
    items		: 1,
    scroll		: {
    	items		: 1,
    	fx			: "fade"
    },
    auto		: {
    	delay		: 3000,
    	pauseDuration : 5000
    }
	});

});
