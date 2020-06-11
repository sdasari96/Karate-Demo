package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class OpenLoopPurchaseRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/openLoopPurchase").relativeTo(getClass());
    }

}
