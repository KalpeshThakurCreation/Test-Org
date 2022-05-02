public without sharing class TriggerHandler_DirectDebit {
    public static void OnBeforeInsert(List<Income_Direct_Debit__c> newRecords)
    {
    }

    public static void OnAfterInsert(Map<Id, Income_Direct_Debit__c> newRecords)
    {
        Set<Id> oppIds = new Set<Id>();

        for(Income_Direct_Debit__c dd : newRecords.values())
        {
            if(dd.Opportunity__c != null && dd.Recurring_Donation__c == null)
            {
                oppIds.add(dd.Opportunity__c);
            }
        }

        if(oppIds.Size() > 0)
        {
            List<Opportunity> opportunities = [SELECT Id, StageName FROM Opportunity WHERE Id IN :oppIds];

            if(opportunities.Size() > 0)
            {
                for(Opportunity opp : opportunities)
                {
                    opp.StageName = 'Paid';
                }
        
                update opportunities;
            }            
        }        
    }

    public static void OnBeforeUpdate(Map<Id, Income_Direct_Debit__c> newRecords, Map<Id, Income_Direct_Debit__c> oldRecords)
    {
    }
    
    public static void OnAfterUpdate(Map<Id, Income_Direct_Debit__c> newRecords, Map<Id, Income_Direct_Debit__c> oldRecords)
    {
    }
}