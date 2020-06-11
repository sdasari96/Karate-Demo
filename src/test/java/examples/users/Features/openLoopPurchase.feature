Feature: UI Automation

  Background:

    * configure driver = { type: 'chrome', showDriverLog: true, httpConfig: { readTimeout: 120000 } }
    #* def appiumConnector = Java.type('examples.users.Features.AppiumConnector')
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

    Given retry(5,5000).click("//a[@data-attr-val='DC']")
    And delay(5000).input('#cc-number','4280940008627697')
    And delay(5000).input("//*[@id='cardholderName']","Sneha")
    And delay(5000).input('#exp-date','0824')
    And delay(5000).input("//*[@name='cardinfo.cvv2']",'884')
    And delay(5000).click('#submitBtn')
    Examples:
      |clientId  |
      |10000022  |











