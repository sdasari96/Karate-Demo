Feature: UI Automation

  Background:

    * def CheckSumUtil = Java.type('examples.users.Features.CheckSumUtil')
    * def checkSumUtilObject = new CheckSumUtil();
    * def MyJioMobilePage = Java.type('examples.users.Features.MyJioMobilePage')
    * def myJioMobilePage = new MyJioMobilePage();

  Scenario Outline:
    Given url "https://pp2pay.jiomoney.com/reliance-webpay/api/upidirect"
    #And def checksumseed = merchantId == '100001000001121' ? 'I8VcubBQCFGLRuknYsIBQDo4V1DKs9O/w7p74D3duXnouJ3r8dr/jZ+1lPgJtci9gzZRH24uWBcG7kzJzuJMfGyyDAuMtPVgSRv4Pq5rV35gd9MNtV80fnvTVvDElCtXyz9j6lrXv21eSQhFJ4kE0O622YP4YdBydiz1glPNWkFKuXFTI/qGzTty/En5jtk+IZ4441aUXKV7kTt+YyYek9iXHSV3E1MCrfHYluIN3CgiDeRprTrBwAsakG9eTvHM' : 'AI1vbf6cGLovBvbagUr8rfCvE23AMObsN5K351lwCKfWJp8vxbnuM1uJqKbGSLtR9nixjKe9HlbubvuLiyXsVWUC4kK8Zoj6d2JPE7hbJWuwZuznKELd8Xo0rP2bwvomyB1QGahPC5QaNiQygBVHMBApM4897sdfKPUVIPATe9btjwNuJ9x5oGUYU8cP0ykFoTaCoH9q6Kvf6XNu8BzrWW5dJ79CyeHOaMWBewdYd4JCRWHczZyDXhf4pwNAg1o8'
    And def ts = CheckSumUtil.getDate(0)
    And def txnId = CheckSumUtil.getTransReference()
    And def checksumString = checkSumUtilObject.getCheckSumPurchase("PG_COLLECT_REQUEST_API",ts,"4.0","10025178","100001001802836",txnId,"PURCHASE","1.00","AI1vbf6cGLovBvbagUr8rfCvE23AMObsN5K351lwCKfWJp8vxbnuM1uJqKbGSLtR9nixjKe9HlbubvuLiyXsVWUC4kK8Zoj6d2JPE7hbJWuwZuznKELd8Xo0rP2bwvomyB1QGahPC5QaNiQygBVHMBApM4897sdfKPUVIPATe9btjwNuJ9x5oGUYU8cP0ykFoTaCoH9q6Kvf6XNu8BzrWW5dJ79CyeHOaMWBewdYd4JCRWHczZyDXhf4pwNAg1o8");
    And request {"request_header":{"api_name":"PG_COLLECT_REQUEST_API","timestamp":"#(ts)"},"payload_data":{"customer_mobile_no":"9324739689","channel":"WEB","merchant_id":"100001001802836","txn_amount":"1.00","client_id":"10025178","funding_source":"UPI","product_description":"","customer_city":"Mumbai","customer_state":"Maharashtra","customer_id":"123456789","udf5":"","merchant_name":"BOC Online UPI Merchant","udf3":"","merchant_txn_ref_no":"#(txnId)","udf4":"","udf1":"","udf2":"","txn_type":"PURCHASE","upi_customer_vpa":"9324739689@jio","upi_transactionexpiry":"30","customer_name":"Sneha"},"checksum":"#(checksumString)"}
    And header APIVer = '4.0'
    When method POST
    Then status 200
    And print response
    And match response.payload_data.txn_status == 'INITIATED'
    And def upiTxnTimestamp = response.response_header.timestamp
    And def upiTxnRef = response.payload_data.jm_txn_ref_no
    And print upiTxnTimestamp,upiTxnRef

    #Gotta add code to perform MYJIO Pay operation
    Given def txnRef = myJioMobilePage.checkUPIRequestInMyjio();
    And match upiTxnRef == upiTxnRef
    Examples:
      |txnRefTimestamp |txnRefTxnId|filename|
      |20200602201004  |301043358311|uiKarate.txt|









