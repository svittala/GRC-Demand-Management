public with sharing class ProjectIDforPosition {
public ProjectIDforPosition(ApexPages.StandardController controller) {
        Position__c child = (Position__c)controller.getRecord();
        
        //if you always create the child object through relatedList
        //parent__c should not be null
        if (child.Project__c != null) {
            Project__c parent = [select name from Project__c where id =: child.Project__c limit 1];
            child.project__c = parent.name;
            system.debug('Hello This Jenkins 777');
        }
    }
}