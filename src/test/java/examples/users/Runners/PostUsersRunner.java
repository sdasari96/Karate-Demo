package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class PostUsersRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/postUser").relativeTo(getClass());
    }

}
