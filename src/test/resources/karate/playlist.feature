Feature: Test Playlist

Background:
  * def token = read('config/token')
  * header Authorization = token

Scenario: Test create playlist
  * def userId = read('config/userId')
  * def requestUserId = read('request/requestUserId.json')
  Given url userId
  And request requestUserId
  When method POST
  Then status 201
  And match $ contains {description:"New playlist description",name:"New Playlist",type:"playlist"}
  
  
Scenario: Test create playlist with invalid user id - 403
  * def userId = read('config/invalidUserId')
  * def requestUserId = read('request/requestUserId.json')
  Given url userId
  And request requestUserId
  When method POST
  Then status 403
  * def jsonResponse = read('response/invalidUserIdResponse.json')
  And match $ == jsonResponse
