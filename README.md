# Pushmote PhoneGap/Cordova Plugin

## How to add Pushmote PhoneGap/Cordova Plugin

First add pushmote-phonegap-plugin by using phonegap cli

    phonegap plugin add pushmote-phonegap-plugin

Add this line to index.js for starting Pushmote SDK

    Pushmote.startWithApplicationId(
                          function(message){
                              alert(message)},
                          function(message){
                              alert(message)},
                          {"appId": "YOUR_APP_KEY"});

