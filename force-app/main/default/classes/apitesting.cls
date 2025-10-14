public with sharing class apitesting {
public apitesting() {}
public void makeAPICall() {
Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://randomuser.me/api/');
request.setMethod('GET');

HttpResponse response = http.send(request);

if(response.getStatusCode() == 200) {
Map<String, Object> results = 
(Map<String, Object>) JSON.deserializeUntyped(response.getBody());

List<Object> users = (List<Object>) results.get('results');
Map<String, Object> user = (Map<String, Object>) users[0];
Map<String, Object> name = (Map<String, Object>) user.get('name');

Contact c = new Contact(
FirstName = (String) name.get('first'),
LastName = (String) name.get('last'),
Email = (String) user.get('email')
);
insert c;
}

}
}