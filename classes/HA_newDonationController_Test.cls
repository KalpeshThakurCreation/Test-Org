/**
 * @description       : 
 * @author            : Iamsfdeveloper
 * @group             : 
 * @last modified on  : 02-08-2021
 * @last modified by  : Iamsfdeveloper
 * Modifications Log 
 * Ver   Date         Author           Modification
 * 1.0   12-16-2020   Iamsfdeveloper   Initial Version
**/
@isTest
public without sharing class HA_newDonationController_Test {
    @TestSetup
    static void createData(){
        insert new Ramadan_Configuration__c(Name=String.valueOf(System.today().year()),start_Date_1__c=System.today(),start_Date_2__c=System.today()+5);
        List<HA_Payment_Schedule__c> paymentScheduleList = (List<HA_Payment_Schedule__c>)TestFactory.createSObjectList(new HA_Payment_Schedule__c(),2,'TestFactoryDefaults.PaymentSchedulesDefaults');
        insert paymentScheduleList;
        System.debug(JSON.serialize(paymentScheduleList[0]));
        List<npsp__General_Accounting_Unit__c> items = (List<npsp__General_Accounting_Unit__c>)TestFactory.createSObjectList(new npsp__General_Accounting_Unit__c(),1,'TestFactoryDefaults.GeneralAccountUnitsDefaults');
        insert items;
        Payment_Schedule_Allocation__c PSA1 = new Payment_Schedule_Allocation__c(General_Accounting_Unit__c= items[0].Id,Payment_Schedule__c = paymentScheduleList[0].Id);
        insert PSA1;
        Payment_Schedule_Allocation__c  PSA2 = new Payment_Schedule_Allocation__c(General_Accounting_Unit__c= items[0].Id,Payment_Schedule__c = paymentScheduleList[1].Id);
        insert PSA2;
        List<Contact> contactList = (List<Contact>) TestFactory.createSObjectList(
            new Contact(Email='test@humanappeal.org.uk',RecordTypeId = (String)Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Donor').getRecordTypeId()),
            1,
            true
        );
        contactlist[0].Gift_Aid_Status__c='Yes';
        update contactlist;
        insert new Gift_Aid_Declaration__c(Donor__c=contactlist[0].Id,Gift_Aid_Status__c ='Yes',Gift_Aid_Start_Date__c=System.today());
        List<Contact> orphanContact = (List<Contact>) TestFactory.createSObjectList(
            new Contact(),
            2,
            false
        );
        for(Integer i=0;i<orphanContact.size();i++){
            orphanContact[i].RecordTypeId = (String)Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Orphan').getRecordTypeId();
            orphanContact[i].LastName +=' Orphan';
            orphanContact[i].Country__c='General';
            orphanContact[i].Is_Active__c= true;

        }
        insert orphanContact;
        List<Opportunity> opplist=(List<Opportunity>) TestFactory.createSObjectList(
            new Opportunity(),
           2,
            true
        );
    } 
    testmethod static void unitTest_Positive(){
        system.assertEquals(2, [SELECT count() FROM HA_Payment_Schedule__c], 'Something went wrong');
        Test.startTest();
        HA_newDonationController.doInit();
        TestFactoryDefaults.PaymentSchedulesDefaults obj = new TestFactoryDefaults.PaymentSchedulesDefaults();
        System.debug(obj.getFieldDefaults().get(HA_Payment_Schedule__c.Name));
        System.debug('Test Schedule '+[SELECT Id FROM HA_Payment_Schedule__c  WHERE Name like 'Test Schedule%' limit 1]);
        Map<String,Object> Items_Map = HA_newDonationController.getItems('',UserInfo.getDefaultCurrency(),[SELECT Id FROM HA_Payment_Schedule__c  WHERE Name Like 'Test Schedule%' limit 1].id,'');
        Items_Map = HA_newDonationController.getItems('Donation_Item_Code__c like \'%Test1234%\'',UserInfo.getDefaultCurrency(),[SELECT Id FROM HA_Payment_Schedule__c  WHERE Name Like 'Test Schedule%' limit 1].id,'');
        HA_Logger.CreateErrorLog('Test','Contact','Testing');
        List<npsp__General_Accounting_Unit__c> Items = (List<npsp__General_Accounting_Unit__c>)Items_Map.get('items');
        system.assertEquals(1, Items.size(), 'Something went wrong');
        Test.stopTest();
    }
    @IsTest
    static void unitTest_Dialer_positive(){
        List<npsp__Trigger_Handler__c> listHandlers = npsp.TDTM_Config_API.getCachedRecords();
        npsp__Trigger_Handler__c th = new npsp__Trigger_Handler__c();
        th.Name = 'CampaignTriggerHandler_TDTM_Mutable';
        th.npsp__Class__c = 'CampaignTriggerHandler_TDTM_Mutable';
        th.npsp__Object__c = 'CampaignMember';
        th.npsp__Trigger_Action__c = 'AfterInsert';
        th.npsp__Active__c = true;
        th.npsp__Load_Order__c = 1;
        th.npsp__Asynchronous__c = false;
        listHandlers.add(th);
        Campaign OutboundCallingCampaign = new Campaign(Name='Test',Type='Outbound_Calling',Country__c='United Kingdom',Dialer_Queue__c='Dialer_Queue_UK_1');
        insert OutboundCallingCampaign;
        insert new Campaign_Product_Allocation__c(Campaign__c=OutboundCallingCampaign.Id, Item_Price__c=10.00, Item__c=[Select Id From npsp__General_Accounting_Unit__c Where Donation_Item_Code__c like '%Test1234%' limit 1].Id);
        List<Contact> contactList = [Select Id From Contact Where lastName like 'Last%' ];
        CampaignMember newMember = 
        new CampaignMember(ContactId = contactList[0].id, status='To Call', campaignid = OutboundCallingCampaign.id);
        insert newMember;
        List<Call_List__c> currentCallList = [SELECT Id,OwnerId FROM Call_List__c WHERE CampaignId__c =: OutboundCallingCampaign.Id];
        currentCallList[0].OwnerId = UserInfo.getUserId();
        ID dailerChannelId= [SELECT Id FROM ServiceChannel Where DeveloperName='Dialer_Channel' Limit 1].Id;
       
        Opportunity OPP = (Opportunity)TestFactory.createSObject(new Opportunity());
        OPP.npsp__Primary_Contact__c = contactList[0].id;

        Test.startTest();
        HA_ManageGroupMember.doInit(OutboundCallingCampaign.Id);
        HA_ManageGroupMember.saveGroupMember('[]', '[]');
        Task obj = new Task(Subject='Test',whoId = contactList[0].id,whatId = OPP.Id);
          Map<String,Object> Items_Map = HA_newDonationController.getItems('',UserInfo.getDefaultCurrency(),[SELECT Id FROM HA_Payment_Schedule__c  WHERE Name Like 'Test Schedule%' limit 1].id,OutboundCallingCampaign.Id);
	 	List<npsp__General_Accounting_Unit__c> Items =(List<npsp__General_Accounting_Unit__c>)Items_Map.get('items');
        Object[] allocationList =  new List<Object>();
        for(Integer i=0;i<2;i++){
            allocationList.add(new Map<String,String>{'npsp__General_Accounting_Unit__c'=>Items[0].Id,'npsp__Amount__c'=>'3','Stipulation_Type__c'=>'SD'});
        }
        HA_newDonationController.createTask(JSON.serialize(obj), currentCallList[0].Id);
        HA_newDonationController.createTaskAndUpdateRecord(JSON.serialize(obj),currentCallList[0].Id,JSON.serialize(contactList[0]));
        //String selectedCountry,String recordId,String selectedAge,String selectedGender,String searchParam,string[] selectedRowIds
        HA_newDonationController.getOrphanList('General',contactList[0].id,'','','',new List<String>());
        HA_newDonationController.getOrphanByNameOrId('Test','General');
        HA_newDonationController.getOrphanList('Yemen','','','','',new List<String>());
        HA_newDonationController.saveAllocation(JSON.serialize(OPP),JSON.serialize(allocationList),'['+JSON.serialize(new Map<String,String>{'Subject'=>'Test','whoId'=>contactList[0].id})+']','');
     	HA_newDonationController.getCountryList();
        Test.stopTest();
        
    }
     @IsTest
    static void unitTest_Dialer_30_10Nights(){
        StaticResource sr = [
            SELECT Id, Body
            FROM StaticResource
            WHERE Name = 'TestJSON_4'
            LIMIT 1
        ];
        String jsonBody = sr.Body.toString();
        List<Contact> contactList = [Select Id From Contact Where Email='test@humanappeal.org.uk' ];
        Opportunity OPP = (Opportunity)TestFactory.createSObject(new Opportunity(Donation_type__c='30N',Amount=6));
        OPP.npsp__Primary_Contact__c = contactList[0].id;

        Test.startTest();
        
        Task obj = new Task(Subject='Test',whoId = contactList[0].id,whatId = OPP.Id);
          List<npsp__General_Accounting_Unit__c> Items =[Select Id From npsp__General_Accounting_Unit__c];
        Object[] allocationList =  new List<Object>();
        for(Integer i=0;i<2;i++){
            allocationList.add(new Map<String,String>{'npsp__General_Accounting_Unit__c'=>Items[0].Id,'npsp__Amount__c'=>'3','Stipulation_Type__c'=>'SD'});
        }
        HA_newDonationController.saveAllocation(JSON.serialize(OPP),JSON.serialize(allocationList),'['+JSON.serialize(new Map<String,String>{'Subject'=>'Test','whoId'=>contactList[0].id})+']',jsonBody);
     
        Test.stopTest();
        
    }
}