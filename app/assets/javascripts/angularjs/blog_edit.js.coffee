@app.controller 'BlogEditController', ['$scope', '$http', '$window', ($scope, $http, $window)->
  
  $scope.update_blog = (viewValue)->
    $http
      url: "/blogs"
      method: "POST"
      data: 
        blog: $scope.blog
    .success (res)->
      if res.success
        $window.location.href = '/blogs/'+res.id
      else
        alert res

]