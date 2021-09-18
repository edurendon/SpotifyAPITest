Feature: Testing a REST API with Karate

Background:
	Given url 'https://api.spotify.com/v1/artists/1EXjXQpDx2pROygh8zvHs4'

Scenario: Test a valid token
  * def token = read('config/token')
  When header Authorization = token
  When method GET
  Then status 200
  And match $ contains {name:"Melendi",type:"artist"}

Scenario: Test without valid token - 401
  When method GET
  Then status 401
  * def jsonResponse = read('response/withoutTokenResponse.json')
  And match $ == jsonResponse

Scenario: Test with invalid token - 401
  * def token = read('config/invalidToken')
  When header Authorization = token
  When method GET
  Then status 401
  * def jsonResponse = read('response/invalidTokenResponse.json')
  And match $ == jsonResponse

Scenario: Test with expired token - 401
  * def token = read('config/token')
  When header Authorization = token
  When method GET
  Then status 401
  * def jsonResponse = read('response/expiredTokenResponse.json')
  And match $ == jsonResponse
