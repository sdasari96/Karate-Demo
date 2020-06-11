Feature: UI Automation

  Background:

    * def CheckSumUtil = Java.type('examples.users.Features.CheckSumUtil')
    * def checkSumUtilObject = new CheckSumUtil();
    * def closedLoopRefund = read('../../../../../uiKarate.txt')

  Scenario Outline:
    Given url "https://pp2pay.jiomoney.com/reliance-webpay/v1.0/payment/apis"
    And print '****** :Closed Loop Refund: *******', closedLoopRefund.split('|')[5]
    And def txnRefTxnId = closedLoopRefund.split('|')[5]
    And def txnRefTimestamp = closedLoopRefund.split('|')[9]
    And def merchantId = closedLoopRefund.split('|')[2]
    And def amount = closedLoopRefund.split('|')[6]
    And def checksumseed = merchantId == '100001000001121' ? 'I8VcubBQCFGLRuknYsIBQDo4V1DKs9O/w7p74D3duXnouJ3r8dr/jZ+1lPgJtci9gzZRH24uWBcG7kzJzuJMfGyyDAuMtPVgSRv4Pq5rV35gd9MNtV80fnvTVvDElCtXyz9j6lrXv21eSQhFJ4kE0O622YP4YdBydiz1glPNWkFKuXFTI/qGzTty/En5jtk+IZ4441aUXKV7kTt+YyYek9iXHSV3E1MCrfHYluIN3CgiDeRprTrBwAsakG9eTvHM' : 'AI1vbf6cGLovBvbagUr8rfCvE23AMObsN5K351lwCKfWJp8vxbnuM1uJqKbGSLtR9nixjKe9HlbubvuLiyXsVWUC4kK8Zoj6d2JPE7hbJWuwZuznKELd8Xo0rP2bwvomyB1QGahPC5QaNiQygBVHMBApM4897sdfKPUVIPATe9btjwNuJ9x5oGUYU8cP0ykFoTaCoH9q6Kvf6XNu8BzrWW5dJ79CyeHOaMWBewdYd4JCRWHczZyDXhf4pwNAg1o8'
    And def ts = CheckSumUtil.getDate(0)
    And def txnId = CheckSumUtil.getTransReference()
    And def checksumString = checkSumUtilObject.getCheckSumRefund(merchantId, "REFUND", ts,txnId,amount,txnRefTxnId,txnRefTimestamp,"NA",checksumseed);
    And request {"request":{"request_header":{"api_name":"REFUND","version":"3.1","timestamp":"#(ts)"},"checksum": "#(checksumString)" ,"payload_data":{"org_txn_timestamp":"#(txnRefTimestamp)","additional_info":"NA","org_jm_tran_ref_no":"#(txnRefTxnId)","merchant_id":"100001000001121","txn_amount":"0.01","tran_ref_no":"#(txnId)"}}}
    When method POST
    Then status 200
    And print response
    And match response.response.payload_data.txn_status == 'SUCCESS'
    Examples:
      |txnRefTimestamp |txnRefTxnId|filename|
      |20200602201004  |301043358311|uiKarate.txt|









