/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
   $('.calendar .cal-nav, .calendar .collapser').hide();
   calendarParent = $('.calendar');
   
   calHiddenBottom = -1 * calendarParent.height() + 20;
   
   calendarParent.css('bottom', calHiddenBottom);

   var currentDiv = $('.footer>.preview>.production-div').hide();
   var currentIn = function() { currentDiv.slideDown('fast'); };
   var currentOut = function() { currentDiv.slideUp('fast'); };

   expand = function() {
      _this = $(this);
      currentDiv.hide();
      
      $('.has-event>a').last().click();
      $('.calendar').addClass('calendar-expanded')
                    .css('top', null)
                    .animate({ 'bottom' : '2em', 'top' : 'inherit' }, function() {
                       collapser.show();
                       expander.hide();
                       $('.cal-nav').fadeIn(function() {
                           $('.cal-nav').css('display', 'inline');
                       });  
      });
   };
   
   collapse = function() {
      _this = $(this);
      $('#production-page').remove();
      $('.calendar').removeClass('calendar-expanded')
                    .animate({ 'bottom' : calHiddenBottom + 'px' }, function() { 
                        $('.cal-nav').fadeOut(function() {
                            collapser.hide();
                            expander.show();
                        });
                        $('.collapser').show();
      });
   };
   
   expander = $('.calendar .expander').hover(currentIn, currentOut)
                                      .click(expand);
   collapser = $('.calendar .collapser').click(collapse);

});