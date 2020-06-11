Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200

    * def first = response[0]

    Given path 'users', first.id
    When method get
    Then print 'Path is: ', path
    Then status 200
    * match first.id == 1
    * match first.id != 2
    * match first.name contains 'Leanne'
    * match first.name !contains 'Brett'
    #* match first.name contains only ['Leanne Graham','Some text']
    #* match first.name contains any ['Leanne']

  Scenario: create a user and then get it by id
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given path '/users'
    And request user
    When method post
    Then status 201

    * def id = response.id
    * print 'created id is: \,\n', id

    #Given path id
    # When method get
    # Then status 200
    # And match response contains user
