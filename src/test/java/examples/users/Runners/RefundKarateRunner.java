package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class RefundKarateRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/refundKarate").relativeTo(getClass());
    }

}
