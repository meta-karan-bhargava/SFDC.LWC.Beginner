import { LightningElement, track, api, wire } from 'lwc';
import getRecords from '@salesforce/apex/ObjectPicklistController.getRecords';
export default class ObjectPicklist extends LightningElement {
	@track value = '';
	@api requiredByParent = false;
	@api objectApiName;
	limitOfRecords = 10;
	options;

	connectedCallback() {
		var opts=[];
		getRecords({
			objectApiName: this.objectApiName,
			limitOfRecords: this.limitOfRecords
		})
		.then(results => {
			for(var index = 0 ; index < results.length; index++) {
				opts.push({label: results[index].Name, value:results[index].Id});
			}
			this.options=opts;
		})
		.catch(error => {
			console.log(error);
		});
	}

	handleChange(event) {
		event.preventDefault();
		this.value = event.detail.value;
		const selectedEvent = new CustomEvent('selected', {detail: this.value});
		this.dispatchEvent(selectedEvent);
	}

	@api
	resetPicklist() {
		this.value = '';
	}
}