/**
 * @File Name          : TestFactoryDefaults.cls
 * @Description        :
 * @Author             : agentgill
 * @Group              :
 * @Last Modified By   : Iamsfdeveloper
 * @Last Modified On   : 02-08-2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    01/06/2020   agentgill     Initial Version
 **/
@IsTest
public class TestFactoryDefaults {
    // To specify defaults for objects, use the naming convention [ObjectName]Defaults.
    // For custom objects, omit the __c from the Object Name

    public class RDDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object>{
                npe03__Recurring_Donation__c.Name => 'Test',
                     npe03__Recurring_Donation__c.npsp__InstallmentFrequency__c =>1,
                    npe03__Recurring_Donation__c.npe03__Amount__c =>100
            };
        }
    }

    public class AccountDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object>{
                Account.Name => 'Test Account'
            };
        }
    }

    public class MyAccountDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object>{
                Account.Name => 'My Test Account'
            };
        }
    }

    public class ContactDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object>{
                Contact.FirstName => 'First',
                Contact.LastName => 'Last',
                Contact.MailingStreet=>'Test',
                Contact.MailingCity=>'Test',
                Contact.MailingPostalCode=>'SK8 2BL',
                Contact.MailingCountry=>'Test',
                Contact.MailingCountry=>'test@humanappeal.org.uk.test'
            };
        }
    }

    public class OpportunityDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object>{
                Opportunity.Name => 'Test Opportunity',
                Opportunity.StageName => 'pledged',
                Opportunity.CloseDate => System.today()
            };
        }
    }

    public class CaseDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object>{
                Case.Subject => 'Test Case'
            };
        }
    }
    public class PaymentSchedulesDefaults implements TestFactory.FieldDefaults{
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object>{
                HA_Payment_Schedule__c.Name => 'Test Schedule'
            };
        }
    }

    public class GeneralAccountUnitsDefaults implements TestFactory.FieldDefaults{
       public Map<Schema.SObjectField, Object>getFieldDefaults(){
           return new Map<Schema.SObjectField,Object>{
            npsp__General_Accounting_Unit__c.Name => 'Test Item',
            npsp__General_Accounting_Unit__c.npsp__Active__c => true,
            npsp__General_Accounting_Unit__c.Donation_Item_Code__c =>'Test1234',
            npsp__General_Accounting_Unit__c.Country__c=>'General',
            npsp__General_Accounting_Unit__c.Gift_Aid_Eligible__c=>true,
            npsp__General_Accounting_Unit__c.Product_Type__c=>'Fund',
            npsp__General_Accounting_Unit__c.Stipulation__c=>'SD'
           };
       }
    }
    public class ItemAllocationDefaults implements TestFactory.FieldDefaults {
        public Map<Schema.SObjectField, Object> getFieldDefaults() {
            return new Map<Schema.SObjectField, Object>{
                npsp__Allocation__c.npsp__Amount__c=>3,
                npsp__Allocation__c.Quantity__c=>1,
                npsp__Allocation__c.Stipulation_Type__c=>'SD'
            };
        }
    }

}