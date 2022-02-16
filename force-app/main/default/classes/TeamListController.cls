public class TeamListController {

	public TeamListController() {

	}
	
	@AuraEnabled
	public static List<SObject> getMemberRecords(Id teamId) {
		Integer limitOfRecords = Limits.getLimitDmlRows();

		// Adding query for tem members
		String query = 'SELECT Id, Name, Skills__c, Team__r.Name FROM Team_Member__c WHERE Team__c = :teamId ORDER BY Name LIMIT :limitOfRecords';
		return Database.query(query);
	}

}