module.exports = function(client, scope, audience, context, cb) {
	var access_token = {};
	access_token.scope = scope; // do not remove this line

	const namespace = 'http://ataper.net/';
	if (scope) {
		if (scope.indexOf("be:anonymous") > -1) {
			access_token[namespace + "role"] = "anonymous";
		} else if (scope.indexOf("be:internal") > -1) {
			access_token[namespace + "role"] = "internal";
		} else if (scope.indexOf("be:user") > -1) {
			access_token[namespace + "role"] = "user";
		}
	}

	cb(null, access_token);
};
