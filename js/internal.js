function(user, context, callback) {
    const namespace = 'https://ataper.net/';

    var isUser = false;

    if (context.clientID == ${anonymous_client_id}) {
        context.accessToken[namespace + 'role'] = "anonymous";
    } else if (context.clientID == ${rules_client_id}) {
        context.accessToken[namespace + 'role'] = "internal";
    }

    callback(null, user, context);
}
