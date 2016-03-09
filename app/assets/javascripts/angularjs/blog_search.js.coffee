@app.controller 'BlogSearchController', ['$scope', '$http', '$window', ($scope, $http, $window)->

  $scope.search = ()->
    $window.location.href = '/blogs/search/?q=' + $scope.q + '&blog_type=' + encodeURIComponent($scope.blog_type)

  $scope.select_blog_type = (type)->
    $scope.blog_type = type
    $scope.search()

  $scope.is_selected_blog_type = (type)->
    $scope.blog_type == type
]