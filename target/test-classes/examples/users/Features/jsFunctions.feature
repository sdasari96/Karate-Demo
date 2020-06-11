Feature: Java Script Functions

  Background:
    * url url
    * def payLoad = read('../TestData/postData.json')
    # Multi-Line Function
    * def myFun =
    """
    function()
    {
      return 'I am in Multi-Line Function';
    }
    """

    Scenario: Defining and Calling Javascript Functions
      Given path 'api/users/3'
      When method GET
      Then status 200
      * def func1 = call myFun
      Then print 'Function 1: ',func1
      # Single-Line Function
      * def myFun2 = function(){return 'I am in Single-Line Function';}
      * def func2 = call myFun2
      Then print 'Function 2: ',func2









