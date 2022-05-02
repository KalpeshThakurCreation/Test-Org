@isTest
public with sharing class TriggerHandler_DirectDebitHistoryTest
{
    private static void setupTestConfig(){
        TriggerSettings__c triggersettings = new TriggerSettings__c();
        triggersettings.Direct_Debit_History_Trigger__c = true;
        triggersettings.Payment_Schedule_Trigger__c = false;
        insert triggersettings;
    }

    @isTest static void testPaymentScheduleConnected() {
        setupTestConfig();

        Contact member = new Contact();
        member.FirstName = 'testFirst';
        member.LastName = 'testLast';
        insert member;

        Opportunity opp = new Opportunity();
        opp.Name = 'testOpp';
        opp.Amount = 5;
        opp.StageName = 'test';
        opp.CloseDate = Date.Today();
        insert opp;

        Income_Direct_Debit__c directDebit = new Income_Direct_Debit__c(Opportunity__c = opp.Id, Contact__c = member.Id, DD_Status__c = 'Ongoing Collection', DD_Bank_Account_Number__c = '00000000', DD_Bank_Sort_Code__c = '000000');
        insert directDebit;

        Payment_Schedule__c schedule = new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Schedule_Date__c = Date.Today() + 5);
        insert schedule;

        Income_Debit_History__c directDebitHistory = new Income_Debit_History__c(Income_Direct_Debit__c = directDebit.Id, DD_Status__c = 'Ongoing Collection', DD_Collection_Date__c = Date.Today() + 5);
        insert directDebitHistory;
    }

    @isTest static void testPaymentScheduleSetToFailed() {
        setupTestConfig();

        Contact member = new Contact();
        member.FirstName = 'testFirst';
        member.LastName = 'testLast';
        insert member;

        Opportunity opp = new Opportunity();
        opp.Name = 'testOpp';
        opp.Amount = 5;
        opp.StageName = 'test';
        opp.CloseDate = Date.Today();
        insert opp;

        Income_Direct_Debit__c directDebit = new Income_Direct_Debit__c(Opportunity__c = opp.Id, Contact__c = member.Id, DD_Status__c = 'Ongoing Collection', DD_Bank_Account_Number__c = '00000000', DD_Bank_Sort_Code__c = '000000');
        insert directDebit;

        Payment_Schedule__c schedule = new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Schedule_Date__c = Date.Today() + 5);
        insert schedule;

        Income_Debit_History__c directDebitHistory = new Income_Debit_History__c(Payment_Schedule__c = schedule.Id, 
                                                                                Income_Direct_Debit__c = directDebit.Id, 
                                                                                DD_Status__c = 'Ongoing Collection', 
                                                                                DD_Collection_Date__c = Date.Today() + 5);
        insert directDebitHistory;

        directDebitHistory.DD_Stage__c = 'Failed';
        update directDebitHistory;      

    }

    @isTest static void testPaymentScheduleSetToSuccess() {
        setupTestConfig();

        Contact member = new Contact();
        member.FirstName = 'testFirst';
        member.LastName = 'testLast';        
        insert member;

        Opportunity opp = new Opportunity();
        opp.Name = 'testOpp';
        opp.Amount = 5;
        opp.StageName = 'test';
        opp.CloseDate = Date.Today();
        insert opp;

        Income_Direct_Debit__c directDebit = new Income_Direct_Debit__c(Opportunity__c = opp.Id, Contact__c = member.Id, DD_Status__c = 'Ongoing Collection', DD_Bank_Account_Number__c = '00000000', DD_Bank_Sort_Code__c = '000000');
        insert directDebit;

        Payment_Schedule__c schedule = new Payment_Schedule__c(Opportunity__c = opp.Id,Status__c = 'Outstanding', Schedule_Date__c = Date.Today() + 5);
        insert schedule;

        Income_Debit_History__c directDebitHistory = new Income_Debit_History__c(Payment_Schedule__c = schedule.Id, 
                                                                                Income_Direct_Debit__c = directDebit.Id, 
                                                                                DD_Status__c = 'Ongoing Collection', 
                                                                                DD_Collection_Date__c = Date.Today() + 5);
        insert directDebitHistory;

        directDebitHistory.DD_Stage__c = 'Successful';
        update directDebitHistory;      
    }
}