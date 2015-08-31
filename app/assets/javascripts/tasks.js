function deleteOpt (id){
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4) {
            if(xmlHttp.responseText==="OK"){
                document.getElementById(id).remove();
            }
        }
    }
    xmlHttp.open("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.open("Connection", "close");
    xmlHttp.open( "delete", "/tasks/deleteOpportunity?id="+id , true );
    xmlHttp.send(null);
}

function confirmDelete(id){
    r=window.confirm("Are you sure you want to delete this task?");
    if (r == true) {
        deleteOpt(id);
    }
}