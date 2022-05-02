public without sharing class TriggerHandler_CardPayment {
    public static void OnBeforeInsert(List<Income_Card_Payment__c> newRecords)
    {
    }

    public static void OnAfterInsert(Map<Id, Income_Card_Payment__c> newRecords)
    {        
    }

    public static void OnBeforeUpdate(Map<Id, Income_Card_Payment__c> newRecords, Map<Id, Income_Card_Payment__c> oldRecords)
    {
            
    }
    
    public static void OnAfterUpdate(Map<Id, Income_Card_Payment__c> newRecords, Map<Id, Income_Card_Payment__c> oldRecords)
    {        
        List<npe03__Recurring_Donation__c> recurringDonations = new List<npe03__Recurring_Donation__c>();

        List<Income_Card_Payment__c> clonedCardPayment = new List<Income_Card_Payment__c>();
        List<Income_Card_Payment_History__c> clonedHistories = new List<Income_Card_Payment_History__c>();
        Set<String> oppIds = new Set<String>();

        for(Income_Card_Payment__c card : newRecords.values())
        {
            if(card.Payment_Status__c == 'Successful' && oldRecords.get(card.Id).Payment_Status__c != 'Successful' 
                && (card.Transaction_Type__c == 'Sale' || card.Transaction_Type__c == 'Authenticate'))
            {                             
                if(card.Recurring_Donation__c != null)
                {
                    recurringDonations.add(new npe03__Recurring_Donation__c(Id = card.Recurring_Donation__c, Card_Payment_Detail__c = card.Id));
                }
                else 
                {
                    if(card.Opportunity__c != null)
                    {
                        oppIds.add(card.Opportunity__c);
                    } 

                    System.debug('#### card.Internal_Payment_Description__c: ' + card.Internal_Payment_Description__c);

                    if(String.isNotBlank(card.Internal_Payment_Description__c))
                    {
                        List<String> additionalOpportunityIds = card.Internal_Payment_Description__c.split(',');

                        for(String s : additionalOpportunityIds)
                        {
                            if (s instanceOf Id)
                            {
                                oppIds.add(s);
                                Income_Card_Payment__c clone = card.clone();
                                clone.Opportunity__c = s;
                                clone.Source_Card_Payment__c = card.Id;
                                clonedCardPayment.add(clone);
                            }
                        }
                    }
                }
                
            }
        }

        if(recurringDonations.size() > 0)
        {
            update recurringDonations;
        }

        if(oppIds.Size() > 0)
        {
            Map<Id, Opportunity> opportunities = new Map<Id, Opportunity>([SELECT Id, Amount, StageName, Payment_Schedule__r.Frequency__c FROM Opportunity WHERE Id IN :oppIds]);

            if(clonedCardPayment.Size() > 0)
            {
                insert clonedCardPayment;

                for(Income_Card_Payment__c payment : clonedCardPayment)
                {
                    Opportunity opp = opportunities.get(payment.Opportunity__c);
                    
                    System.debug('#### payment: ' + payment);
                    System.debug('#### opp: ' + opp);

                    Income_Card_Payment_History__c clone = new Income_Card_Payment_History__c();
                    clone.CurrencyIsoCode = payment.CurrencyIsoCode;
                    clone.Income_Card_Payment__c = payment.Id;
                    clone.Payment_Status__c = 'Successful';                
                    clone.Transaction_Date__c = DateTime.now();

                    if(opp.Payment_Schedule__r.Frequency__c == 'Single')
                    {
                        clone.Transaction_Type__c = 'Sale';
                        clone.Amount__c = opp.Amount;
                    }
                    else
                    {
                        // Must be a recurring payment schedule
                        clone.Transaction_Type__c = 'Authenticate';
                        clone.Amount__c = 0.00;
                    }

                    clonedHistories.add(clone);
                }

                System.debug('#### clonedHistories: ' + clonedHistories);

                if(clonedHistories.Size() > 0)
                {
                    insert clonedHistories;
                }
            }
        
            for(Opportunity opp : opportunities.values())
            {
                opp.StageName = 'Paid';
            }

            update opportunities.values();
        }        
    }
}