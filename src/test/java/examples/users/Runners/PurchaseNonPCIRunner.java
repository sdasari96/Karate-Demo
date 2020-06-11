package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class PurchaseNonPCIRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/purchaseNonPCI").relativeTo(getClass());
    }

}
