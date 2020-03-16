function(user, context, callback) {
    const namespace = 'https://ataper.net/';

    var user = false;

    if (context.accessToken.scope.include("internal")) {
        context.idToken[namespace + 'role'] = "internal";
    } else if (context.accessToken.scope.include("user")) {
        user = true
        context.idToken[namespace + 'role'] = "user";
    } else {
        context.idToken[namespace + 'role'] = "anonymous";
    }

    if (user) {
        // TODO use configuration.client_id and configuration.client_secret to do DB stuff

        if (user.email_verified) {
            context.idToken[namespace + 'email'] = user.email;
        }
        if (user.phone_verified) {
            context.idToken[namespace + 'phone'] = user.phone;
        }
    }

    callback(null, user, context);
}
