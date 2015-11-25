var exec = require('cordova/exec');

/* constructor */
function Pushmote() {}

Pushmote.prototype.startWithApplicationId = function(successHandler, errorHandler,appId) {
        exec(successHandler,errorHandler, "Pushmote","startWithApplicationId",[appId]);
}

var pushmote = new Pushmote();
module.exports = pushmote;
