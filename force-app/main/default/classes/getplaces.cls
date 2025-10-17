public with sharing class getplaces {
    public static void getPlacesdetails(string pincode) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();    
        request.setEndpoint('https://api.postalpincode.in/pincode/'+pincode);
        request.setMethod('GET');
        HttpResponse response = http.send(request); 
        
        if(response.getStatusCode() == 200) {
             list<fetchpincode> fetchpin =(list<fetchpincode>)json.deserialize(response.getbody(),list<fetchpincode>.class);
            for(fetchpincode data:fetchpin)
            {
             system.debug(data.Message);
            system.debug(data.Status);
            system.debug(data.PostOffice);
                for(PostOffice ps:data.PostOffice)
                {
                    system.debug(ps.Name);
                    system.debug(ps.Description);
                    system.debug(ps.BranchType);
                }
            }
        }
        else {
            System.debug('Error');
             }
    }
        public class fetchpincode{
            public string Message;
            public string Status;
            public list<PostOffice> PostOffice;
        }
    public class PostOffice{
        public string Name;
        public string Description;
        public string BranchType;
    }
    }