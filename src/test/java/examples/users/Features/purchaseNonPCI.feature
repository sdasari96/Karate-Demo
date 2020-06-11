Feature: UI Automation

  Background:

    * configure driver = { type: 'chrome', showDriverLog: true, httpConfig: { readTimeout: 120000 } }
    * def appiumConnector = Java.type('examples.users.Features.AppiumConnector')
    * def JavaFunctions = Java.type('examples.users.Runners.JavaFunctions')
    * def MyJioMobilePage = Java.type('examples.users.Features.MyJioMobilePage')
    * def myJioMobilePage = new MyJioMobilePage();

  Scenario Outline:
    Given driver 'http://10.159.20.123:8080/CentralSimulatorProd/#'
    And driver.maximize()
    And retry(5,2000).input('#username', 'prod')
    And retry(5,2000).input('#password', 'Prod@123')
    When retry(5,2000).click("button[id=login]")
    Then match text('#pg') == 'PG/PPI'

    Given click("button[id=pg]")
    When retry(5,2000).select('select[id=txntype]','PURCHASE')
    Then match text('.text-primary') == 'PG/PPI SIMULATOR'

    Given input('#clientId',<clientId>)
    And delay(5000).click('#merchantId')
    And delay(5000).input('#merchantId',<merchantId>)
    And delay(5000).input('#checksumseed','AI1vbf6cGLovBvbagUr8rfCvE23AMObsN5K351lwCKfWJp8vxbnuM1uJqKbGSLtR9nixjKe9HlbubvuLiyXsVWUC4kK8Zoj6d2JPE7hbJWuwZuznKELd8Xo0rP2bwvomyB1QGahPC5QaNiQygBVHMBApM4897sdfKPUVIPATe9btjwNuJ9x5oGUYU8cP0ykFoTaCoH9q6Kvf6XNu8BzrWW5dJ79CyeHOaMWBewdYd4JCRWHczZyDXhf4pwNAg1o8')
    And delay(5000).input('#jiocustid',"123456")
    And delay(5000).input('#customername',"Sneha Dasari")
    And delay(5000).input('#mobile',"9324739689")
    And delay(5000).click('#purchasebutton')
    When delay(20000).value('#requestinfo').length > 0
    Then click('#paynow')
    And waitForUrl('https://pp2pay.jiomoney.com/reliance-webpay/v1.0/jiopayments#1')

    Given retry(5,2000).click("//a[@data-attr-val='UPI']")
    And delay(15000).input("//input[@id='vpa']",'9324739689@jio')
    Then delay(5000).click('#payupi')

    #Gotta add code to perform MYJIO Pay operation
    Given def txnRef = myJioMobilePage.checkUPIRequestInMyjio();
    And def errorCode = delay(120000).retry(5,1000).value('#errorcode')
    #And def txnRef = delay(5000).retry(5,1000).value('#transaction.ref')
    And def txnTime = delay(5000).retry(5,1000).value("//input[@id='txntime']")
    And def jioTxn = delay(5000).retry(5,1000).value("//input[@id='jiotxn']")
    And def responseVar = delay(5000).retry(5,1000).text("//input[@id='responseinfo']")
    And JavaFunctions().writeData('purchaseNonPCI.txt',responseVar)
    And def result = 'clientId\,merchantId\,amount\,txnRef\,txnTime\n',<clientId>,'\,'<merchantId>,'\,',jioTxn,'\,',txnTime
    When print result
    Then match errorCode == "SUCCESS"
    Examples:
      |clientId  |merchantId|checksumSeed|
      |10025178  |100001001802836|AI1vbf6cGLovBvbagUr8rfCvE23AMObsN5K351lwCKfWJp8vxbnuM1uJqKbGSLtR9nixjKe9HlbubvuLiyXsVWUC4kK8Zoj6d2JPE7hbJWuwZuznKELd8Xo0rP2bwvomyB1QGahPC5QaNiQygBVHMBApM4897sdfKPUVIPATe9btjwNuJ9x5oGUYU8cP0ykFoTaCoH9q6Kvf6XNu8BzrWW5dJ79CyeHOaMWBewdYd4JCRWHczZyDXhf4pwNAg1o8|












