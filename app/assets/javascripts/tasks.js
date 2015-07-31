function deleteOpt (id){
    console.log("delete Oppty")
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
    xmlHttp.open( "Get", "http://localhost:3000/tasks/deleteOpportunity?id="+id , false );
    xmlHttp.send(null);


}