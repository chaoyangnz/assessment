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
//= require template
//= require audio
//= require jquery.uploadify
//= require bootstrap-wysihtml5


//= require plugins/jquery.clippy
//= require plugins/jquery.countdown

//= require papers
//= require parts
//= require nodes
//= require organizations
//= require members
//= require dashboard

//= require tests
//= require solutions


//= require rails.validations
//= require rails.validations.simple_form

// Put your application scripts here
$(function() {

// avoid double-click: disable and clear error message
$("form").on('ajax:before', function(e) {
    var element = $(this);
    element.find('.form-field-error').remove()
    element.find('.error').removeClass('error')

    element.find("[type=submit]").button('loading')
})

// avoid double-click: enable again
$("form").on('ajax:complete', function(e) {
    var element = $(this);
    element.find("[type=submit]").button('reset')
})

$('.rich-editor').wysihtml5({"image": false});

// enable popover
$('[rel="popover"]').popover()


//使得select 元素的placeholder成为默认选项
// http://stackoverflow.com/questions/5805059/select-placeholder
$('form select[placeholder]').each(function() {
    var select = $(this)
    var placeholder = select.attr('placeholder')
    $('<option value="" disabled="disabled" style="">' + placeholder + '</option>').prependTo(select);
})

audiojs.events.ready(function() {
    var as = audiojs.createAll();
});

// Use the modernizr.load() function to run polyfills for older browsers.
Modernizr.load([{
    test: Modernizr.input.placeholder,
    nope: [
        '/assets/polyfills/jquery.placeholder.js'
    ],
    callback: {
        "jquery.placeholder.js": function () {
            alert(11)
            $('input[placeholder],textarea[placeholder]').placeholder({
                useNative: false,
                hideOnFocus: false,
                style: {
                    textShadow: 'none'
                }
            });
        }
    }
}]);

}); //END-OF-JQUERY-READY


