/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 04-06-2021
 * @last modified by  : Iamsfdeveloper
 * Modifications Log 
 * Ver   Date         Author           Modification
 * 1.0   04-06-2021   Iamsfdeveloper   Initial Version
**/
@isTest
public with sharing class RecurringDonations_TDTM_Runnable_Test {
    @TestSetup
    static void createData(){
        List<HA_Payment_Schedule__c> paymentScheduleList = (List<HA_Payment_Schedule__c>)TestFactory.createSObjectList(new HA_Payment_Schedule__c(Code__c='30N',Frequency__c='Daily',Is_Active__c=true),1,'TestFactoryDefaults.PaymentSchedulesDefaults');
        insert paymentScheduleList;
        System.debug(JSON.serialize(paymentScheduleList[0]));
        List<npsp__General_Accounting_Unit__c> items = (List<npsp__General_Accounting_Unit__c>)TestFactory.createSObjectList(new npsp__General_Accounting_Unit__c(),1,'TestFactoryDefaults.GeneralAccountUnitsDefaults');
        insert items;
        Payment_Schedule_Allocation__c PSA1 = new Payment_Schedule_Allocation__c(General_Accounting_Unit__c= items[0].Id,Payment_Schedule__c = paymentScheduleList[0].Id);
        insert PSA1;
        List<Contact> contactList = (List<Contact>) TestFactory.createSObjectList(
            new Contact(),
            1,
            true
        );
    } 
    @IsTest
    static void unit1(){
 
     List<npsp__Trigger_Handler__c> listHandlers = npsp.TDTM_Config_API.getCachedRecords();
 
     npsp__Trigger_Handler__c th = new npsp__Trigger_Handler__c();
     th.Name = 'RecurringDonations_TDTM_Runnable';
     th.npsp__Class__c = 'RecurringDonations_TDTM_Runnable';
     th.npsp__Object__c = 'npe03__Recurring_Donation__c';
     th.npsp__Trigger_Action__c = 'AfterInsert,AfterUpdate,BeforeUpdate';
     th.npsp__Active__c = true;
     th.npsp__Load_Order__c =0;
     th.npsp__Asynchronous__c = false;
     listHandlers.add(th);
 
     Test.startTest();
        List<Contact> contactList = [Select Id,Name From Contact];
        List<npsp__General_Accounting_Unit__c> items = [Select Id,Name  FROM npsp__General_Accounting_Unit__c Where Name like 'Test Item%'];
        Opportunity sourceOpportunity = new Opportunity(Name='System Generated',Recurring_Type__c='Fixed',Number_of_Installments__c=30,Donation_type__c='30N',Payment_Schedule__c=[Select Id From HA_Payment_Schedule__c Where Code__c='30N' limit 1].id,Amount=100,npsp__Primary_Contact__c=contactList[0].Id,StageName='Paid',Type='Payment Plan',CloseDate=System.today());
        insert sourceOpportunity;
        StaticResource sr = [
            SELECT Id, Body
            FROM StaticResource
            WHERE Name = 'TestJSON_3'
            LIMIT 1
        ];
        String jsonBody = sr.Body.toString();
        ContentVersion conVer = new ContentVersion(Donation__c =sourceOpportunity.Id,ContentLocation = 'S',PathOnClient = 'Payment_Schedule_List.txt',Title = 'Payment_Schedule_List',VersionData = Blob.valueOf(jsonBody));
        insert conVer;
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        List<ContentDocumentLink> cdlToInsert = new List<ContentDocumentLink>();
        cdlToInsert.add(New ContentDocumentLink(LinkedEntityId = sourceOpportunity.Id,ContentDocumentId = conDoc,shareType = 'V'));
        insert cdlToInsert;
        npe03__Recurring_Donation__c RecurringDonation=(npe03__Recurring_Donation__c) TestFactory.createSObject(
            new npe03__Recurring_Donation__c(Donation_type__c='30N',Opportunity__c=sourceOpportunity.Id),
            'TestFactoryDefaults.RDDefaults',
            false
        );
        
        RecurringDonation.npe03__Contact__c  = contactList[0].Id;
        Insert RecurringDonation;
        /*RecurringDonation Allocation */
        npsp__Allocation__c itemAllocation1 = (npsp__Allocation__c)TestFactory.createSObject(new npsp__Allocation__c(),'TestFactoryDefaults.ItemAllocationDefaults',false);
        itemAllocation1.npsp__General_Accounting_Unit__c = items[0].Id;
        itemAllocation1.npsp__Recurring_Donation__c = RecurringDonation.Id;
        itemAllocation1.npsp__percent__c=50;
        insert itemAllocation1;
        Set<Id> RdIds = new Set<Id>();
        RdIds.add(RecurringDonation.Id);
        HA_CreateDonations.getDonationsFromNotes(RdIds);
        Test.stopTest();
        
    }
    @IsTest
    static void unit2(){
 
     List<npsp__Trigger_Handler__c> listHandlers = npsp.TDTM_Config_API.getCachedRecords();
 
     npsp__Trigger_Handler__c th = new npsp__Trigger_Handler__c();
     th.Name = 'RecurringDonations_TDTM_Runnable';
     th.npsp__Class__c = 'RecurringDonations_TDTM_Runnable';
     th.npsp__Object__c = 'npe03__Recurring_Donation__c';
     th.npsp__Trigger_Action__c = 'AfterInsert,AfterUpdate,BeforeUpdate';
     th.npsp__Active__c = true;
     th.npsp__Load_Order__c =0;
     th.npsp__Asynchronous__c = false;
     listHandlers.add(th);
 
     Test.startTest();
        List<Contact> contactList = [Select Id,Name From Contact];
        List<npsp__General_Accounting_Unit__c> items = [Select Id,Name  FROM npsp__General_Accounting_Unit__c Where Name like 'Test Item%'];
        Opportunity sourceOpportunity = new Opportunity(Name='System Generated',Recurring_Type__c='Fixed',Number_of_Installments__c=30,Donation_type__c='30N',Payment_Schedule__c=[Select Id From HA_Payment_Schedule__c Where Code__c='30N' limit 1].id,Amount=100,npsp__Primary_Contact__c=contactList[0].Id,StageName='Paid',Type='Payment Plan',CloseDate=System.today());
        insert sourceOpportunity;
        StaticResource sr = [
            SELECT Id, Body
            FROM StaticResource
            WHERE Name = 'TestJSON_3'
            LIMIT 1
        ];
        String jsonBody = sr.Body.toString();
        ContentVersion conVer = new ContentVersion(Donation__c =sourceOpportunity.Id,ContentLocation = 'S',PathOnClient = 'Payment_Schedule_List.txt',Title = 'Payment_Schedule_List',VersionData = Blob.valueOf(jsonBody));
        insert conVer;
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        List<ContentDocumentLink> cdlToInsert = new List<ContentDocumentLink>();
        cdlToInsert.add(New ContentDocumentLink(LinkedEntityId = sourceOpportunity.Id,ContentDocumentId = conDoc,shareType = 'V'));
        insert cdlToInsert;
        npe03__Recurring_Donation__c RecurringDonation=(npe03__Recurring_Donation__c) TestFactory.createSObject(
            new npe03__Recurring_Donation__c(Donation_type__c='30N',Opportunity__c=sourceOpportunity.Id),
            'TestFactoryDefaults.RDDefaults',
            false
        );
        
        RecurringDonation.npe03__Contact__c  = contactList[0].Id;
        Insert RecurringDonation;
        /*RecurringDonation Allocation */
        npsp__Allocation__c itemAllocation1 = (npsp__Allocation__c)TestFactory.createSObject(new npsp__Allocation__c(),'TestFactoryDefaults.ItemAllocationDefaults',false);
        itemAllocation1.npsp__General_Accounting_Unit__c = items[0].Id;
        itemAllocation1.npsp__Recurring_Donation__c = RecurringDonation.Id;
        itemAllocation1.npsp__percent__c=50;
        insert itemAllocation1;
        List<HA_CreateDonations.FlowInputs> request = new List<HA_CreateDonations.FlowInputs>();
        HA_CreateDonations.FlowInputs req= new HA_CreateDonations.FlowInputs();
        req.RdId =RecurringDonation.Id;
        request.add(req);
        HA_CreateDonations.getDonationsFromNotes(request);
        Test.stopTest();
        
    }
}