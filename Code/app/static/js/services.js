angular.module('myApp').factory('AuthService',
    ['$q', '$timeout', '$http',
        function ($q, $timeout, $http) {

            // create user variable
            var user = null;


            function isLoggedIn() {
                if (user) {
                    return true;
                } else {
                    return false;
                }
            }

            function login(lname, password) {

                // create a new instance of deferred
                var deferred = $q.defer();

                // send a post request to the server
                $http.post('/api/v1.0/hotel_personnel/login', {lname: lname, password: password})
                    // handle success
                    .success(function (data, status) {
                        if (status === 200 && data.result) {
                            user = true;
                            deferred.resolve();
                        } else {
                            user = false;
                            deferred.reject();
                        }
                    })
                    // handle error
                    .error(function (data) {
                        user = false;
                        deferred.reject();
                    });

                // return promise object
                return deferred.promise;

            }

            function logout() {

                // create a new instance of deferred
                var deferred = $q.defer();

                // send a get request to the server
                $http.get('/api/logout')
                    // handle success
                    .success(function (data) {
                        user = false;
                        deferred.resolve();
                    })
                    // handle error
                    .error(function (data) {
                        user = false;
                        deferred.reject();
                    });

                // return promise object
                return deferred.promise;

            }

            function register(password, fname, mname, lname) {

                // create a new instance of deferred
                var deferred = $q.defer();

                // send a post request to the server
                $http.post('/api/v1.0/hotel_personnel/register', {password: password, fname: fname, mname: mname, lname: lname})
                    // handle success
                    .success(function (data, status) {
                        if (status === 200 && data.result) {
                            user = true;
                            deferred.resolve();
                        } else {
                            user = false;
                            deferred.reject();
                        }
                    })
                    // handle error
                    .error(function (data) {
                        user = false;
                        deferred.reject();
                    });


                // return promise object
                return deferred.promise;

            }

            function getUserStatus() {
                $http.get('/api/status')
                    // handle success
                    .success(function (data) {
                        if (data.status) {
                            user = true;
                        } else {
                            user = false;
                        }
                    })
                    // handle error
                    .error(function (data) {
                        user = false;
                    });
            }

            // return available functions for use in controllers
            return ({
                isLoggedIn: isLoggedIn,
                login: login,
                logout: logout,
                register: register,
                getUserStatus: getUserStatus
            });

        }


    ]);