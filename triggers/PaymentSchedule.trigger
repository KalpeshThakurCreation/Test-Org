trigger PaymentSchedule on Payment_Schedule__c (
    before insert, 
    before update, 
    before delete, 
    after insert, 
    after update, 
    after delete, 
    after undelete) {

    TriggerSettings__c ts = TriggerSettings__c.getOrgDefaults();
    if(ts.Payment_Schedule_Trigger__c)
    {
        if (Trigger.isBefore)
        {
            if(Trigger.isInsert)
            {
                TriggerHandler_PaymentSchedule.OnBeforeInsert(Trigger.new);
            }

            if(Trigger.isUpdate)
            {
                TriggerHandler_PaymentSchedule.OnBeforeUpdate(Trigger.newMap, Trigger.oldMap);
            }

            if(Trigger.isDelete)
            {
            }    
        } 
        else if (Trigger.isAfter)
        {
            if(Trigger.isInsert)
            {
                TriggerHandler_PaymentSchedule.OnAfterInsert(Trigger.newMap);
            }

            if(Trigger.isUpdate)
            {
                TriggerHandler_PaymentSchedule.OnAfterUpdate(Trigger.newMap, Trigger.oldMap);
            }

            if(Trigger.isDelete)
            {
                TriggerHandler_PaymentSchedule.OnAfterDelete(Trigger.oldMap);
            }

            if(Trigger.isUndelete)
            {
            } 
        }
    }
}