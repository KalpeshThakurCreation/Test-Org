/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 06-24-2021
 * @last modified by  : Iamsfdeveloper
 * Modifications Log 
 * Ver   Date         Author           Modification
 * 1.0   11-16-2020   Iamsfdeveloper   Initial Version
**/

public  without Sharing class HA_newDonationController {
    @AuraEnabled(cacheable=true)
    public static Map<Id,Decimal> getItemsPriceByCampaignId(String campaignId , String currencyISOCode){
        Map<Id,Decimal> ItemsIdByPriceMap = new Map<Id,Decimal>();
       for(Campaign_Product_Allocation__c CPA:[Select Id,Item__c,Item_Price__c,CurrencyIsoCode FROM Campaign_Product_Allocation__c Where Campaign__c=:campaignId AND CurrencyIsoCode=:currencyISOCode])
            ItemsIdByPriceMap.put(CPA.Item__c,CPA.Item_Price__c);
       return ItemsIdByPriceMap;
    }
    
    public static List<HA_selectOption> getRamadanConfiguration(){
        List<HA_selectOption> startDates = new List<HA_selectOption>();
        Ramadan_Configuration__c config = Ramadan_Configuration__c.getValues(String.valueOf(System.Today().year()));
        if(config!= null){
        startDates.add(new HA_selectOption(config.start_Date_1__c.format(),String.valueOf(config.start_Date_1__c),true));
        startDates.add(new HA_selectOption(config.start_Date_2__c.format(),String.valueOf(config.start_Date_2__c),false));
        
        }return startDates;
    }
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> getItems(String queryFilter , String currencyISOCode,String paymentScheduleId,String campaignId){
        Map<String,Object> returnValue = new Map<String,Object>();
        Set<Id> itemsIds = new Set<Id>();
        for(Payment_Schedule_Allocation__c PSA:[Select Id,General_Accounting_Unit__c, Payment_Schedule__c FROM Payment_Schedule_Allocation__c Where Payment_Schedule__c =:paymentScheduleId AND General_Accounting_Unit__c != null AND General_Accounting_Unit__r.npsp__Active__c=true]){
            itemsIds.add(PSA.General_Accounting_Unit__c);
        }
        String currencyISOCodeFilter = 'WHERE CurrencyIsoCode =\''+currencyISOCode+'\'';
        String query = 'SELECT Id,Country__c,Sponsored_Orphan_Only__c,Skip_Special_Instruction__c,Price_Editable__c,Product_Type__c,Special_message__c,Donation_Item_Code__c,Name,toLabel(Stipulation__c) stipulationlabel,Stipulation__c ,(Select UnitPrice,Annual_Price__c,CurrencyIsoCode  FROM Price_Book_Entries__r '+currencyISOCodeFilter+') FROM npsp__General_Accounting_Unit__c Where Id IN: itemsIds ';
        System.debug('QueryFilter '+queryFilter);
        if(String.isNotEmpty(queryFilter)) 
            query = 'SELECT Id,Country__c,Sponsored_Orphan_Only__c,Skip_Special_Instruction__c,Price_Editable__c,Product_Type__c,Donation_Item_Code__c,Special_message__c,Name,toLabel(Stipulation__c) stipulationlabel,Stipulation__c,(Select UnitPrice,Annual_Price__c,CurrencyIsoCode  FROM Price_Book_Entries__r '+currencyISOCodeFilter+') FROM npsp__General_Accounting_Unit__c WHERE  Id IN: itemsIds AND '+queryFilter;
        System.debug('QueryFilter '+query);
        List<npsp__General_Accounting_Unit__c> ItemList = Database.query(query);
        If(String.isNotEmpty(campaignId)){
            returnValue.put('campaignItemPrice',getItemsPriceByCampaignId(campaignId,currencyISOCode));
        }
        returnValue.put('items',ItemList);
        return returnValue;
    }
    @AuraEnabled(cacheable=true) 
    public static Map<String,Object> doInit(){
        Map<String,Object>  returnValue= new Map<String,Object>();
        List<HA_selectOption> stipulationType = new List<HA_selectOption>();
        List<HA_selectOption> countryList = new List<HA_selectOption>();
        returnValue.put('single',(Object)Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Donation').getRecordTypeId());
        //returnValue.put('paymentPlan',(Object)Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Payment_Plan').getRecordTypeId());
        for(Schema.PicklistEntry ple:npsp__General_Accounting_Unit__c.Stipulation__c.getDescribe().getPicklistValues()){
            stipulationType.add(new HA_selectOption(ple.getLabel(),ple.getValue()));
        }
        returnValue.put('stipulationType',(Object)stipulationType);
        for(Schema.PicklistEntry ple:npsp__General_Accounting_Unit__c.Country__c.getDescribe().getPicklistValues()){
            countryList.add(new HA_selectOption(ple.getLabel(),ple.getValue(),ple.isDefaultValue()));
        }
        returnValue.put('countryList',(Object)countryList);
        returnValue.put('today',System.today());
        returnValue.put('currencyISOCode',(Object)UserInfo.getDefaultCurrency());
        returnValue.put('ramadanConfiguration',getRamadanConfiguration());
        return returnValue;
    }
    @AuraEnabled
    public static Opportunity saveAllocation(String opportunityDetail,String itemAllocation, String specialInstruction,String recurringDonations){
        
        Map<Integer,Id> specialIndexMap = New Map<Integer,Id>();
        List<npsp__Allocation__c> allocationList = new List<npsp__Allocation__c>();
        Opportunity opp = new Opportunity();
        List<Opportunity> recurringDonationsList = new List<Opportunity>();
        try{
            if(String.isNotEmpty(opportunityDetail)){
                opp = (Opportunity)JSON.deserialize(opportunityDetail,Opportunity.class);
                upsert opp;
            }
        if(String.isNotEmpty(itemAllocation)){
            System.debug('itemAllocation  '+itemAllocation);
            allocationList = (List<npsp__Allocation__c>)JSON.deserialize(itemAllocation,List<npsp__Allocation__c>.class);
            System.debug('allocationList '+allocationList);
            for(Integer i=0;i<allocationList.size();i++){
                allocationList[i].npsp__Opportunity__c = opp.id;
            }
            if(allocationList.size()>0)
            upsert allocationList;
        }
        if(opp.Donation_Type__c =='10D' || opp.Donation_Type__c =='10N' || opp.Donation_Type__c=='30N'){
            recurringDonationsList = (List<Opportunity>)JSON.deserialize(recurringDonations, List<Opportunity>.class);
            enqueueCreateDonations(opp, allocationList, recurringDonationsList);
        }
        for(npsp__Allocation__c na : allocationList){
        	if(na.Special_Instruction_Index__c !=null)
            specialIndexMap.put(Integer.valueOf(na.Special_Instruction_Index__c) ,na.Id);    
        }
        if(String.isNotEmpty(specialInstruction)){
            System.debug('specialInstruction '+specialInstruction);
            Id specialRecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Special Instructions').getRecordTypeId();
            List<Task> taskList = (List<Task>)JSON.deserialize(specialInstruction,List<Task>.class);
            for(Integer i=0;i<taskList.size();i++){
                taskList[i].whatId = opp.id;
                taskList[i].recordTypeId = specialRecordTypeId;
                if(specialIndexMap.containskey(Integer.valueof(taskList[i].Special_Instruction_Index__c))){
                	taskList[i].GAU_Allocation__c = specialIndexMap.get(Integer.valueof(taskList[i].Special_Instruction_Index__c))  ;  
                }
            }
            System.debug('taskList '+taskList);

            if(taskList.size()>0)
            upsert taskList;
        }
        }catch (DmlException de) {
            Integer numErrors = de.getNumDml();
            System.debug('getNumDml=' + numErrors);
            for(Integer i=0;i<numErrors;i++) {
                throw new CustomException(de.getDmlMessage(i));
            }
           
        }Catch(Exception ex){
            throw new CustomException(ex.getMessage());
        }
        return opp;
        
    }
   @AuraEnabled(cacheable=true)
    public static List<contact> getOrphanList(String selectedCountry,String recordId,String selectedAge,String selectedGender,String searchParam,string[] selectedRowIds){
        List<contact> orphanList = new List<contact>();
        System.debug('recordId '+recordId);
        if(String.isEmpty(recordId)){
            String query = 'SELECT Name,Id,Orphan_Is_Mother_Alive__c,Sponsoree_ID__c,Country__c,Current_Age__c ,Gender__c,Sponsorship_Status__c FROM Contact Where RecordType.DeveloperName=\'Orphan\' AND Is_Active__c=true AND Sponsorship_Status__c != \'Sponsored\' AND Sponsoree_Is_Reserved__c = false  AND Sponsoree_ID__c !=\'DefaultOrphan\'';
         	
            String queryFilter = '';
            
    
            if(String.isNotEmpty(searchParam)){
                String nameorId = '%'+searchParam+'%';
                queryFilter += ' AND ( Name like :nameorId OR Sponsoree_ID__c like :nameorId ) ';
            }
            
            if(String.isNotEmpty(selectedCountry) && selectedCountry != 'General')
                queryFilter += ' AND Country__c=\''+selectedCountry+'\' ';
            if(String.isNotEmpty(selectedGender))
                queryFilter += ' AND Gender__c=\''+selectedGender+'\' ';
            if(String.isNotEmpty(selectedAge))
                queryFilter += ' AND '+selectedAge;
            query += queryFilter+' order by Sponsorship_Status__c ,CreatedDate  limit 50';
            System.debug('query===>'+query);
            
                orphanList = Database.query(query);
            }else{
                orphanList = [SELECT Name,Id,Orphan_Is_Mother_Alive__c,Sponsoree_ID__c,Country__c,Current_Age__c ,Gender__c,Sponsorship_Status__c FROM Contact Where RecordType.DeveloperName='Orphan' AND Is_Active__c=true  AND (Donor_SF_ID_Sponsor__c =:recordId OR Id=:selectedRowIds)];
                
            }
        return orphanList;
    }
    @AuraEnabled(cacheable=true)
    public static List<contact> getOrphanByNameOrId(String searchParam,String country){
        List<contact> orphanList = new List<contact>();
        System.debug('searchParam '+searchParam);
        System.debug('country '+country);
            if(String.isNotEmpty(searchParam)){
                string queryFilter = '%'+searchParam+'%';
            if(country !='General'){
            orphanList = [SELECT Name,Id,Orphan_Is_Mother_Alive__c,Sponsoree_ID__c,Country__c,Age__c,Gender__c,Sponsorship_Status__c FROM Contact Where RecordType.DeveloperName='Orphan' AND Is_Active__c=true AND Sponsorship_Status__c != 'Sponsored' AND Sponsoree_Is_Reserved__c = false  AND Country__c=:country AND (Name like :queryFilter OR Sponsoree_ID__c like :queryFilter) AND Sponsoree_ID__c !='DefaultOrphan' order by Sponsorship_Status__c limit 100];
        }else{
                orphanList = [SELECT Name,Id,Orphan_Is_Mother_Alive__c,Sponsoree_ID__c,Country__c,Age__c,Gender__c,Sponsorship_Status__c FROM Contact Where RecordType.DeveloperName='Orphan' AND Is_Active__c=true AND Sponsorship_Status__c != 'Sponsored' AND Sponsoree_Is_Reserved__c = false  AND (Name like :queryFilter OR Sponsoree_ID__c like :queryFilter) AND Sponsoree_ID__c !='DefaultOrphan' order by Sponsorship_Status__c limit 100];
            }
        }//else if(String.isEmpty(searchParam) && String.isNotEmpty(country))
               // return  getOrphanList(country,'');
        return orphanList;
    }
    @AuraEnabled
    public static Boolean createTask(String obj,String parentRecordId){
        Task taskObj = (Task)JSON.deserialize(obj,Task.class);
		system.debug('parentRecordId'+parentRecordId);
        try {
            taskObj.ActivityDate = System.Today();
            if(!Test.isRunningTest() && parentRecordId instanceOf Id){
                AgentWork aw = [SELECT HandleTime, ActiveTime, SpeedToAnswer, CloseDateTime, AcceptDateTime, ServiceChannelId, Status, WorkItemId, UserId, Name, Id, AssignedDateTime, CreatedDate, LastModifiedDate, LastModifiedById FROM AgentWork WHERE WorkItemId=:parentRecordId order by CreatedDate  DESC limit 1];
                Long timediff = (System.now().getTime() - aw.AssignedDateTime.getTime())/1000;
                taskObj.CallDurationInSeconds = (Integer)timediff;
            }
            insert taskObj;
			if(parentRecordId instanceOf Id)
            updateCampaingMemberWithOutcome(taskObj.Call_OutCome__c,parentRecordId);
            return true;
        } catch (Exception ex) {
            throw new CustomException(ex.getMessage());
        }
    }
    @AuraEnabled
    public static Boolean createTaskAndUpdateRecord(String obj,String parentRecordId,String updateObj){
        Task taskObj = (Task)JSON.deserialize(obj,Task.class);
        Contact contactObj = (Contact)JSON.deserialize(updateObj, Contact.class);
        try {
            taskObj.ActivityDate = System.Today();
            if(!Test.isRunningTest()){
                AgentWork aw = [SELECT HandleTime, ActiveTime, SpeedToAnswer, CloseDateTime, AcceptDateTime, ServiceChannelId, Status, WorkItemId, UserId, Name, Id, AssignedDateTime, CreatedDate, LastModifiedDate, LastModifiedById FROM AgentWork WHERE WorkItemId=:parentRecordId order by CreatedDate  DESC limit 1];
                Long timediff = (System.now().getTime() - aw.AssignedDateTime.getTime())/1000;
                taskObj.CallDurationInSeconds = (Integer)timediff;
            }
            insert taskObj;
            updateCampaingMemberWithOutcome(taskObj.Call_OutCome__c,parentRecordId);
            upsert contactObj;
            return true;
        } catch (Exception ex) {
           throw new CustomException(ex.getMessage());
        }
    }
    
  
    public static void updateCampaingMemberWithOutcome(String callOutcome,String callRecordId){
        CampaignMember cm = [SELECT Id, Status, Call_List_Id__c FROM CampaignMember Where Call_List_Id__c=:callRecordId limit 1];
        cm.Status = callOutcome;
        upsert new Call_List__c(Id=callRecordId,isClosed__c=true);
        upsert cm;
	}
    
    //Custom Exception class
    public class CustomException extends Exception {
        
    }
    /**
    * @description 
    * @author Iamsfdeveloper | 03-31-2021 
    * @param Donation 
    * @param allocationList 
    * @param recurringDonationsList 
    **/
    Public static void enqueueCreateDonations(Opportunity Donation,List<npsp__Allocation__c> allocationList,List<Opportunity> recurringDonationsList){
        HA_CreateDonations_Queueable cdq = new HA_CreateDonations_Queueable(Donation.Id,allocationList,recurringDonationsList);
        System.enqueueJob(cdq);
    }
    /**
    * @description 
    * @author Iamsfdeveloper | 06-23-2021 
    * @return List<HA_selectOption> 
    **/
    @AuraEnabled(cacheable=true)
    public static List<HA_selectOption>  getCountryList(){
        List<HA_selectOption> countryList = new List<HA_selectOption>();
        try {
            for(Schema.PicklistEntry ple:npsp__General_Accounting_Unit__c.Country__c.getDescribe().getPicklistValues()){
                if(ple.getLabel() !='General')
                    countryList.add(new HA_selectOption(ple.getLabel(),ple.getValue(),ple.isDefaultValue()));
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return countryList;
    }
    
}