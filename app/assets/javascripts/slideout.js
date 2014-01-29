/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
   	var EventSlideOut = {
   		map: null,
   		latlng: null,
   		
		initializeEvents: function() {
   			$('.calendar').on('click', '.production-close i', function() { 
   				$('#event-slideout').children().remove();
   			}).on('click', '.production-option', function() {
   				var _this = $(this);
   				var _master = $(this).closest('#production-page'); 
   					   		
		   		if(!_this.hasClass('faded-medium')) {
			   		_this.toggleClass('faded-medium faded-light');
			   		_this.siblings().addClass('faded-light').removeClass('faded-medium');

			   		_master.find('.production-pane').hide();
			   		_master.find('.' + _this.attr('rel')).show();
			   		_master.find('.production-container').jScrollPane({ autoReinitialise: true });
		   		} 
		   	}).on('click', '.production-option[rel=production-map]', EventSlideOut.initializeMap);
      	},
      	
      	initializeMap: function() {
      		if(typeof(google.maps) === 'undefined')
      			$.getScript('http://maps.google.com/maps/api/js?sensor=false&callback=EventSlideOut.initializeMap');
      		else if(EventSlideOut.map == null && $('#map').length && $('#latlng').length) {
      			var latlng = $('#latlng').html().split(';');
      			EventSlideOut.latlng = new google.maps.LatLng(latlng[0], latlng[1]);
    			EventSlideOut.map = new google.maps.Map(document.getElementById('map'), {
								      zoom: 17,
								      mapTypeId: google.maps.MapTypeId.ROADMAP,
								      disableDefaultUI: true,
								      mapTypeControl: false
								    });
				google.maps.event.addListenerOnce(EventSlideOut.map, 'idle', function(){
			      	var marker = new google.maps.Marker({
			        	position: EventSlideOut.latlng,
			        	map: EventSlideOut.map 
			        });
    			});
    			EventSlideOut.refreshMap();
      		}
      		else if(EventSlideOut.map != null)
      			EventSlideOut.refreshMap();
      	},
      	     	
      	resetMap: function() {
      		this.map = null;
      		this.latlng = null;
      		EventSlideOut.initializeMap();
      	},
      	
      	refreshMap: function() {
      		google.maps.event.trigger(EventSlideOut.map, "resize");
      		EventSlideOut.map.setCenter(EventSlideOut.latlng);	
      	}
      	
   	};
   	
   	EventSlideOut.initializeEvents();
   	window.EventSlideOut = EventSlideOut;
});