$(document).ready(function() {
   
   var initializePickers = function() {
      $('.datepicker-on').pickadate();
      $('.timepicker-on').pickatime();
   };
    
   initializePickers();
   $('#events').on('cocoon:after-insert', initializePickers);

});