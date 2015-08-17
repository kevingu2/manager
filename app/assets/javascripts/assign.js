$(function(){
    $('#outer-not-assigned-row').slimScroll({
        height: '330px',
        width: '250px'
    });
});

$(function(){
    $('#outer-assigned-row').slimScroll({
        height: '330px',
        width: '250px'
    });
});

function assign(oppty_id, user_id){
    var params = "{'oppty_id':"+oppty_id + ",'user_id':"+user_id+"}";
    params=params.replace(/'/g, '"');
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.open("Content-length", params.length);
    xmlHttp.open("Connection", "close");
    xmlHttp.open( "Post", '/assign/assignUser' , true );
    xmlHttp.send( params );

    var name = document.getElementById(user_id).cloneNode(true);
    document.getElementById(user_id).remove();
    var buttonElem=name.getElementsByTagName("img")[0];
    buttonElem.src='/assets/redx.png';
    buttonElem.class='redx';
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
    xmlHttp.open( "Post", '/assign/unAssignUser', true );
    xmlHttp.send( params );

    var name = document.getElementById(user_id).cloneNode(true);
    document.getElementById(user_id).remove();
    var buttonElem=name.getElementsByTagName("img")[0];
    buttonElem.class='plus';
    buttonElem.src='/assets/plus_btn.png';
    buttonElem.onclick=function(){assign(oppty_id, user_id)};
    var unassigned=document.getElementById('outer-not-assigned-row');
    unassigned.appendChild(name);
}
