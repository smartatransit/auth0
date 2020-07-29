function uuidv4() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

module.exports = function(client, scope, audience, context, cb) {
	var access_token = {};
	access_token.scope = scope; // do not remove this line

	const namespace = 'https://${claims_domain}/';
	switch(client.id) {
	case "${anonymous_client_id}":
		access_token[namespace + 'role'] = "anonymous";
		access_token[namespace + 'session'] = uuidv4();
		break;
	case "${rules_client_id}":
		access_token[namespace + 'role'] = "internal";
		break;
	}

	cb(null, access_token);
}
