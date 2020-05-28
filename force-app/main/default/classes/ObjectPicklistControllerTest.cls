@isTest
private class ObjectPicklistControllerTest {
	static final Integer NUMBER_OF_RECORDS = 5;

	@isTest
	static void testGetRecords_AccountSObject_returnsCreatedRecords() {
		// Given
		List<Account> accountsList = new List<Account>();
		for(Integer index = 0; index < NUMBER_OF_RECORDS; index++) {
			accountsList.add(new Account(
				Name = 'Test Account Number ' + index
			));
		}
		insert accountsList;

		// When
		Test.startTest();
		List<SObject> fetchedRecords = ObjectPicklistController.getRecords(String.valueOf(Account.SObjectType), 10);
		Test.stopTest();

		// Then
		System.assertEquals(NUMBER_OF_RECORDS, fetchedRecords.size(), 'Should fetch the records within limit specified');
		Boolean areAllAccountRecords = true;
		for(SObject obj : fetchedRecords) {
			if(!(obj instanceOf Account)) {
				areAllAccountRecords = false;
				break;
			}
		}
		System.assert(areAllAccountRecords, 'All records should be of Account SObjectType');
	}

}