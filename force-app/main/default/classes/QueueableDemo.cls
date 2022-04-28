public class QueueableDemo implements Queueable {
    List<Account> accList;
    Id parentId;
    
    public QueueableDemo(List<Account> accList,Id parentId){
        this.accList = accList;
        this.parentId = parentId;
    }
    public void execute(QueueableContext qc){
        for(Account acc : accList){
            acc.ParentId = parentId;
        }
        try{
          update accList;   
        }catch(DmlException ex){
            Error_Log_Number__c log = new Error_Log_Number__c();
            log.Trace__c = ex.getMessage() + ex.getStackTraceString();
            insert log;
        }
    }
}