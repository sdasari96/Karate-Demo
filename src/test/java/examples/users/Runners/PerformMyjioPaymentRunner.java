package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class PerformMyjioPaymentRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/performMyjioPayment").relativeTo(getClass());
    }

}
