package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class JSFunctionsRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/jsFunctions").relativeTo(getClass());
    }

}
