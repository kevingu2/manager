function deleteOptManager (id){
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
    xmlHttp.open( "delete", "http://localhost:3000/allocated_tasks/deleteOpportunity?id="+id , true );
    xmlHttp.send(null);
    //document.getElementById(id).remove();
}