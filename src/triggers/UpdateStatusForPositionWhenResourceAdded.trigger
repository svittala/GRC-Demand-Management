// This Trigger will update the Position Status From "A-Build"  to "D-Source" when a resource pool 
// will be created for a Position.
trigger UpdateStatusForPositionWhenResourceAdded on Resource_Pool__c (before insert, after insert, before update, after update) {   
	// Create an object to store Position Id for which resource pool has been created
	List<String> positionId = new List<String>();
	List<Position__c> lstPosition = new List<Position__c>();
	map<ID, List<Resource_Pool__c>> mapResourcePool = new map<ID, List<Resource_Pool__c>>();
	map<ID, Position__c> mapPosition = new map<ID, Position__c>();
	// Loop through all the newly created Resource Pool records
	for(Resource_Pool__c  resourcePool : trigger.new) {
		// Check if newly created Resource Pool records are mapped with any Position               
		if(resourcePool.Position_Allotment__c != null) {
		// If Resource Pool is created for a position then add them in the List
			positionId.add(resourcePool.Position_Allotment__c);
		}
	}
	
	if(positionId.size() > 0 ) {
		//Fetching the position record based on position ID
		lstPosition = [Select Status__c, Start_Date__c, Skill__c, Skill_Name__c, Project__c, Name, Location__c, Id, Duration__c, AllottedProfile__c, ResourcePool__c, (Select Id, Name, 
							Profile_ID__c, Next_Available_Date__c, Current_Position__c, Position_Allotment__c From Resource_Pool__r) From Position__c 
							where Id in :positionId];
		for(Position__c iteratorPosition : lstPosition){
			mapResourcePool.put(iteratorPosition.ID, iteratorPosition.Resource_Pool__r);
			mapPosition.put(iteratorPosition.ID, iteratorPosition);
		}
	}
	
	if(trigger.isInsert) {
		if(trigger.isAfter) {
			List<Position__c> modifiedPositionList= new List<Position__c>();
			for(Resource_Pool__c resourcePool : trigger.new){
				Position__c objPosition = mapPosition.get(resourcePool.Position_Allotment__c);
				boolean bflag = false;
				if(objPosition != null){					
					if(resourcePool.Current_Position__c == 'Yes'){
						objPosition.Status__c = 'E-Filled';
						objPosition.AllottedProfile__c = resourcePool.Profile_ID__c;
						objPosition.ResourcePool__c = resourcePool.ID;
						bflag = true;
					}
					else{
						if(objPosition.Status__c == 'A-Build'){
							objPosition.Status__c = 'D-Source';		
							bflag = true;				
						}
					}
					if(bflag){
						modifiedPositionList.add(objPosition);
					}
				}
			}
			update modifiedPositionList;
		}
		else{
			for(Resource_Pool__c resourcePool : trigger.new){
				if(resourcePool.Current_Position__c == 'Yes'){
					list<Resource_Pool__c> lstResourcePool = mapResourcePool.get(resourcePool.Position_Allotment__c);
					if(lstResourcePool != null && lstResourcePool.size() > 0){
						for(Resource_Pool__c iteratorResourcePool : lstResourcePool){
							if(iteratorResourcePool.Current_Position__c == 'Yes'){
								resourcePool.adderror('Resource already alloted to this position.');
							}
						}
					}
				}
			}
		}
	}
	else if(trigger.isUpdate){
		if(trigger.isAfter) {
			for(Resource_Pool__c resourcePool : trigger.new){
				if(resourcePool.Current_Position__c == 'Yes'){
					Position__c objPosition = mapPosition.get(resourcePool.Position_Allotment__c);
					if(objPosition != null){
						objPosition.Status__c = 'E-Filled';
						objPosition.AllottedProfile__c = resourcePool.Profile_ID__c;
						objPosition.ResourcePool__c = resourcePool.ID;
						objPosition.Resource_Email__c = resourcePool.Profile_Email__c;
						update objPosition;
					}
				}
			}
		}
		else{
			for(Resource_Pool__c resourcePool : trigger.new){
				Resource_Pool__c resourcePoolOld = Trigger.oldMap.get(resourcePool.ID);
				
				if(resourcePoolOld.Current_Position__c != 'Yes' && resourcePool.Current_Position__c == 'Yes'){
					system.debug(resourcePoolOld.Current_Position__c);
					list<Resource_Pool__c> lstResourcePool = mapResourcePool.get(resourcePool.Position_Allotment__c);
					if(lstResourcePool != null && lstResourcePool.size() > 0){
						for(Resource_Pool__c iteratorResourcePool : lstResourcePool){
							if(iteratorResourcePool.Current_Position__c == 'Yes'){
								resourcePool.adderror('Resource already alloted to this position.');
							}
						}
					}
				}
			}
		}
	}
}