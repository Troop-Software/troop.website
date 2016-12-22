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
//= require jquery.tagsinput
//= require jquery.validate.min
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
        header: {
            left: 'title',
            center: 'month agendaWeek agendaDay',
            right: 'today prev,next'
        },
        eventSources: [

        // your event source
        {
            url: '/events?search="troop meeting', 
            color: 'blue',    
            textColor: 'white' 
        },
        {
            url: '/events?search=campout',
            color: 'green',    
            textColor: 'white'  
        },
        {
            url: '/events?search=outing',
            color: 'yellow',    
            textColor: 'black'  
        },
        {
            url: '/events?search=plc',
            color: 'red',    
            textColor: 'white'  
        },
        {
            url: '/events?search="committee meeting',
            color: 'grey',    
            textColor: 'white'  
        },
        {
            url: '/events?search="service project',
            color: 'orange',    
            textColor: 'black'  
        },
        {
            url: '/events?search=training',
            color: 'pink',    
            textColor: 'black'  
        },
        {
            url: '/events?search=other',
            color: 'black',    
            textColor: 'white'  
        }
    ]
    });

    $('.datetimepicker').datetimepicker({
        icons: {
            time: "fa fa-clock-o",
            date: "fa fa-calendar",
            up: "fa fa-chevron-up",
            down: "fa fa-chevron-down",
            previous: 'fa fa-chevron-left',
            next: 'fa fa-chevron-right',
            today: 'fa fa-screenshot',
            clear: 'fa fa-trash',
            close: 'fa fa-remove'
        }
    });

    $('.datetimepickeryear').datetimepicker({
        viewMode: 'years',
        icons: {
            time: "fa fa-clock-o",
            date: "fa fa-calendar",
            up: "fa fa-chevron-up",
            down: "fa fa-chevron-down",
            previous: 'fa fa-chevron-left',
            next: 'fa fa-chevron-right',
            today: 'fa fa-screenshot',
            clear: 'fa fa-trash',
            close: 'fa fa-remove'
        }
    });

    $(".alert" ).fadeOut(5000);

});

