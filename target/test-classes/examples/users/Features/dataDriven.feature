Feature: Data Driven Test

  Background:
    * url url

    Scenario Outline: Performing Data Driven Test
      Given path 'api/users'
      And request {name : <name>, job : <job>}
      When method POST
      Then status 201
      #comparing response name with name in csv file
      And match response.name == '<name>'
      Examples:
      #|read('../TestData/dataDriven.csv')|
      |name|job|
      |morpheus|leader|









