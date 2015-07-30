/**
 * Created by kevingu on 7/30/15.
 */

//= require Sortable

var list1 = document.getElementById("list1");
Sortable.create(list1,{ group: "movable",
    onAdd: function (/**Event*/evt) {
        var itemEl = evt.item;  // dragged HTMLElement
        var list=evt.to.id
        var id=evt.item.getElementsByTagName( 'li')[0].id;
        updateUserOppties(id, list);
    }}
);
var list2 = document.getElementById("list2");
Sortable.create(list2,{ group: "movable",
    onAdd: function (/**Event*/evt) {
    var itemEl = evt.item;  // dragged HTMLElement
    var list=evt.to.id
    var id=evt.item.getElementsByTagName( 'li')[0].id;
    updateUserOppties(id, list);
}});
var list3 = document.getElementById("list3");
Sortable.create(list3,{ group: "movable",
    onAdd: function (/**Event*/evt) {
    var itemEl = evt.item;  // dragged HTMLElement
    var list=evt.to.id
    var id=evt.item.getElementsByTagName( 'li')[0].id;
    updateUserOppties(id, list);
}});
var list4 = document.getElementById("list4");
Sortable.create(list4,{ group: "movable",
    onAdd: function (/**Event*/evt) {
        var itemEl = evt.item;  // dragged HTMLElement
        var list=evt.to.id
        var id=evt.item.getElementsByTagName( 'li')[0].id;
        updateUserOppties(id, list);
}});

function updateUserOppties(id, list){
    var status;
    if(list == "list1") {
        status=3;
    }
    if(list == "list2") {
        status=2;
    }
    else if (list == "list3") {
        status=1;
    }
    else if (list == "list4") {
        status=0;
    }
    var params = "{'id':"+id + ",'status':"+status+"}";
    params=params.replace(/'/g, '"');
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("Content-Type", "application/x-www-form-urlencoded");
    xmlHttp.open("Content-length", params.length);
    xmlHttp.open("Connection", "close");
    xmlHttp.open( "Put", 'http://localhost:3000/tasks/updateStatus' , true );
    xmlHttp.send( params );
    // + indexes from onEnd
}