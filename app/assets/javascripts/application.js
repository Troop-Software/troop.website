// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.tagsinput
//= require tether
//= require moment
//= require bootstrap
//= require bootstrap-datetimepicker
//= require fullcalendar
//= require material-dashboard
//= require_tree .

$(document).ready(function () {
    //=$('.has-tooltip').tooltip();
    $('.has-popover-click').popover({
        html: true,
        trigger: 'click'
    });
    $('.has-popover-hover').popover({
        html: true,
        trigger: 'hover'
    });
});

$(document).ready(function () {
    $(".nav-tabs a").click(function (event) {
        event.preventDefault();
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(".tab-pane").not(tab).css("display", "none");
        $(tab).fadeIn();
    });

    $('#calendar').fullCalendar({
        events: '/events.json',
        header: {
            left: 'title',
            center: 'month agendaWeek agendaDay',
            right: 'today prev,next'
        }
    })

    $('.datetimepicker').datetimepicker();
    $('.datetimepickeryear').datetimepicker({viewMode: 'years'});

});