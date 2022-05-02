/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 10-21-2021
 * @last modified by  : Iamsfdeveloper
 * Modifications Log 
 * Ver   Date         Author           Modification
 * 1.0   11-19-2020   Iamsfdeveloper   Initial Version
**/
import { LightningElement, wire, track, api } from 'lwc';
import doInit from '@salesforce/apex/HA_newDonationController.doInit';
import getItems from '@salesforce/apex/HA_newDonationController.getItems';
import getItemsPriceByCampaignId from '@salesforce/apex/HA_newDonationController.getItemsPriceByCampaignId';
import paymentSchedules from '@salesforce/apex/HA_Utility.getPaymentSchedules';
import saveAllocation from '@salesforce/apex/HA_newDonationController.saveAllocation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
//import { getPicklistValues } from 'lightning/uiObjectInfoApi';
//import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { NavigationMixin } from 'lightning/navigation';

export default class NewDonation extends NavigationMixin(LightningElement) {

    /**Public Properties */
    @api
    showContactField;
    @api
    showAccountField;

    __initRender = false;
    @track showCancelConfirm;
    @track opportunityId;
    @track __recordId;
    @track contactId;
    @track accountId;
    @track leadId;
    @track hideQuantity;
    @track selectedOrphan = [];
    @track campaignItemPrice={};
   
    @track itemList;
    @track itemAllocations = [];
    @track paymentRecordTypeId = '';
    @track recurringDonationList = [];
    get totalAmount(){
        let totalDonationAmount = 0.00;
        
        this.itemAllocations.forEach(function(item){
            totalDonationAmount += item.npsp__Amount__c
        });
        return parseFloat(totalDonationAmount).toFixed(2);
    }
    donationType ='SD';
    searchKey ='';
    queryFilter;
    __paymentScheduleId;
    allowedPaymentOptions=[];
    donationSingleRecordTypeId ;
    donationPaymentPlanRecordTypeId;
    stipulationOptions = [];
    stipulationType = '';
    countryList=[];
    currencyISOCode;
    selectedCountry ='';
    today;
    unAllocatedAmount=0.00;
    __campaignId;
    showSchedule=false;
    loadedSpinner = true;
    donationStartDate;
    showRecurringDonationType = false;
    showNumberOfInstallments = false;
    showNightSettings = false;
    startDateOptions =[];
    hideXFactor = false;
    disabledSave = true;

    /* xFactor Multiplies Specific Day with selected value */
    @track xFactor_1 ={label:'Day of Arafat',helpText:'Multiple Donation on Day of Arafat',value:0};
    @track xFactor_2 ={label:'Eid al-Adha',helpText:'Multiple Donation on Eid al-Adha',value:0};
    
    xFactor1Options = [...this.generateXFactorOptions()];
    xFactor2Options = [...this.generateXFactorOptions()];

    startDate;
    get disabledSaveBtn(){
         return this.disabledSave;
    }
    @api 
    get paymentScheduleId(){
        return this.__paymentScheduleId;
    }
    set paymentScheduleId(value){
        this.__paymentScheduleId = value;
        this.__campaignId = '';
    }
    @api 
    get recordId(){
        return this.__recordId;
    }
    set recordId(value){
        if(value.startsWith('003')){
            this.__recordId = value;
            this.contactId = value;
        }else if(value.startsWith('001')){
            this.__recordId = value;
            this.accountId = value;
        }else{
            this.__recordId = value;
            this.opportunityId = value;
        }
    }
   
   
   @api 
   get campaignId(){
       return this.__campaignId;
   }
   set campaignId(value){
       if(value != null){
            this.__campaignId = value;
       
    }
   }
   
   handleCampaignChange(event){
      let campaignId =  event.detail.value[0];
      this.__campaignId = (campaignId !=undefined)?campaignId:'';
   }
   handleCloseDateChange(event){
       let closeDate = event.detail.value;
       console.log('closeDate '+closeDate);
    if(this.template.querySelector("lightning-input-field[data-id=Effective_Date__c]")){
            let eDate = new Date(closeDate);
             eDate.setDate(eDate.getDate()+1);
            this.template.querySelector("lightning-input-field[data-id=Effective_Date__c]").value = this.formatDate(eDate);
        }
    
   }
   renderedCallback(){
       if(this.__initRender)return;
       this.__initRender = true;
        let campaignField = this.template.querySelector("lightning-input-field[data-id=CampaignId]");
        if(!this.__initRender && campaignField !=  null && this.__campaignId != undefined){
            
            campaignField.value = this.__campaignId;
            this.template.querySelector("lightning-input-field[data-id=Medium__c]").value='Telephone';
            
            
        }
        
        if(this.template.querySelector("lightning-input-field[data-id=CloseDate]")){
            let d = new Date(Date.parse(this.today));
            this.template.querySelector("lightning-input-field[data-id=CloseDate]").value=this.formatDate(d);
            if(this.template.querySelector("lightning-input-field[data-id=Effective_Date__c]")){
                let eDate = new Date(Date.parse(this.today));
                 eDate.setDate(d.getDate()+1);
                this.template.querySelector("lightning-input-field[data-id=Effective_Date__c]").value = this.formatDate(eDate);
            }
        }
        if (this.__paymentScheduleId != undefined && this.paymentSchedulesMap.data[this.__paymentScheduleId].Code__c == 'EMI' && this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]")) {
            this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]").value = 'Fixed';
            this.showNumberOfInstallments = true;
            this.showNightSettings = false;
          }else if (this.__paymentScheduleId != undefined && this.template.querySelector("lightning-input-field[data-id=Number_of_Installments__c]") && (this.paymentSchedulesMap.data[this.__paymentScheduleId].Code__c == '10N' || this.paymentSchedulesMap.data[this.__paymentScheduleId].Code__c == '30N')) {
            this.xFactor_1 ={label:'27th Night',helpText:'Multiple Donation on 27th Night',value:0};
            this.xFactor_2={label:'Odd Night',helpText:'Multiple Donation on Odd Nights',value:0};
            this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]").value ='Fixed';
            this.template.querySelector("lightning-input-field[data-id=Number_of_Installments__c]").value =this.numberofDonations;
        } else if (this.__paymentScheduleId != undefined && this.template.querySelector("lightning-input-field[data-id=Number_of_Installments__c]") && this.paymentSchedulesMap.data[this.__paymentScheduleId].Code__c == '10D' ) {
            this.xFactor_1 ={label:'Day of Arafat',helpText:'Multiple Donation on Day of Arafat',value:0};
            this.xFactor_2 ={label:'Eid al-Adha',helpText:'Multiple Donation on Eid al-Adha',value:0};
            
            this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]").value ='Fixed';
            this.template.querySelector("lightning-input-field[data-id=Number_of_Installments__c]").value =this.numberofDonations;
        } else {
            this.showNightSettings = false;
            this.showNumberOfInstallments = false;
          }
       
   }
   get showEMI(){
       return (this.__paymentScheduleId != undefined && this.paymentSchedulesMap.data[this.__paymentScheduleId].Code__c == 'EMI');
   }
    get EMIAmt(){
    if (this.showEMI && this.template.querySelector("lightning-input-field[data-id=Number_of_Installments__c]")){
        return this.roundNumber(this.totalAmount / this.template.querySelector("lightning-input-field[data-id=Number_of_Installments__c]").value,1);
    }
    return 0.00;
        
    }
    roundNumber(num, precision) {
        precision = Math.pow(10, precision)
        return Math.ceil(num * precision) / precision
      }
   formatDate(__d){
        let d = new Date(__d),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();
    
        if (month.length < 2) 
            month = '0' + month;
        if (day.length < 2) 
            day = '0' + day;
        return [year, month, day].join('-');
    
   }
   get _xMultiplyFactorValue_1(){
    return this.xFactor_1.value;
    /*
    let xFactorValue = 0;
    let xFactor_1Element = this.template.querySelector("lightning-combobox-field[name=xFactor_1]");
    if( xFactor_1Element && xFactor_1Element.value !=''){
        xFactorValue = parseInt(this.template.querySelector("lightning-input-field[data-id=X27th_Night__c]").value);
    }
    return parseInt(xFactorValue);
    */
   }
   get _xMultiplyFactorValue_2(){
    return this.xFactor_2.value;  
    /*
    let xFactorValue = 0;
    let xFactor_2Element = this.template.querySelector("lightning-combobox-field[name=xFactor_2]");
    if(xFactor_2Element  && xFactor_2Element.value != ''){
        xFactorValue = parseInt(xFactor_2Element.value);
    }
    return parseInt(xFactorValue);
    */
   }
   get _xDivideFactorValue_1(){
    return (this.xFactor_1.value)?this.xFactor_1.value-1:0;
}
get _xDivideFactorValue_2(){
    return (this.xFactor_2.value)?this.xFactor_2.value -1:0;  
}
   get _OddNightMultiplyFactor(){
       if(!this.xFactor_2.value)
        this.xFactor_2.value;
        else
        return 1;
       /*
            let _OddNightFactor = 1;
            if(this.template.querySelector("lightning-input-field[data-id=Odd_Night__c]") && this.template.querySelector("lightning-input-field[data-id=Odd_Night__c]").value !=null && this.template.querySelector("lightning-input-field[data-id=Odd_Night__c]").value !=''){
                _OddNightFactor = parseInt(this.template.querySelector("lightning-input-field[data-id=Odd_Night__c]").value);
            }
            return parseInt(_OddNightFactor);
        */
   }
   get _OddNightDivideFactor(){
    if(!this.xFactor_2.value)
    return parseInt(this.oddNights.length);
    else
    return 0;
    
    /*
        if(this.template.querySelector("lightning-input-field[data-id=Odd_Night__c]") && this.template.querySelector("lightning-input-field[data-id=Odd_Night__c]").value !=null && this.template.querySelector("lightning-input-field[data-id=Odd_Night__c]").value !='')
            return parseInt(this.oddNights.length);
        else
        return 0;
    */
   }
   
   handleXFactorChange(event){
       if(event.target.name=='xFactor_1')
       this.xFactor_1.value = parseInt(event.detail.value);
       else
       this.xFactor_2.value = parseInt(event.detail.value);
   this.generateRecurringDonations();
    
   }
   get oddNights(){
       let oddDates=[];
       if(this._OddNightMultiplyFactor>1){
        let _10NStartDate = new Date(this.startDate);
        _10NStartDate.setDate(_10NStartDate.getDate()+20);
        let _10NEndDate =  new Date(this.startDate);
        _10NEndDate.setDate(_10NEndDate.getDate()+30);
        for(let x=0;x<10;x++){
        let startDate =  new Date(_10NStartDate);
        startDate.setDate(startDate.getDate()+x);
            if(x%2==0 && startDate >= new Date(this.today)){
                oddDates.push(Date.parse(startDate));
            }
        }
       }
       return oddDates;
   }
   get _27Night(){
    let _27nights=[];
    if(this.DonationCode =='30N' || this.DonationCode =='10N'){
        let startDate =  new Date(this.startDate);
        startDate.setDate(startDate.getDate()+26);
        _27nights.push(Date.parse(startDate));
    }
    return _27nights;
}
   get numberofDonations(){
       if(this.DonationCode =='30N'){
        if(new Date(this.today)>new Date(this.startDate))
         return parseInt(30-this.getDaysDiff(new Date(this.startDate),new Date(this.today)));
         
         return 30;
       }
       else if(this.DonationCode =='10N'){
        let endDate = new Date(this.startDate);
        endDate.setDate(endDate.getDate()+30);

        let days = this.getDaysDiff(endDate,new Date(this.today));
        return (days>10 || days ==0)?10:days;
       }else if(this.DonationCode =='10D'){
            let endDate = new Date(this.startDate);
            endDate.setDate(endDate.getDate()+9);
            let days = this.getDaysDiff(endDate,new Date(this.today));
            return (days>10 || days ==0)?10:days;
       }else{
           return 0;
       }
    
   }
   generateRecurringDonations(){
       if(this.itemAllocations.length ==0){
        this.recurringDonationList = [];
        return;
    }
    if(!this.hideXFactor){
        this.unAllocatedAmount = this.totalAmount;
    }
    if(this.hideXFactor && this.recurringDonationList.length>0)
    return;
       if(this.opportunityId == undefined){
            let recurringDonationList = [];
            let donationCount = 1;
            let totalAmount = parseFloat(this.unAllocatedAmount);
            let ramadanstartDate = new Date(this.startDate);
            let tenNightStartDate  = new Date(this.startDate);
            tenNightStartDate.setDate(tenNightStartDate.getDate()+20);
            
            let today= new Date(this.today);
            let numberofDonations = this.numberofDonations;;
            let donationStartDate = new Date(this.today);
            if(this.DonationCode =='10N'){
                donationCount = (numberofDonations == 10)?21:numberofDonations;
                if(today<tenNightStartDate)
                donationStartDate = new Date(tenNightStartDate);
                
            }else if(this.DonationCode =='30N'){
                donationCount = (numberofDonations == 30)?1:parseInt(1+30-numberofDonations);
                if(today<ramadanstartDate)
                donationStartDate = new Date(ramadanstartDate);
            }
            if(this.DonationCode =='30N' || this.DonationCode =='10N'){
            this.donationStartDate = donationStartDate;
            let oddDate = this.oddNights;
            let _27Night = this._27Night;
            let _27MultFactor = this._xFactorValue_1;
            let _OddMulNightFactor = this._OddNightMultiplyFactor;
            let _27NightDivFactor = this._xMultiplyFactorValue_2;
            let _oddNightDivFactor = this._OddNightDivideFactor;
            if(_27MultFactor>1 && _OddMulNightFactor>1)
            _oddNightDivFactor = _oddNightDivFactor-1;
            if(_OddMulNightFactor >1){
                _oddNightDivFactor = parseInt(_oddNightDivFactor * parseInt(_OddMulNightFactor-1));
            }
            let numberofDonations_divisor= (_27NightDivFactor ==0)?parseInt(numberofDonations+_oddNightDivFactor):parseInt(numberofDonations+_27NightDivFactor+_oddNightDivFactor);
           
            let donationAmount = parseFloat(totalAmount/numberofDonations_divisor).toFixed(2);
            let allocatedDonationAmount = 0.00;
            for(let x = 0;x<numberofDonations;x++){
                let desc = 'Night-'+parseInt(donationCount+x);
                let closeDate = new Date(donationStartDate);
                closeDate.setDate(closeDate.getDate()+x);
                let amount = donationAmount;
                if(oddDate.includes(Date.parse(closeDate)) && _OddMulNightFactor>1)
                    amount = parseFloat(donationAmount * _OddMulNightFactor);
                if(_27Night.includes(Date.parse(closeDate)) && _27MultFactor >1)
                    amount = parseFloat(donationAmount * _27MultFactor);
                if(x==numberofDonations-1)
                    amount =parseFloat(totalAmount - allocatedDonationAmount).toFixed(2);
                    recurringDonationList.push({
                        id:'donation-'+x,
                        closeDate:this.formatDate(closeDate),
                        amount:amount,
                        npsp__Primary_Contact__c:this.contactId,
                        Name:'System Generated',
                        StageName:'Pledged',
                        Description:desc

                    });
                allocatedDonationAmount=  parseFloat(allocatedDonationAmount) + parseFloat(amount);
            }
            
            this.recurringDonationList = [...recurringDonationList];
        }else if(this.DonationCode =='10D'){
            let endDate  = new Date(this.startDate);
           
            if(today<new Date(this.startDate)){
                donationStartDate = new Date(this.startDate);
                endDate.setDate(endDate.getDate() + 9);
            }else{
                donationStartDate.setDate(donationStartDate.getDate() + 1);
                endDate.setDate(endDate.getDate() + 10);
            }

            this.donationStartDate = donationStartDate;
            //if()

            let _9Day = new Date(endDate);
            _9Day.setDate(_9Day.getDate() - 1);
            let _10Day = new Date(endDate);
            let numberofDonations_divisor= parseInt(numberofDonations+this._xDivideFactorValue_1+this._xDivideFactorValue_2);
           
            let donationAmount = parseFloat(totalAmount/numberofDonations_divisor).toFixed(2);
            let allocatedDonationAmount = 0.00;
            for(let x = 0;x<numberofDonations;x++){
                let desc = 'Day-'+parseInt(donationCount+x);
                let closeDate = new Date(donationStartDate);
                closeDate.setDate(closeDate.getDate()+x);
                let amount = donationAmount;
                if(Date.parse(_10Day)==Date.parse(closeDate) && this._xMultiplyFactorValue_2 >0)
                    amount = parseFloat(donationAmount * this._xMultiplyFactorValue_2).toFixed(2);
                if(Date.parse(_9Day) == Date.parse(closeDate) && this._xMultiplyFactorValue_1 >0)
                    amount = parseFloat(donationAmount * this._xMultiplyFactorValue_1).toFixed(2);
                //if(x+1 == numberofDonations)
                    //amount =parseFloat(totalAmount - allocatedDonationAmount).toFixed(2);
                    recurringDonationList.push({
                        id:'donation-'+x,
                        closeDate:this.formatDate(closeDate),
                        amount:amount,
                        npsp__Primary_Contact__c:this.contactId,
                        Name:'System Generated',
                        StageName:'Pledged',
                        Description:desc

                    });
                allocatedDonationAmount=  parseFloat(allocatedDonationAmount) + parseFloat(amount);
            }
            
            this.recurringDonationList = [...recurringDonationList];
        }
       }
       
   }
   toggleShowDonationSchedule(){
        this.showSchedule = (!this.showSchedule)?true:false;
        this.generateRecurringDonations();
   }
   updateDonationSchedule(){
       console.log(this.recurringDonationList);
   }
    @wire(doInit)
    paymentType({error,data}){
        if(data){
            this.donationSingleRecordTypeId = data['single']; 
            //this.donationPaymentPlanRecordTypeId = data['paymentPlan']; 
            this.stipulationOptions = data['stipulationType'];
            let defaultStipulationType =[];
            this.stipulationOptions.forEach(function(item){
                 defaultStipulationType.push(item.value);
            });
            this.stipulationType = defaultStipulationType.join(',');
            let countryList = Array.from(data['countryList']);
            countryList.unshift({defaultValue: true,label:'All',value:''});
            this.countryList = countryList;
            this.currencyISOCode = data['currencyISOCode'];
            this.today = data['today']
            this.queryFilter = '';
            this.__campaignId = '';
        }
        console.log('error '+error);
    };
    @wire(paymentSchedules)
    paymentSchedulesMap;

    get DonationCode(){
       return (this.__paymentScheduleId != undefined && this.paymentSchedulesMap != undefined)? this.paymentSchedulesMap.data[this.__paymentScheduleId].Code__c:'SD';
    }
    set DonationCode(value){
        if(this.paymentSchedulesMap.data != undefined)
        this.donationCode = this.paymentSchedulesMap.data[value].Code__c;
    }
    @wire(getItems,{queryFilter:'$queryFilter',currencyISOCode:'$currencyISOCode',paymentScheduleId:'$__paymentScheduleId',campaignId:'$__campaignId'})
    buildItems({error,data}){
        if(data){
            let items = data['items'];
            let campaignItemPrice = data['campaignItemPrice'];
            let tempDataList = [];
            let selectedList = this.itemAllocations;
            let paymentSchedulesMap = this.paymentSchedulesMap;
            let __paymentScheduleId = this.__paymentScheduleId;
            let donationCode = paymentSchedulesMap.data[__paymentScheduleId].Code__c;
            items.forEach(item=>{
                
                    let tempObj = Object.assign({},item);
                    let unitPrice = (tempObj.Price_Book_Entries__r)?(paymentSchedulesMap.data[__paymentScheduleId].Frequency__c =='Yearly')?tempObj.Price_Book_Entries__r[0].Annual_Price__c:tempObj.Price_Book_Entries__r[0].UnitPrice:(campaignItemPrice != undefined && campaignItemPrice[item.Id] != undefined)?campaignItemPrice[item.Id]:1;
                     let obj = {'minPrice':unitPrice,'npsp__General_Accounting_Unit__c':tempObj.Id,'Stipulation_Type__c':'','Quantity__c':1,'UnitPrice':unitPrice,Name__c:'',Date_of_Birth__c:undefined,'npsp__Amount__c':parseFloat(1*unitPrice),npsp__General_Accounting_Unit__r:tempObj};
                    
                    if(tempObj.Stipulation__c){
                        let ItemStipulations = tempObj.Stipulation__c.split(';');
                        obj.Stipulation_Type__c = ItemStipulations[0];
                    }
                    tempDataList.push(obj);
            });
        
            this.itemList=[...tempDataList];
        }else{
            console.log(error);
        }
            
    }
    getDaysDiff(sourceDate,targetDate){
    let diffTime;
    //if(targetDate>sourceDate)
    diffTime =  Math.abs(targetDate - sourceDate);
   // else 
    //diffTime =  Math.abs(sourceDate - targetDate);
    let diffDays =  Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays;
    }
    addItemAllocation(event){
        
        if(this.itemAllocations.length < 50){
            let selectedIndex ;
            let selectedItem =  this.itemList.find(function(o,ind){
                    if(o.npsp__General_Accounting_Unit__c === event.target.name){
                        selectedIndex = ind;
                        return o;
                    }
                    });
            //this.newDonationOpp.Amount = parseFloat(this.newDonationOpp.Amount + selectedItem.npsp__Amount__c);
            //this.itemList.splice(selectedIndex,1);
            this.itemAllocations.push(selectedItem);
            
            //if(this.itemAllocations.length ==10) 
             //this.disabledAddBtn = true;
        }
        if(this.itemAllocations.length)
            this.disabledSave =  false;
    }
    get disabledAddBtn(){
        return (this.itemAllocations.length == 50);
           
    }
    handleStartDateChange(event){
        this.startDate = event.detail.value;
        this.recurringDonationList = [];
        this.generateRecurringDonations();
    }
    handleChange(event){
        let searchFilters  = this.template.querySelectorAll(".searchFilter");
        let queryFilters = [];
        searchFilters.forEach(item=>{
            if(item.name){
            if(item.name==='Stipulation__c' && item.value != ''){
                let val =[];
                item.value.toString().split(',').forEach(function(x){
                val.push('\''+x+'\'');
                });
                val ='('+val.join(',')+')';
                queryFilters.push(item.name+' includes '+val);
            }else if(item.value != ''){
                queryFilters.push(item.name+'=\''+item.value+'\'');
            }
        }else if(item.fieldName !='Payment_Schedule__c'){
                queryFilters.push(item.fieldName+'=\''+item.value+'\'');
        }
        });
        this.currencyISOCode = this.template.querySelector("lightning-input-field[data-id=CurrencyIsoCode]").value;
        this.queryFilter = queryFilters.join(' AND ');
    }
    handleKeyUp(event){
        
        if (event.target.value)
            this.searchKey = event.target.value.trim();
         if(this.searchKey.length>2) {
            let searchFilters  = this.template.querySelectorAll(".searchFilter");
        let queryFilters = [];
        searchFilters.forEach(function(item){
                    if(item.name){
                    if(item.name==='Stipulation__c' && item.value != ''){
                        let val =[];
                        item.value.toString().split(',').forEach(function(x){
                        val.push('\''+x+'\'');
                        });
                        val ='('+val.join(',')+')';
                        queryFilters.push(item.name+' includes '+val);
                    }else if(item.value != ''){
                        queryFilters.push(item.name+'=\''+item.value+'\'');
                    }
                }else if(item.fieldName !='Payment_Schedule__c'){
                    queryFilters.push(item.fieldName+'=\''+item.value+'\'');
                }
        });
            this.searchKey = event.target.value;
            let queryFilter = queryFilters.join(' AND ');
            this.queryFilter = queryFilter + 'AND ( Name like \'%'+this.searchKey+'%\' OR  Donation_Item_Code__c Like \'%'+this.searchKey+'%\')';
            this.currencyISOCode = this.template.querySelector("lightning-input-field[data-id=CurrencyIsoCode]").value;
        }else{
            this.handleChange();
        }
    }
    saveAndNext(event){
        //let this.template.querySelector('lightning-record-edit-form');
        const btn = this.template.querySelector( ".hidden" );

        if( btn ){ 
           btn.click();
        }
    }
    handleSubmit(event){
        this.loadedSpinner =false;
        console.log(this.contactId);
        event.preventDefault();       // stop the form from submitting
        const fields = event.detail.fields;
        console.log(fields.CloseDate);
        if(fields.CloseDate == undefined)
        fields.CloseDate = this.today;
        fields.EMIAmount__c = this.EMIAmt;
        
        fields.Name='System Generated';
        fields.Amount = this.totalAmount;
        let donationCode = this.paymentSchedulesMap.data[this.__paymentScheduleId].Code__c;
        fields.StageName = 'Awaiting Payment Details';
        fields.RecordTypeId = this.donationSingleRecordTypeId;
        if(donationCode =='SD'){
            //fields.StageName = 'Awaiting Payment Details';
            //fields.RecordTypeId = this.donationSingleRecordTypeId;
            fields.Type='Donation';
        }else{
           // fields.StageName = 'Setup';
           // fields.RecordTypeId = this.donationPaymentPlanRecordTypeId;
            fields.Type='Payment Plan - Source';
        }
        if(donationCode =='30N' || donationCode =='10N' || donationCode =='10D'){
            if(this.donationStartDate != undefined)
            fields.Effective_Date__c = Date.parse(this.donationStartDate);
            if(this.itemAllocations.length == 0)
                this.generateRecurringDonations();
            let unitPrice = this.numberofDonations;
            if(fields.Amount<unitPrice){
            this.loadedSpinner =true;
            const event = new ShowToastEvent({
            "title": "Error Occurred!",
            "variant":"error",
            "message": ' Minimum Donation Amount should be '+unitPrice+'!!'
            });
            this.dispatchEvent(event);
            return;
            }
        
        if(this.hideXFactor && this.totalUnAllocatedAmount != 0.00){
            this.loadedSpinner =true;
            const event = new ShowToastEvent({
                "title": "Schedule Donations Mismatch!",
                "variant":"error",
                "message": ' The Unallocated Amount must be 0.00!!'
                });
                this.dispatchEvent(event);
                return;
                }
        }
        fields.Donation_Type__c = this.paymentSchedulesMap.data[this.__paymentScheduleId].Code__c ;
        if(this.contactId)
        fields.npsp__Primary_Contact__c	 = this.contactId;
        if(this.accountId)
        fields.accountId = this.accountId;
        fields.Payment_Schedule__c = this.__paymentScheduleId;
        if(this.opportunityId)fields.Id = this.opportunityId;
        if(this.validateAllocations()){
            //this.loadedSpinner =true;
            console.log('No Error occured');
            this.handleSuccess(fields)
            //this.template.querySelector('lightning-record-edit-form').submit(fields);
        }else{
            this.loadedSpinner =true;
            const event = new ShowToastEvent({
                "title": "Error Occurred!",
                "variant":"error",
                "message": ' Please Enter Required Information !!'
            });
            this.dispatchEvent(event);
            console.log('Error occured');
        }
            //
    }
    handleSuccess(fields){
        try{
        this.disabledSave = true;
        let tempList = Array.from(this.itemAllocations);
        let tempSpecialList = [];
        let specialInt = 0;
        this.itemAllocations.forEach(function(item,ind){
            let obj = Object.assign({},tempList[ind]);
            //obj.npsp__Opportunity__c =event.detail.id;
            if(obj.specialInstructions != undefined && Object.keys(obj.specialInstructions).length != 0){
                obj.specialInstructions.specialIndex = specialInt;
                tempSpecialList.push(Object.assign({},obj.specialInstructions));
                obj.Special_Instruction_Index__c = specialInt;
                specialInt = specialInt + 1;
            }
            delete obj.npsp__General_Accounting_Unit__r;
            delete obj.specialInstructions;
            tempList[ind]=obj;

        });
        let taskList = [];
        let contactId = this.contactId;
        if(tempSpecialList.length>0)
        tempSpecialList.forEach(function(item,ind){
            let taskObj = {WhoId:contactId,Subject:item.subject};
            let description ='';
            let taskDesc= [];
            taskObj.Special_Instruction_Index__c = item.specialIndex;
            item.instructionList.forEach(function(tempObj){
            for (const [key, value] of Object.entries(tempObj)) {
                description +=' '+`${key}: ${value}`;

            }
            description +='\n======================\n';
            });
            taskObj.Description = description;
            taskList.push(taskObj);
        });
        console.log('opp Details'+JSON.stringify(fields));
        saveAllocation({opportunityDetail:JSON.stringify(fields),itemAllocation:JSON.stringify(tempList),  specialInstruction:JSON.stringify(taskList), recurringDonations:JSON.stringify(this.recurringDonationList)}).then((result) => {
           
            this.loadedSpinner =true;
            this.opportunityId = result.Id;
            const OpenDonationEvent = new CustomEvent('opendonation', {
                detail: { donationId: result.Id}});
                this.dispatchEvent(OpenDonationEvent);
        
        })
        .catch(error => {
            this.disabledSave = false;
            console.log('error '+error);
            let errorMsg = error.body
            const event = new ShowToastEvent({
                "title": "Error Occurred!",
                "variant":"error",
                "message": error.body.message+' !'
            });
            this.dispatchEvent(event);
            this.loadedSpinner = true;
        });
    }catch(error){
        this.disabledSave = false;
        console.log('error '+error);
        const event = new ShowToastEvent({
            "title": "Error Occurred!",
            "variant":"error",
            "message": error+' !!'
        });
        this.dispatchEvent(event);
        this.loadedSpinner =true;
    }
    }
    handleDelete(event){
       const deleteIndex = event.detail;
       let selectedItem = this.itemAllocations[deleteIndex];
       let unitPrice = (selectedItem.npsp__General_Accounting_Unit__r.Price_Book_Entries__r)?selectedItem.npsp__General_Accounting_Unit__r.Price_Book_Entries__r[0].UnitPrice:3;
       selectedItem.Receipt_Note__c = '';
       selectedItem.Quantity__c = 1;
       selectedItem.UnitPrice = unitPrice;
       selectedItem.npsp__Amount__c = parseFloat(selectedItem.Quantity__c * unitPrice);
       selectedItem.specialInstructions = {};
       this.itemAllocations.splice(deleteIndex,1);
       this.generateRecurringDonations();
    }
    handleItemChange(event){
        const updateIndex = event.detail.index;
        const changeItem = event.detail.change;
        this.itemAllocations[updateIndex] = changeItem;
        if(changeItem.Orphan__c){
            this.selectedOrphan.push(changeItem.Orphan__c);
        }
        if(!this.hideXFactor)
          this.generateRecurringDonations();
    }
    handleDonationTypeChange(event){
        this.__paymentScheduleId = event.detail;
        this.DonationCode = event.detail;
        this.itemAllocations = [];
        this.recurringDonationList = [];
        let donationCode =this.donationCode;
        this.showRecurringDonationType = (donationCode != undefined && donationCode !='SD');
        if(donationCode =='EMI' ){
            this.showNumberOfInstallments = true;
            if(this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]"))
                this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]").value ='Fixed';
           
        }else if(donationCode =='10N' || donationCode =='30N' || donationCode =='10D'){
            this.showNightSettings = true;
            this.showNumberOfInstallments = true;
            if(this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]"))
            this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]").value ='Fixed';
           this.generateStartDates();
        }else{
            if(this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]"))
                this.template.querySelector("lightning-input-field[data-id=Recurring_Type__c]").value ='Open';
            this.showNumberOfInstallments = false;
            this.showNightSettings = false;
        }
        this.__initRender = false;
    }
    generateStartDates(){
       let paymentScheduleData =  this.paymentSchedulesMap.data[this.__paymentScheduleId];
       console.log(paymentScheduleData);
        let Options = [];
        this.startDate = paymentScheduleData.Start_Date__c;
        Options.push({label:paymentScheduleData.Start_Date__c,value:paymentScheduleData.Start_Date__c});
        Options.push({label:paymentScheduleData.Start_Date_2__c,value:paymentScheduleData.Start_Date_2__c});
        Options.push({label:paymentScheduleData.Start_Date_3__c,value:paymentScheduleData.Start_Date_3__c});
        this.startDateOptions =[...Options];
        return;
    }
    handleRecurringTypeChange(event){
        this.showNumberOfInstallments = (event.detail.value != 'Open');
    }
    validateAllocations(){
        let flag = true;
        let allocationItems = this.template.querySelectorAll('c-donation-item');
        if(allocationItems.length >0)
            allocationItems.forEach(item=>{
                if(item.validationCheck()){
                    flag = false;
                }else{
                    item.className= '';
                }
            });
            return flag;
    }
    handleCloneRequest(event){
        const cloneIndex = event.detail.index;
        let selectedItem = this.itemAllocations[cloneIndex];
        let cloneItem = Object.assign({},this.itemAllocations[cloneIndex]);
        let unitPrice = (selectedItem.npsp__General_Accounting_Unit__r.Price_Book_Entries__r)?selectedItem.npsp__General_Accounting_Unit__r.Price_Book_Entries__r[0].UnitPrice:3;
        cloneItem.Receipt_Note__c = '';
        cloneItem.Quantity__c = 1;
        cloneItem.Orphan__c=undefined;
        cloneItem.UnitPrice = unitPrice;
        cloneItem.npsp__Amount__c = parseFloat(cloneItem.Quantity__c * unitPrice);
        cloneItem.specialInstructions = {};
        this.itemAllocations.push(cloneItem);
    }
    showNotification(_title,_message,_variant) {
        const evt = new ShowToastEvent({
            title: _title,
            message: _message,
            variant: _variant,
        });
        this.dispatchEvent(evt);
    }
    handleCancel(event){
        this.showCancelConfirm= true;

    }
    handleCancelYes(event){
        const cancelDonation = new CustomEvent('canceldonation');
        this.dispatchEvent(cancelDonation);
    }
    handleCancelNo(event){
        this.showCancelConfirm= false;
    }
    handleManualScheduleDonations(event){
        if(event.detail.checked){
            if(this.template.querySelector("lightning-combobox[data-id=xFactor_1]")){
                this.template.querySelector("lightning-combobox[data-id=xFactor_1]").value =0;
                this.xFactor_1.value = 0;
            }
            if(this.template.querySelector("lightning-combobox[data-id=xFactor_2]")){
                this.template.querySelector("lightning-combobox[data-id=xFactor_2]").value =0;
                this.xFactor_2.value = 0;
            }
        }
        this.hideXFactor = event.detail.checked;
        this.recurringDonationList = [];
        this.unAllocatedAmount = this.totalAmount;
        this.generateRecurringDonations();
        
    }
    handleScheduleDonations(event){
            this.recurringDonationList = event.detail.donations;
            this.unAllocatedAmount = parseFloat(event.detail.totalUpdatedAmount).toFixed(2);
            this.showSchedule = false;
    }
    get totalUnAllocatedAmount(){
        let total_unAllocatedAmount = parseFloat(0.00);
        total_unAllocatedAmount= parseFloat(this.unAllocatedAmount-this.totalAmount).toFixed(2);
        if(this.unAllocatedAmount == 0.00) 
            total_unAllocatedAmount = parseFloat(0.00);
        return total_unAllocatedAmount;
    }
    generateXFactorOptions(){
        return [{label:'--None',value:0},{label:'2',value:2},{label:'3',value:3},
                {label:'4',value:4},{label:'5',value:5}];
        
    }
}