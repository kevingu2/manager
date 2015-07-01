
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope) {
    $scope.firstName= "Sara";
    $scope.lastName= "Farsi";
    $scope.posts = [
        {title: 'post 1', upvotes: 5},
        {title: 'post 2', upvotes: 2},
        {title: 'post 3', upvotes: 15},
        {title: 'post 4', upvotes: 9},
        {title: 'post 5', upvotes: 4}
    ];
    $scope.addPost = function(){
        if(!$scope.title || $scope.title === '') {
            alert("Please Enter a Post Name");
            return;
        }
        $scope.posts.push({title: $scope.title, upvotes: 0});
        $scope.title = '';
    };
});