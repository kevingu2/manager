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
    console.log("Assign");
    console.log("Oppty_id: "+oppty_id+"   user_id: "+oppty_id);
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
    console.log("Unassign");
    console.log("Oppty_id: "+oppty_id+"   user_id: "+oppty_id);
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

function search_not_assigned(oppty_id){
    var role=document.getElementById("sorting_not_assigned").value;
    var searchValue=document.getElementById("search_not_assigned").value;
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4) {
            var user_data=JSON.parse(xmlHttp.responseText);
            var outer_not_assigned=document.getElementById("outer-not-assigned-row");
            while (outer_not_assigned.firstChild) {
                outer_not_assigned.removeChild(outer_not_assigned.firstChild);
            }
            for(var key in user_data){
                    var user_div = document.createElement('div');
                    user_div.setAttribute('class', 'col-md-12 not-assigned-row');
                    user_div.setAttribute('id', user_data[key].id);
                    var name_div=document.createElement('div');
                    name_div.setAttribute('class', 'col-md-6 row-item');
                    user_div.appendChild(name_div);
                    var name_p=document.createElement('p');
                    name_p.setAttribute('class', 'name');
                    name_p.innerHTML=user_data[key].name +" ("+user_data[key].role+")";
                    name_div.appendChild(name_p);
                    var button_div=document.createElement('div');
                    button_div.setAttribute('class', 'col-md-6 row-item');
                    user_div.appendChild(button_div);
                    var img=document.createElement('img');
                    img.setAttribute('class', 'plus');
                    img.onclick=function(){assign(oppty_id, user_data[key].id)};
                    img.src='/assets/plus_btn.png';
                    img.alt='+';
                    img.border='0';
                    button_div.appendChild(img);
                    outer_not_assigned.appendChild(user_div);
            }
        }
    }
    xmlHttp.open("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.open("Connection", "close");
    xmlHttp.open( "Get", '/assign/searchNotAssigned?role='+role+"&opptyId="+oppty_id+"&search="+searchValue, true );
    xmlHttp.send( null );

}
function search_assigned(oppty_id){
    var role=document.getElementById("sorting_assigned").value;
    var searchValue=document.getElementById("search_assigned").value;
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4) {
            var user_data=JSON.parse(xmlHttp.responseText);
            var outer_assigned=document.getElementById("outer-assigned-row");
            while (outer_assigned.firstChild) {
                outer_assigned.removeChild(outer_assigned.firstChild);
            }
            for(var key in user_data){
                var user_div = document.createElement('div');
                user_div.setAttribute('class', 'col-md-12 assigned-row');
                user_div.setAttribute('id', user_data[key].id);
                var name_div=document.createElement('div');
                name_div.setAttribute('class', 'col-md-6 row-item');
                user_div.appendChild(name_div);
                var name_p=document.createElement('p');
                name_p.setAttribute('class', 'name');
                name_p.innerHTML=user_data[key].name +" ("+user_data[key].role+")";
                name_div.appendChild(name_p);
                var button_div=document.createElement('div');
                button_div.setAttribute('class', 'col-md-6 row-item');
                user_div.appendChild(button_div);
                var img=document.createElement('img');
                img.setAttribute('class', 'redx');
                img.onclick=function(){unassign(oppty_id, user_data[key].id)};
                img.src='/assets/redx.png';
                img.alt='+';
                img.border='0';
                button_div.appendChild(img);
                outer_assigned.appendChild(user_div);
            }
        }
    }
    xmlHttp.open("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.open("Connection", "close");
    xmlHttp.open( "Get", '/assign/searchAssigned?role='+role+"&opptyId="+oppty_id+"&search="+searchValue, true );
    xmlHttp.send( null );

}