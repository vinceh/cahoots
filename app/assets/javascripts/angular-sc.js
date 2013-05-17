'use strict';

var app = angular.module('cahoots', ['cahoots.services', 'cahoots.directives']);

function ScCtrl($scope, $location, Socialcard) {
  $scope.sc = new Socialcard();
  $scope.namePattern = /^\S+$/;
}

angular.module('cahoots.services', [], function ($provide) {
  $provide.factory('Socialcard', function ($http) {
    var Socialcard = function (data) {
      this.username = null;
      this.country = null;
      this.state = null;
      this.city = null;
      this.name = null;
      this.title = null;
      this.description = null;
      this.mainWebsite = null;
      this.email = null;
      this.blog = null;
      this.avatar_url = null;
      this.providers = {
        facebook: null,
        linkedin: null,
        twitter: null,
        googlePlus: null,
        pinterest: null,
        instagram: null
      }
      angular.extend(this, data);
    }

    Socialcard.get = function (id) {
      return $http.get('/api/sc/' + id).then(function (response) {
        return new Socialcard(response.data);
      })
    }

    return Socialcard;
  });
});

angular.module('cahoots.directives', []).
  directive('popUp',function () {
    return {
      restrict: 'A',
      link: function ($scope, $element, $attrs) {
        $element.click(function () {
          console.log('popping', $attrs.popUp);
          window.open(encodeURI($attrs.popUp), 'mywindow', 'width=' + $attrs.width + ',height=' + $attrs.height);
        });
      }
    }
  }).
  directive('scrolly',function () {
    return {
      restrict: "A",
      scope: {
        scrolly: '&'
      },
      link: function (scope, element, attrs) {

        $(window).scroll(function () {
          if (distanceToBottom() <= 500) {
            scope.scrolly();
          }
        });

        function distanceToBottom() {
          var scrollPosition = window.pageYOffset;
          var windowSize = window.innerHeight;
          var bodyHeight = document.body.offsetHeight;

          return Math.max(bodyHeight - (scrollPosition + windowSize), 0);
        }
      }
    }
  }).
  directive('slider', function () {
    return {
      restrict: "A",
      scope: {
        sliderValue: '=',
        sliderType: '@',
        min: '@',
        max: '@',
        step: '@',
        initial: '='
      },
      controller: function ($scope, $element, $attrs) {
        var min = parseInt($attrs.min);
        var max = parseInt($attrs.max);
        var range = true;
        var value;

        if ($attrs.sliderType == 'single') {
          range = 'min';
          value = parseInt($scope.initial);
          $scope.sliderValue = value;
          $scope.sliderDisplay = value;
        }
        else if ($attrs.sliderType == 'double') {
          range = true;
          value = [2, 5];
          $scope.sliderValue = value;
          $scope.sliderDisplay = value;
        }

        $element.children('.slider').slider({
          step: parseInt($attrs.step),
          range: range,
          min: min,
          max: max,
          value: parseInt($scope.initial),
          values: value,
          slide: function (event, ui) {

            if ($attrs.sliderType == 'single') {
              $scope.sliderDisplay = ui.value;
            }
            else if ($attrs.sliderType == 'double') {
              $scope.sliderDisplay = ui.values;
            }

            $scope.$apply();
          },
          change: function (event, ui) {

            if ($attrs.sliderType == 'single') {
              $scope.sliderValue = ui.value;
            }
            else if ($attrs.sliderType == 'double') {
              $scope.sliderValue = ui.values;
            }
            $scope.$apply();
          }
        });
      }
    }
  });
