@isTest
private class TeamListControllerTest {
	static final Integer NUMBER_OF_TEAM_MEMBERS = 5;

	@isTest
	static void testGetMemberRecords_teamRecordId_getAllTeamMembers() {
		// Given
		Team__c team = new Team__c(Name = 'Test Team');
		insert team;
		List<Team_Member__c> memberList = new List<Team_Member__c>();
		for(Integer index = 0; index < NUMBER_OF_TEAM_MEMBERS; index++) {
			memberList.add(new Team_Member__c(
				Name = 'Test Team Member ' + index,
				Team__c = team.Id,
				Skills__c = 'Skill ' + index
			));
		}
		insert memberList;

		// When
		Test.startTest();
		List<SObject> teamMembers = TeamListController.getMemberRecords(team.Id);
		Test.stopTest();

		// Then
		System.assertEquals(NUMBER_OF_TEAM_MEMBERS, teamMembers.size(), 'Should fetch all the team members');
		Boolean isMemberOfTeam = true;
		for(SObject obj : teamMembers) {
			if(team.Id != obj.get('Team__c')) {
				isMemberOfTeam = false;
				break;
			}
		}
		System.assert(isMemberOfTeam, 'All team members should belong to team for which they are fetched');
	}
}