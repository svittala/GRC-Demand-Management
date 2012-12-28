trigger UpdateStatusForPosition on Resource_Pool__c (after insert,after update) 
{
  if(Trigger.isInsert && Trigger.isAfter)
  {
      for (Resource_Pool__c  rp : trigger.New)
          {


          }
  }
  else if(Trigger.isUpdate && Trigger.isAfter)
  {  
      for  (Resource_Pool__c  rp : trigger.old)
          {


          }
  
  }
}