/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 04-04-2021
 * @last modified by  : Iamsfdeveloper
 * Modifications Log 
 * Ver   Date         Author           Modification
 * 1.0   03-30-2021   Iamsfdeveloper   Initial Version
**/
import {  LightningElement,api,track } from 'lwc';

export default class DonationSchedule extends LightningElement {
@api recurringDonations =[];
@api donationTotal =0.00;
@api currencyCode ='GBP';
@track __rowEditable=false;
@api
get rowEditable() {
  return this.__rowEditable;
}
set rowEditable(value) {
  this.__rowEditable = value;
}
draftValues={};
rowOffset = 0;
draft_donations =[];
columns = [];
__initRender = false;
renderedCallback(){
if(this.__initRender)return;
this.columns  = [
    { label: 'Donation Date', fieldName: 'closeDate',type: 'date',editable:false},
    { label: 'Description', fieldName: 'Description', type: 'text',editable:false},
    { label: 'Amount', fieldName: 'amount', type: 'currency',editable:this.__rowEditable,cellAttributes:{ class: 'slds-p-right_small',alignment: 'center'}} 
];
this.__initRender = true;
}
handleSave(event){
    const saveUpdateDonationList= new CustomEvent('updateddonation', {
        detail:{donations:this.draft_donations,totalUpdatedAmount:this.donationTotal}});
        this.dispatchEvent(saveUpdateDonationList);
}
handleCellChange(event){

    event.detail.draftValues.forEach(item=>{
         this.draftValues[item.id] = item.amount;
     });
     let total = parseFloat(0.00);
     this.draft_donations=[];
    this.recurringDonations.forEach(item=>{
        let obj = Object.assign({},item);
        if(this.draftValues[obj.id]){
            total +=parseFloat(this.draftValues[obj.id]);
            obj.amount = parseFloat(this.draftValues[obj.id]);
        }else
            total +=parseFloat(obj.amount);
        this.draft_donations.push(obj);
    });
    this.donationTotal= total.toFixed(2);

 }
}