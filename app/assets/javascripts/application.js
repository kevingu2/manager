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
//= require jquery-ui
//= require turbolinks
//= require_tree .

function resetNotification(user_id, path){
    var notify_div=document.getElementById('circle');
    notify_div.parentNode.removeChild(notify_div);
    var params = "{'user_id':"+user_id+"}";
    params=params.replace(/'/g, '"');

    //AJAX request
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.open("Content-length", params.length);
    xmlHttp.open("Connection", "close");
    xmlHttp.open( "Post", path, true );
    xmlHttp.send(params);
}

window.onload = function() {
  createScroll();
};

$(function createScroll (){
    $('#notification-scroll').slimScroll({
        height: '330px',
        width: '300px'
    });
});
