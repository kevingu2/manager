function deleteOptManager (id, nameOfRowCount, index){
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4) {
            if(xmlHttp.responseText==="OK"){
                document.getElementById(id).remove();
                /*alert(nameOfRowCount);
                alert(nameOfRowCount.innerText);*/
                var count = Number(nameOfRowCount.innerText.substring(0, 1));
                /*alert(count);*/
                nameOfRowCount.innerText = "" + (count-1) + " tasks";
                changeTasksColor(count-1,nameOfRowCount.id);
            }
        }
    }

    xmlHttp.open("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.open("Connection", "close");
    xmlHttp.open("delete", "/allocated_tasks/deleteOpportunity?id="+id , true );
    xmlHttp.send(null);
}

function confirmDeleteManager(id, nameOfRowCount, index){
    r=window.confirm("Are you sure you want to delete this task?");
    if (r == true) {
        deleteOptManager(id, nameOfRowCount, index);
    }
}

function swap(targetId){
    if (document.getElementById(targetId)){
        target = document.getElementById(targetId);
        if (target.style.display == "none"){
            target.style.display = "";
        } else{
            target.style.display = "none";
        }
    }
}

function changeTasksColor (count, nodeName) {
    if (count >= 5) {
        document.getElementById(nodeName).style.backgroundColor = 'red';
        document.getElementById(nodeName).style.border = '1px solid white';
    } else if (count >= 3) {
        document.getElementById(nodeName).style.backgroundColor = '#FED000';
        document.getElementById(nodeName).style.border = '1px solid white';
    } else {
        document.getElementById(nodeName).style.backgroundColor = 'green';
        document.getElementById(nodeName).style.border = '1px solid white';
    } 
}
