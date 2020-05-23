import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const PARENT_LOOKUP_FIELD = 'Team__c';
export default class MemberSkills extends LightningElement {
	teamId;
	@track loading = false;
	handleSubmit(event) {
		event.preventDefault();
		this.loading = true;
		var fields = event.detail.fields;
		fields[PARENT_LOOKUP_FIELD] = this.teamId;
		this.template.querySelector('lightning-record-edit-form').submit(fields);
	}

	handleSuccess() {
		this.resetForm();
		this.loading = false;
		const evt = new ShowToastEvent({
			title: "Success!",
			message: "The Team Member record has been saved successfully.",
			variant: "success",
		});
		this.dispatchEvent(evt);
	}

	handleError() {
		this.loading = false;
		const evt = new ShowToastEvent({
			title: "Error!",
			message: "An error occurred while attempting to save the Team Member record. Check the entered details!",
			variant: "error",
		});
		this.dispatchEvent(evt);
	}

	handleSelect(event) {
		this.teamId = event.detail;
	}

	resetForm() {
		const inputFields = this.template.querySelectorAll('lightning-input-field');
		if(inputFields) {
			inputFields.forEach(field => {
				field.reset();
			});
		}
		this.template.querySelector('c-object-picklist').resetPicklist();
	}
}