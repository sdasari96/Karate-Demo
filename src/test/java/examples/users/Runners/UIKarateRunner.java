package examples.users.Runners;

import com.intuit.karate.junit5.Karate;

class UIKarateRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("../Features/uiKarate").relativeTo(getClass());
    }

}
