@app.controller('CategoryUploaderController', ['$scope', '$http', '$upload', ($scope, $http, $upload)->
  $scope.upload_photo = ($files)->
    $scope.photo_error = null
    for file in files
      $upload.upload
        url: '/avatars'
        post: 'POST'
        data:
          user_id: $scope.category_id
        file: file
        .success (res)->
          if res.success
            $scope.photo = res.url
          else
            $scope.photo_erro = res.message
        .error ()->
          console.log '上传失败'
])