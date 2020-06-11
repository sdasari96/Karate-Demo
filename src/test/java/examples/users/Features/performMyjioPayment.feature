Feature: UI Automation

  Background:

    * def driver = Java.type('io.appium.java_client.AppiumDriver')
    * configure driver = { type: 'android' }
    * def driverCaps = {"appPackage":"com.jio.myjio","appActivity":"com.jio.myjio.dashboard.activities.DashboardActivity","newCommandTimeout":"180","platformVersion":"10.0.0","platformName":"Android","connectHardwareKeyboard":"true","deviceName":"a70q"}
    * def AndroidDriver = Java.type('io.appium.java_client.android.AndroidDriver');
    * def URL = Java.type('java.net.URL')
    * driver = new AndroidDriver(new URL("http://0.0.0.0:4723/wd/hub"),driverCaps)

  Scenario:
    Given driver.openNotifications();












