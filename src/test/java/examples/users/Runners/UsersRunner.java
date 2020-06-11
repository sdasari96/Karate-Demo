package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class UsersRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/users").relativeTo(getClass());
    }



}
