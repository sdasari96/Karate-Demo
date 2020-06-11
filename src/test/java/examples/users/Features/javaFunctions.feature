Feature: Data Driven Test

  Background:
    # Creating variable to act as Java class
    * def javaFunctions = Java.type('examples.users.Runners.JavaFunctions')
    # Creating java object
    * def javaFunctionsObject = new javaFunctions();

    Scenario: Performing Data Driven Test
      * def result = javaFunctionsObject.nonStaticFunction("Hello");
      Then print result
      * def result2 = javaFunctionsObject.writeData("Entering Data")
      Then print result2
      * def result3 = javaFunctions.staticFunction("Static Function");
      Then print result3

    Scenario: Performing Writing to data.txt
      Given url 'https://jsonplaceholder.typicode.com/users/1'
      When method GET
      Then javaFunctionsObject.writeData(response)











