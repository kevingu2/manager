$(function(){
    $('#outer-not-assigned-row').slimScroll({
        height: '336px'
    });
});

function assign(oppty_id, user_id){
    var params = "{'oppty_id':"+oppty_id + ",'user_id':"+user_id+"}";
    params=params.replace(/'/g, '"');
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.open("Content-length", params.length);
    xmlHttp.open("Connection", "close");
    xmlHttp.open( "Post", 'http://localhost:3000/assign/assignUser' , true );
    xmlHttp.send( params );

    var name = document.getElementById(user_id).cloneNode(true);
    document.getElementById(user_id).remove();
    var buttonElem=name.getElementsByTagName("button")[0];
    buttonElem.innerHTML="Unassign";
    buttonElem.className="btn btn-lg btn-primary btn-right un-assign-button";
    buttonElem.onclick=function (){unassign(oppty_id, user_id)};
    var assigned=document.getElementById('outer-assigned-row');
    assigned.appendChild(name);

}

function unassign(oppty_id, user_id){
    var params = "{'oppty_id':"+oppty_id + ",'user_id':"+user_id+"}";
    params=params.replace(/'/g, '"');
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.open("Content-length", params.length);
    xmlHttp.open("Connection", "close");
    xmlHttp.open( "Post", 'http://localhost:3000/assign/unAssignUser', true );
    xmlHttp.send( params );

    var name = document.getElementById(user_id).cloneNode(true);
    document.getElementById(user_id).remove();
    var buttonElem=name.getElementsByTagName("button")[0];
    buttonElem.innerHTML="Assign";
    buttonElem.className="btn btn-lg btn-primary btn-right assign-button";
    buttonElem.onclick=function(){assign(oppty_id, user_id)};
    var unassigned=document.getElementById('outer-not-assigned-row');
    unassigned.appendChild(name);
}
