Feature: POST Test Call

  Background:
    * url url
    * def payLoad = read('../TestData/postData.json')

    Scenario: Adding params
      Given path 'api/users'
      And request payLoad
      And header Accept = 'application/json'
      And param delay = 3
      When method POST
      Then status 201










