public class ProcesssController {
    
    @invocableMethod
    public static void postChatterMessage(){
        FeedItem item = new FeedItem();
        item.Body = 'This is a chatter message from Apex method to chatter group';
        item.ParentId = '0F95j000000kEncCAE';
        insert item;
      
    }
}