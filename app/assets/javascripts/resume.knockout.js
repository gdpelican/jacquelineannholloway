$(document).ready(function() {
	
    $('#resume').on('click', '.resume-menu-link', function() {
    	var _this = $(this);
    	_this.closest('.resume-menu').find('li').remove(_this.parent()).removeClass('selected');
    	_this.parent().addClass('selected');
		
		$('#resume').find('.resume').hide();
		$('#resume').find('.resume[data-id=' + _this.attr('data-resume') + ']').show();
	}).on('click', '.new-resume-link>a', function() {
		var _this = $(this);
		_this.slideUp(function() { _this.siblings('form').slideDown(); });
	});
	$('.resume-menu-link').first().parent().addClass('selected');
	
	var Knockout = {
		viewModel: null,
		
		initializeViewModel: function(json, authed) {
			this.viewModel = new this.ResumeModel(json, authed);
			ko.applyBindings(this.viewModel);
			$('#resume .resume').first().show();
		},
		
		ResumeModel: function(json, authed) {
			this.resumes = ko.observableArray(Knockout.Factory.getChunks(json, authed));
		},
		
		Factory: {
			getChunk: function(chunk, authed) {
				return new Knockout.Chunk(chunk, authed);
			},
			
			getChunks: function(chunkArray, authed) {
				var result = [];
				for(var i = 0; i < chunkArray.length; i++)
					result.push(this.getChunk(chunkArray[i], authed));
				return result;
			},
			
			getBlankChild: function(chunk) {
				var childType;
				switch(chunk.type) {
					case 'resume': 	childType = 'section'; break;
					case 'section': childType = 'line'; break;
					case 'line': 	childType = 'item'; break;
					default:		childType = null; break;
				};
				return this.getChunk(this.getBlankChunk(childType, chunk.rowSize(), chunk.authed), chunk.authed);	
			},
			
			getBlankChunk: function(type, rowSize, authed) {
				var children = [];
				switch(type) {
					case 'section':						
						children.push(Knockout.Factory.getBlankChunk('line', rowSize, authed));
						break;
					case 'line':
						for(var i = 0; i < rowSize; i++)
							children.push(Knockout.Factory.getBlankChunk('item', rowSize, authed));
						break;
				}
				
				return { type: type, 
						 authed: authed,
						 children_json: children };
			}
			
		},
		
		Chunk: function(chunk, authed) {
			
			this.id = chunk.id;
		    this.authed = authed;
			this.type = chunk.type;
		    this.active = ko.observable(chunk.active);
		    this.styles = ko.observable((chunk.styles) ? chunk.styles : '');
		    this.text = ko.observable(chunk.text);
		    this.fontSize = ko.observable((chunk.styles && chunk.styles.match(/font-[0-9]+/)) ? chunk.styles.match(/font-[0-9]+/)[0].replace('font-', '') : "12");
		   	this.fontSize.subscribe(function(newValue) { 
		   		if(this.styles().indexOf('font-') > -1)
		   			this.styles(this.styles().replace(/font-[0-9]+/, 'font-' + newValue));
		   		else
		   			this.styles(this.styles() + 'font-' + newValue);
		   	}, this);
		   	this.rowSizeSelectValue = ko.observable(3);
		    
			this.destroyed = ko.observable(false);
	    	this.children = ko.observableArray(Knockout.Factory.getChunks(chunk.children_json, this.authed));	
		    
		    this.showEdit = ko.observable(false);
		    this.showHighlight = ko.observable(false);
			this.dragging = ko.observable(false);
			this.editing = ko.observable(false);
		    
		    this.template = ko.computed(function() { 	return (this.type == 'line') ? 'itemTemplate' : 'chunkTemplate'; }, this);
		    this.editable = ko.computed(function() { 	return this.authed && (this.type == 'section' || this.type == 'line'); }, this);
		    this.identifier = ko.computed(function() { 	return (this.id) ? this.type + '-' + this.id : ''; }, this);
			this.exportLink = ko.computed(function() { 	return '/resume/' + this.type + '/' + this.id + '.pdf'; }, this);					
			this.item_class = ko.computed(function() { 	return 'item ' + (this.authed ? ' authed-item' : ''); }, this);
			this.edit_class = ko.computed(function() {	return (this.authed) ? 'edit-pane edit-' + this.type + ((this.type == 'section') ? ' faded-medium' : '') : ''; }, this);
			this.css_class = ko.computed(function() { 
			    var 							css_class = ' chunk';
				if(this.styles() != null) {		css_class += ' ' + this.styles(); }
					    						
			    if(this.type == 'item')	{		css_class += ' item-wrapper'; }
				else					{		css_class += ' ' + this.type; };
			    
			    if(this.type == 'line')	{		css_class += ' row-of-' + this.children().length; };
			    if(this.authed) {				css_class += ' authed-' + this.type;
			    	if(this.editable())	{		css_class += ' draggable'; };
			    	if(this.dragging()) {		css_class += ' dragging'; }; 
			    	if(this.showHighlight()) {  css_class += ' edit-selection'; }
			    	if(this.editing()) {		css_class += ' editing'; } };
			    	
			    return css_class.replace(/\s+/g, ' ');
			}, this);
		   	
		   	this.rowSize = ko.computed(function() {
		   		var children = this.children();
		   		switch(this.type) {
		   			case 'resume':  return this.rowSizeSelectValue();
		   			case 'section': return (children.length > 0) ? children[0].rowSize() : null;
		   			case 'line':    return children.length;
		   			default: 		return null;
		   		};
		   	}, this);
		   	
		   	this.childType = ko.computed(function() {
		   		switch(this.type) {
		   			case 'resume': 	return 'section';
		   			case 'section': return 'line';
		   			case 'line': 	return 'item';
		   			default: 		return null;
		   		};
		   	});
		   				
			this.rowSizes = [1, 2, 3, 4, 5, 6];
			this.fontSizes = [9, 10, 11, 12, 14, 16, 18, 20, 24, 30, 36, 48, 60];

			this.hasStyle = function(style) { return 'style-button' + (this.styles().indexOf(style) > -1 ? ' selected' : ''); };
			this.editStyle = function(chunk, event) { 
				newStyle = event.currentTarget.dataset.style;
				styleComps = newStyle.split('-');
				currentStyles = (this.styles() != null) ? this.styles() : '';
				
				if(styleComps[1] != null) {
					if(currentStyles.indexOf(newStyle) == -1) {
						currentStyles = currentStyles.replace(new RegExp(styleComps[0] + "-[a-z]+"), '');
						currentStyles += ' ' + newStyle;
					}
					else
						currentStyles = currentStyles.replace(newStyle, '');
				}
				else {
					(currentStyles.indexOf(styleComps[0]) > 0)
						? currentStyles = currentStyles.replace(styleComps[0], '')
						: currentStyles += ' ' + (styleComps[0]);
				}
				
				chunk.styles(currentStyles);	
			};
						
			this.destroy = function(chunk, event) {
				if(chunk.type == 'resume' && confirm("Are you sure you want to destroy this resume? This cannot be undone.")) {
					$.post('/resume/resume/' + chunk.id + '/destroy');
					this.destroyed(true);
				}
				else {
					$(event.currentTarget).closest('.chunk').slideUp();
					this.destroyed(true);
				}
			};
			
			this.append = function(chunk) {
				this.children.push(Knockout.Factory.getBlankChild(chunk));
			};
			
			this.swap = function(chunk, event) {
				
			};
			
			this.save = function(chunk, event) {
				var notice = $('.flash-notice');
				notice.text('Saving...').fadeIn();
				var closeNotice = function(message, error) {
					if(error) {
						notice.hide();
						notice = $('.flash-error').show();
					}
					notice.text(message);
					setTimeout(function() { notice.fadeOut(); }, 1500);
				};

				$.ajax({
					type: 'POST',
					url: '/resume/' + chunk.type + '/' + chunk.id + '/save.json', 
					data: { resume: this.toJSON() },
					success: function(data) { closeNotice(data); },
					error: function(data) { closeNotice(data, true); }
				});
			};
			
			var inDraggingMode = function(parents) {
					for(var i = 0; i < parents.length-1; i++)
						if(!parents[i].authed || parents[i].dragging())
							return true; 	
					return false;		
			};
			
			this.toggleActive = function() {
				if(this.authed && this.type == 'resume')
					this.active(!this.active());
			};
			this.toggleHighlight = function(parents) {
				if(this.authed && this.type == 'item' && !inDraggingMode(parents))
					this.showHighlight(!this.showHighlight());
			};
			this.toggleEditing = function(event, parents) {
				if(this.authed && !inDraggingMode(parents)) {
					this.editing(!this.editing());
					(event.currentTarget.value)
						? this.text(event.currentTarget.value)
						: $(event.currentTarget).siblings('input').focus();
				}
			};

			this.toggleDrag = function(chunk) { if(chunk.authed) chunk.dragging(!chunk.dragging()); };
			this.toggleEdit = function(chunk) { if(chunk.authed) chunk.showEdit(!chunk.showEdit()); };			
			
			this.toJSON = function(index) {
				var json = { id: this.id, type: this.type };
				var children = [];
				
				for(var i = 0; i < this.children().length; i++)
					children.push(this.children()[i].toJSON(i));
				
				if(this.type == 'resume')
					$.extend(json, { active: this.active() });
				else
					$.extend(json, { styles: this.styles(), destroyed: this.destroyed(), order: index });
				
				if(this.type == 'item')
					$.extend(json, { text: this.text() });
				if(children.length > 0)
					$.extend(json, {children: children });
				
				return json;
			};
			
		}
		
	}; 
	window.Knockout = Knockout;
  
});