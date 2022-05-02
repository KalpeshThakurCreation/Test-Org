public without sharing class TriggerHandler_PaymentSchedule {

    public static void OnBeforeInsert(List<Payment_Schedule__c> newRecords)
    {        
    }

    public static void OnAfterInsert(Map<Id, Payment_Schedule__c> newRecords)
    {
        /* Set<Id> contactsToCheck = new Set<Id>();

        for(Payment_Schedule__c ps : newRecords.values())
        {
            contactsToCheck.add(ps.Opportunity__c);
        }
        
        SMP_PaymentScheduleHelper.checkRecurringPayment(contactsToCheck); */
    }

    public static void OnBeforeUpdate(Map<Id, Payment_Schedule__c> newRecords, Map<Id, Payment_Schedule__c> oldRecords)
    {
        System.debug('#### newRecords: ' + newRecords);
        System.debug('#### oldRecords: ' + oldRecords);
    }
    
    public static void OnAfterUpdate(Map<Id, Payment_Schedule__c> newRecords, Map<Id, Payment_Schedule__c> oldRecords)
    {
        System.debug('TriggerHandler_PaymentSchedule OnAfterUpdate');
        System.debug('#### newRecords: ' + newRecords);
        System.debug('#### oldRecords: ' + oldRecords);

        /* Set<Id> opportunitiesToRecalculate = new Set<Id>();
        Set<Id> recurringPaymentsToRecalculate = new Set<Id>();

        for(Payment_Schedule__c ps : newRecords.values())
        {            
            if(ps.Status__c != oldRecords.get(ps.Id).Status__c)
            {
                opportunitiesToRecalculate.add(ps.Opportunity__c);
                recurringPaymentsToRecalculate.add(ps.Opportunity__c);
            }

            if(ps.Amount__c != oldRecords.get(ps.Id).Amount__c
            || ps.Schedule_Date__c != oldRecords.get(ps.Id).Schedule_Date__c)
            {
                recurringPaymentsToRecalculate.add(ps.Opportunity__c);
            }
        }
        
        if(opportunitiesToRecalculate.Size() > 0)
        {
            SMP_PaymentScheduleHelper.calculatePaymentSchedulesFuture(opportunitiesToRecalculate);
        }        
        
        if(recurringPaymentsToRecalculate.Size () > 0)
        {
            SMP_PaymentScheduleHelper.checkRecurringPayment(recurringPaymentsToRecalculate);
        }         */
    }

    public static void OnAfterDelete(Map<Id, Payment_Schedule__c> oldRecords)
    {
        System.debug('TriggerHandler_PaymentSchedule OnAfterDelete');
        System.debug('#### oldRecords: ' + oldRecords);

        /* Set<Id> recurringPaymentsToRecalculate = new Set<Id>();

        for(Payment_Schedule__c ps : oldRecords.values())
        {       
            recurringPaymentsToRecalculate.add(ps.Opportunity__c);
        }    
        
        SMP_PaymentScheduleHelper.checkRecurringPayment(recurringPaymentsToRecalculate); */       
    }
}