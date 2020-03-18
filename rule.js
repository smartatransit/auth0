function(user, context, callback) {
    const namespace = 'https://ataper.net/';

    var isUser = false;

    var rulesClientIDs = configuration.rulesClientIDs.split(",");
    var anonymousClientIDs = configuration.anonymousClientIDs.split(",");
    var userClientIDs = configuration.userClientIDs.split(",");

    if (anonymousClientIDs.include(context.clientID)) {
        context.accessToken[namespace + 'role'] = "anonymous";
    } else if (rulesClientIDs.include(context.clientID)) {
        context.accessToken[namespace + 'role'] = "internal";
    } else if (userClientIDs.include(context.clientID)) {
        context.accessToken[namespace + 'role'] = "user";
    }

    callback(null, user, context);
}
