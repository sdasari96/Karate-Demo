package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class PurchasePCIRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/purchasePCI").relativeTo(getClass());
    }

}
