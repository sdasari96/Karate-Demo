package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class JavaFunctionsRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/javaFunctions").relativeTo(getClass());
    }

}
