package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class DataDrivenRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/dataDriven").relativeTo(getClass());
    }

}
