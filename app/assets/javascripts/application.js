// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require tether
//= require bootstrap
//= require_tree .
var Kernel = {
  'exec': function(controller, action) {
    try {
      eval('window.' + controller + '.' + action + '()');
    } catch (e) {
    }
  },

  'init': function() {
    var body       = document.body;
    var controller = body.getAttribute("data-controller");
    var action     = body.getAttribute("data-action");
    Kernel.exec(controller, action);
  }
};

$(document).ready(function() {
  Kernel.init();
  ReactRailsUJS.mountComponents();
});
