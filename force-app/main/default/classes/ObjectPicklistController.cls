public class ObjectPicklistController {

	public ObjectPicklistController() {

	}

	@AuraEnabled
	public static List<SObject> getRecords(String objectApiName, Integer limitOfRecords) {
		String query = 'SELECT Id, Name FROM ' + String.escapeSingleQuotes(objectApiName) + ' LIMIT ' + limitOfRecords;
		return Database.query(query);
	}

}