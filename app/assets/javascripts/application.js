// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/sortable
//= require foundation
//= require ckeditor/init
//= require jquery_nested_form
//= require punymce/puny_mce

$(function(){ $(document).foundation(); });

function resizeDiv() {
  vpw = $(window).width();
  vph = $(window).height();
  $('.title-card').css({'height': vph + 'px'});
}

function scrollTo(target) { 
  $('html, body').stop().animate({
      'scrollTop': $(target).offset().top - 40
  }, 900, 'swing', function () {
      window.location.hash = target;
  });
  return false;
}