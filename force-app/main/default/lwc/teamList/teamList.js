import { LightningElement, track } from 'lwc';
import getMemberRecords from '@salesforce/apex/TeamListController.getMemberRecords';
export default class TeamList extends LightningElement {
	teamId;
	@track memberDetails;
	@track loading = false;
	handleSelect(event) {
		this.loading = true;
		this.teamId = event.detail;
		getMemberRecords({
			teamId : this.teamId
		})
		.then(data => {
			if(data.length) {
				this.memberDetails = data;
			} else {
				this.memberDetails = null;
			}
			this.loading=false;
		})
		.catch(error => {
			this.loading=false;
			console.log(error);
		})
	}
}