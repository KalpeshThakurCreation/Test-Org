@isTest
public class TriggerHandler_PaymentScheduleTest {
    private static Income_Direct_Debit__c directDebit;
    private static List<Payment_Schedule__c> schedules;

    private static void setupTestConfig(){
        TriggerSettings__c triggersettings = new TriggerSettings__c();
        triggersettings.Payment_Schedule_Trigger__c = true;
        insert triggersettings;

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

        directDebit = new Income_Direct_Debit__c(Opportunity__c = opp.Id, Contact__c = member.Id, DD_Status__c = 'First Collection', DD_Bank_Account_Number__c = '00000000', DD_Bank_Sort_Code__c = '000000');
        insert directDebit;

        schedules = new List<Payment_Schedule__c>();
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 5, Schedule_Date__c = Date.Today().AddMonths(1).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 6, Schedule_Date__c = Date.Today().AddMonths(2).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 7, Schedule_Date__c = Date.Today().AddMonths(3).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 8, Schedule_Date__c = Date.Today().AddMonths(4).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 9, Schedule_Date__c = Date.Today().AddMonths(5).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 10, Schedule_Date__c = Date.Today().AddMonths(6).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 11, Schedule_Date__c = Date.Today().AddMonths(7).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 12, Schedule_Date__c = Date.Today().AddMonths(8).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 13, Schedule_Date__c = Date.Today().AddMonths(9).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 14, Schedule_Date__c = Date.Today().AddMonths(10).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 15, Schedule_Date__c = Date.Today().AddMonths(11).toStartOfMonth()));
        schedules.add(new Payment_Schedule__c(Opportunity__c = opp.Id, Status__c = 'Outstanding', Amount__c = 16, Schedule_Date__c = Date.Today().AddMonths(12).toStartOfMonth()));
        insert schedules;
    }

    /* @isTest static void testPaymentScheduleAmountChanged() {
        setupTestConfig();

        directDebit = [SELECT Id, DD_Ongoing_Collection_Amount__c FROM Income_Direct_Debit__c WHERE Id = :directDebit.Id];
        System.assertEquals(5, directDebit.DD_Ongoing_Collection_Amount__c);

        schedules[0].Amount__c = 100;
        update schedules[0];

        directDebit = [SELECT Id, DD_Ongoing_Collection_Amount__c FROM Income_Direct_Debit__c WHERE Id = :directDebit.Id];
        System.assertEquals(100, directDebit.DD_Ongoing_Collection_Amount__c);
    }

    @isTest static void testPaymentScheduleStatusChanged() {
        setupTestConfig();

        directDebit = [SELECT Id, DD_Ongoing_Collection_Amount__c FROM Income_Direct_Debit__c WHERE Id = :directDebit.Id];
        System.assertEquals(5, directDebit.DD_Ongoing_Collection_Amount__c);

        schedules[0].Status__c = 'Paid';
        update schedules[0];

        directDebit = [SELECT Id, DD_Ongoing_Collection_Amount__c FROM Income_Direct_Debit__c WHERE Id = :directDebit.Id];
        System.assertEquals(6, directDebit.DD_Ongoing_Collection_Amount__c);
    }

    @isTest static void testPaymentScheduleDateChanged() {
        setupTestConfig();

        directDebit = [SELECT Id, DD_First_Collection_Date__c FROM Income_Direct_Debit__c WHERE Id = :directDebit.Id];
        System.assertEquals(schedules[0].Schedule_Date__c, directDebit.DD_First_Collection_Date__c);

        schedules[0].Schedule_Date__c = Date.Today().addDays(1);
        update schedules[0];

        directDebit = [SELECT Id, DD_First_Collection_Date__c FROM Income_Direct_Debit__c WHERE Id = :directDebit.Id];
        System.assertEquals(Date.Today().addDays(1), directDebit.DD_First_Collection_Date__c);
    }

    @isTest static void testPaymentScheduleDeleted() {
        setupTestConfig();

        directDebit = [SELECT Id, DD_Ongoing_Collection_Amount__c FROM Income_Direct_Debit__c WHERE Id = :directDebit.Id];
        System.assertEquals(5, directDebit.DD_Ongoing_Collection_Amount__c);

        delete schedules[0];

        directDebit = [SELECT Id, DD_Ongoing_Collection_Amount__c FROM Income_Direct_Debit__c WHERE Id = :directDebit.Id];
        System.assertEquals(6, directDebit.DD_Ongoing_Collection_Amount__c);
    } */
}