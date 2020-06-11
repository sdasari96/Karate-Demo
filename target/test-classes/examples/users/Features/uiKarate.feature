Feature: UI Automation

  Background:

    * configure driver = { type: 'chrome', showDriverLog: true, httpConfig: { readTimeout: 120000 } }
    * def appiumConnector = Java.type('examples.users.Features.AppiumConnector')
    * def JavaFunctions = Java.type('examples.users.Runners.JavaFunctions')

  Scenario Outline:
    Given driver 'http://10.159.20.123:8080/CentralSimulatorProd/#'
    And driver.maximize()
    And retry(5,2000).input('#username', 'prod')
    And retry(5,2000).input('#password', 'Prod@123')
    When retry(5,2000).click("button[id=login]")
    Then match delay(5000).text('#pg') == 'PG/PPI'

    Given click("button[id=pg]")
    When select('select[id=txntype]','PURCHASE')
    Then match text('.text-primary') == 'PG/PPI SIMULATOR'

    Given input('#clientId',<clientId>)
    And delay(5000).click('#merchantId')
    And clear('#txnamt')
    And input('#txnamt','0.01')
    And delay(5000).click('#purchasebutton')
    When delay(20000).value('#requestinfo').length > 0
    Then click('#paynow')
    And waitForUrl('https://pp2pay.jiomoney.com/reliance-webpay/v1.0/jiopayments#1')

    Given retry(5,5000).click("a[class='bt btblue loginform']")
    And delay(5000).input('#mobile','9324739689')
    And delay(5000).click('#vmsubmitBtn')
    When waitFor('#otpns')
    Then match delay(5000).enabled("div[class='row verify-signup-block_otp']") == true

    #Given def otpMessage = read('../Features/appKarate.feature')
    #* def result = call otpMessage
    #When def otpString = read('../../../../../../data.txt')


    Given def otpString = appiumConnector.fetchOTP();
    When driver.delay(5000).input('#otpns',otpString)
    And driver.delay(5000).click("div[class='row verify-signup-block_otp']")
    Then print otpString

    Given delay(4000).retry(5,1000).click('#jmsignup-btn')
    And delay(10000).retry(10,2000).click('#submitBtn')
    And def errorCode = delay(20000).retry(5,1000).value('#errorcode')
    #And def txnRef = delay(5000).retry(5,1000).value('#transaction.ref')
    And def txnTime = delay(5000).retry(5,1000).value('#txntime')
    And def jioTxn = delay(5000).retry(5,1000).value('#jiotxn')
    And def responseVar = delay(5000).retry(5,1000).text("#responseinfo")
    And def data = 'jioTxn\,txnTime \n',jioTxn,'\,',txnTime
    And print responseVar,'\nData: ',data
    And JavaFunctions.writeData('uiKarate.txt',responseVar)
    #When print 'errorCode: ',errorCode, ' |txnRef: ', txnRef,' |txnTime: ', txnTime,' |jioTxn: ', jioTxn," |response: ",responseVar
    Then match errorCode == "SUCCESS"
    Examples:
      |clientId  |
      |10000022  |











