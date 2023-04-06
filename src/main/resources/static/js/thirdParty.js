var thirdPartyApi = (function ($, win, doc) {
    var key = "cf004ffed7d8cc16a452be05f6472f8a"; //테스트

    var localHost = window.location.host;
    if(localHost.indexOf("local.todos.co.kr") != -1 ){
        key = "cf004ffed7d8cc16a452be05f6472f8a"; //테스트
    } else if(localHost.indexOf("linker.todos.co.kr") != -1){
        key = "cf004ffed7d8cc16a452be05f6472f8a"; //테스트
    } else if(localHost.indexOf("dev.ilinker.co.kr:10004") != -1){
        key = "cf004ffed7d8cc16a452be05f6472f8a"; //테스트
    } else {
        if(localHost.indexOf("ilinker.co.kr") > -1 || localHost.indexOf("linker.ac") > -1) {
            key = "21740fabe3f76b58d33af3330324345d"; //라이브
        }
    }

    Kakao.init(key);

    var kakao = {
        login: function(successCallback){
            Kakao.Auth.login({ //로그인
                success: function(authObj) {
                    kakaoUserInfo(function(res){ //사용자 정보조회
                        if(typeof successCallback == "function"){
                            successCallback(res.id, res.kakao_account.email, res);
                        }
                    });
                },
                fail: function(err) {
                    console.log(err)
                }
            });
        }
    }

    var kakaoUserInfo = function(callback){
        Kakao.API.request({
            url: '/v2/user/me',
            success: function(res) {
                if(typeof callback === "function"){
                    callback(res);
                }
            },
            fail: function(error) {
                alert(
                    'login success, but failed to request user information: ' +
                    JSON.stringify(error)
                )
            },
        })
    }

    // 페이스북, 구글
    var firebaseConfig = {
    	apiKey: "AIzaSyDDLD9rnMHImN8CrR8l4dii7XMuEDTXXYQ",
    	authDomain: "edulinker-253807.firebaseapp.com",
    	databaseURL: "https://edulinker-253807.firebaseio.com",
    	projectId: "edulinker-253807",
    	storageBucket: "edulinker-253807.appspot.com",
    	messagingSenderId: "147532707095",
    	appId: "1:147532707095:web:598bffb2cbe84bf5ebb352",
    	measurementId: "G-JGNLWVYY22"
    };
    
    var localHost = window.location.host;
    // dev
    if(localHost.indexOf("local.todos.co.kr") != -1 || localHost.indexOf("linker.todos.co.kr") != -1 || localHost.indexOf("dev.ilinker.co.kr") != -1 ){
        firebaseConfig = {
            	apiKey: "AIzaSyAhmR19TdUARDRW3PAs3ffXjE_NGjOrZCQ",
            	authDomain: "edulinker-dev.firebaseapp.com",
            	databaseURL: "https://edulinker-dev.firebaseio.com",
            	projectId: "edulinker-dev",
            	storageBucket: "edulinker-dev.appspot.com",
            	messagingSenderId: "534214226223",
            	appId: "1:534214226223:web:c278fbe34c08bb8da431da",
            	measurementId: "G-W4W0P1WM9C"	
        };
    } else { // live
        if(localHost.indexOf("ilinker.co.kr") > -1 || localHost.indexOf("linker.ac") > -1) {
        	firebaseConfig = {
        	    apiKey: "AIzaSyDDLD9rnMHImN8CrR8l4dii7XMuEDTXXYQ",
        	    authDomain: "edulinker-253807.firebaseapp.com",
        	    databaseURL: "https://edulinker-253807.firebaseio.com",
        	    projectId: "edulinker-253807",
        	    storageBucket: "edulinker-253807.appspot.com",
        	    messagingSenderId: "147532707095",
        	    appId: "1:147532707095:web:598bffb2cbe84bf5ebb352",
        	    measurementId: "G-JGNLWVYY22"
        	};
        }
    }
   
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    firebase.analytics();
    
    var facebook = {
    	login: function(successCallback){
    		var provider = new firebase.auth.FacebookAuthProvider();
    		
    		firebase.auth().languageCode = 'ko_KR';
    		
    		/*provider.setCustomParameters({
    			'display' : 'popup'
    		});*/
    		
    		firebase.auth().signInWithPopup(provider).then(function(result){
    			var token = result.credential.accessToken;
    			var user = result.user;

    			if(typeof successCallback == "function"){
    				successCallback(user.uid, user.email);
    			}
    		}).catch(function(error) {
  			  var errorCode = error.code;
			  var errorMessage = error.message;
			  var email = error.email;
			  var credential = error.credential;
			});
    	},
    	
    	logout: function(){
    		firebase.auth().signOut().then(function() {
    			
    		}).catch(function(error) {
    			console.log(error);
    		});
    	}
    };
    
    var google = {
    	login: function(successCallback){
    		var provider = new firebase.auth.GoogleAuthProvider();
    		
    		firebase.auth().languageCode = 'ko_KR';
    		
    		/*provider.setCustomParameters({
    		  'login_hint': 'user@example.com'
    		});*/
    		
    		firebase.auth().signInWithPopup(provider).then(function(result) {
    			  var token = result.credential.accessToken;
    			  var user = result.user;
    			  
    			  if(typeof successCallback == "function"){
      				successCallback(user.providerData[0].uid, user.email);
      			  }
    			  
    		}).catch(function(error) {
    			  var errorCode = error.code;
    			  var errorMessage = error.message;
    			  var email = error.email;
    			  var credential = error.credential;
    			  console.log(error);
    		});
    	},
    	
    	logout: function(){
    		firebase.auth().signOut().then(function() {
    		
    		}).catch(function(error) {
    			console.log(error);
    		});
    	}
    };
    return {
        kakao: function(){return kakao;},
    	facebook: function(){return facebook;},
    	google: function(){return google}
    }
}(jQuery, window, document));