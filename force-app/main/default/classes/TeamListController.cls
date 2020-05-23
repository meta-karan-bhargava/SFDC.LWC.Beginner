public class TeamListController {

	public TeamListController() {

	}
	
	@AuraEnabled
	public static List<SObject> getMemberRecords(Id teamId) {
		String query = 'SELECT Id, Name, Skills__c, Team__r.Name FROM Team_Member__c WHERE Team__c = :teamId';
		return Database.query(query);
	}

}