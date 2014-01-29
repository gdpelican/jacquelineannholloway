$(document).ready(function() {
   
    var _this = this;
    _this.currentIndex = 1;
    
    _this.slider = {
		parent : null,
		header : null,
		footer : null,
        init : function(parent, header, footer, index) {
            this.parent = parent;
            this.header = header;
            this.footer = footer;
            if(this.slideWidth != $(window).width() || this.slideHeight != $(window).height()) {
                this.slideWidth = $(window).width();
                this.slideHeight = $(window).height();
                $('.slide', this.parent).width(this.slideWidth)
                                        .height(this.slideHeight);
                $('.slide-content', this.parent).height(this.slideHeight);

                this.slide(index);
            }
        },

        slide : function(index) {
            this.position = (index-1) * this.slideWidth + 1;
            this.parent.animate({'right' : this.position + 'px'});
            
            _this.currentIndex = index;
			
			var anchors = this.footer.find('.slide-anchor');
            var selected = this.footer.find('.slide-anchor[rel=' + index + ']');
            anchors.removeClass('selected');
            selected.addClass('selected');
            
           	this.footer.find('.slide-caption').html(selected.data('caption'));
            this.footer.find('.prev-slide-trigger').toggle(index > 1);
            this.footer.find('.next-slide-trigger').toggle(index < anchors.length);
            if(selected.data('caption') != null)
            	this.footer.find('.slide-caption, .hr-gradient').toggle(selected.data('caption').length > 0);
           	
           	this.header.find('.background-edit-trigger').attr('href', '/backgrounds/' + selected.data('background') + '/edit');
           	
        },
        
        toggleView : function() {
        	var _this = this;
        	this.header.find('.header-picture').slideToggle('slow');
        	
        	var footerSlide = function(selector1, selector2) {
        		_this.footer.find(selector1).slideToggle('slow', function() {
        			if($(selector1 + ':animated').length === 0)
        				_this.footer.find(selector2).slideToggle('slow');
        		});
        	};
        	
        	(this.footer.find('.slide-picture-blurb').is(':visible'))
        		? footerSlide('.slide-picture-blurb', '.slide-nav li')
        		: footerSlide('.slide-nav li', '.slide-picture-blurb');
        	
        	this.parent.find('.slide-content').fadeToggle('slow');
        	this.header.find('.social-item').toggleClass('flip-shape norm-shape');
        }
    
    };
    
    $(window).resize(function() {
        clearTimeout(this.timeout);
        this.timeout = setTimeout(onResize, 500);
    });
    $(window).resize();
    
    function onResize() {
        _this.slider.init($('.slide-container'), $('.header'), $('.footer'), _this.currentIndex);
    }
    
    $('.slide-anchor').click(function() { _this.slider.slide($(this).attr('rel')); });    
    $('.prev-slide-trigger').click(function() { _this.slider.slide(parseInt(_this.currentIndex)-1); });
    $('.next-slide-trigger').click(function() { _this.slider.slide(parseInt(_this.currentIndex)+1); });
    
    $('.current-show-anchor').click(function() {
    	$('.production-' + $(this).attr('rel') + '>a').first().click();
    	$('.expander').click();
    });
    
    $('.edit-config-trigger').click(function() { $(this).add($(this).siblings('.site_configuration')).slideToggle(); });
    
    $('.background-trigger').click(function() {
    	$(this).attr('title', $(this).hasClass('hide-background-trigger') ? 'Check out the background image!' : 'Go back!')
    		   .toggleClass('show-background-trigger hide-background-trigger foreground primary');
    	_this.slider.toggleView();
    });
        
    setTimeout(function() { $('.flash-notice, .flash-error').fadeOut(); }, 2000);
    
   	$('body').on('click', '.toggle-trigger', function() {
    	var _this = $(this);
    	_this.closest(_this.data('parent')).find(_this.data('selectors')).slideToggle();
    	var title = _this.data('title');
    	if(title) {
    		_this.data('title', _this.attr('title'));
    		_this.attr('title', title);
    	}
   	});
    
   	$('.drag-parent').on('click', '.drag-trigger', function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var trigger = $(this);
    	var parent = trigger.closest('.draggable');
    	var siblings = parent.siblings('.draggable');
    	var targets = parent.add(siblings);

    	parent.addClass('dragging');
    	
    	parent.on('click.draggable', function() {
    		$(this).removeClass('dragging');
    		parent.off('.draggable');
    	});
    	
    	/*siblings.each(function() {
    		var _sibling = $(this);
    		var toggleDragHover = function(e) {
    			(e.pageY > _sibling.offset().top + (_sibling.height() / 2))
    				? _sibling.addClass('drag-bottom-hover').removeClass('drag-top-hover') 
    				: _sibling.addClass('drag-top-hover').removeClass('drag-bottom-hover');
    		};
    		_sibling.on('mouseenter.draggable', function() { _sibling.on('mousemove.draggable', toggleDragHover); });
    		_sibling.on('mouseleave.draggable', function() { _sibling.off('mousemove.draggable').removeClass('drag-bottom-hover drag-top-hover'); });
    		_sibling.on('click.draggable', function(e) {
        		var _this = $(this);
        		var direction = _this.hasClass('drag-top-hover') ? '/before': '/after';    			
    			
    			e.stopPropagation();
    			e.preventDefault();
    			
    			siblings.off('.draggable');
    			parent.removeClass('dragging');
	   			_this.addClass('swap-target').removeClass('drag-top-hover drag-bottom-hover');
    			_this.closest('.resume').addClass('waiting');
    			
    			trigger.attr('href', trigger.attr('href').replace('target', _this.data('id') + direction));
    			$.rails.handleRemote(trigger);
    		});
    	});*/
    	
    });
});