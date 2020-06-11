Feature: UI Automation

  Background:

    * configure driver = { type: 'android' }
    * def appCaps = {"udid": "RZ8M51CE05A","deviceName":"GALAXY A70","appPackage":"com.android.chrome","appActivity":"com.google.android.apps.chrome.Main","platformName":"Android","platformVersion":"9"}
    # Creating variable to act as Java class
    * def javaFunctions = Java.type('examples.users.Runners.JavaFunctions')
    # Creating java object
    * def javaFunctionsObject = new javaFunctions();

  Scenario:

    Given driver appCaps
    * def otp = driver.delay(10000).text('#android:id/message_text')
    * print otp
    When def result = javaFunctionsObject.writeData(otp)
    Then print result












