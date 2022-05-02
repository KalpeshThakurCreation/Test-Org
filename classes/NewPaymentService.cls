/**
 * @File Name          : NewPaymentService.cls
 * @Description        :
 * @Author             : agentgill
 * @Group              :
 * @Last Modified By   : Iamsfdeveloper
 * @Last Modified On   : 04-05-2021
 * @Modification Log   :
 * Ver       Date            Author                 Modification
 * 1.0    12/06/2020   agentgill     Initial Version
 * 
    cus_HWf3JbnOa8rmEA -> This should give you a failed payment with insufficient funds.
    cus_HWf27lulp9z62i -> This should give you a successful payment everytime.
    
    **Execute Anonymous Apex with Currently Selected Text**
    
    // Start
    NewRecurringDonationService myBatch = new NewRecurringDonationService();
    Database.executeBatch(myBatch, 100);
    // End
    
 **/
public with sharing class NewPaymentService {
    private static final String SERVICE_NAME = 'SPRepeatPayment';
    private static PaymentIntent pi;
    /**
     * @description Request Payment
     * @author agentgill | 6/22/2020
     * @param s
     * @param guid
     * @return Boolean
     **/
    public Boolean requestPayment(Sobject s, String guid) {
		Opportunity opp = (Opportunity)s;
        string serviceName = (opp.npe03__Recurring_Donation__r.Regional_Code__c != null)?opp.npe03__Recurring_Donation__r.Regional_Code__c:SERVICE_NAME;
        Map<String, String> paymentConfig = loadConfig(serviceName);
        pi = new PaymentIntent();
        pi.APIKey = paymentConfig.get('apiKey');
        pi.incomeUserName = paymentConfig.get('incomeUserName');
        pi.paymentGateway = paymentConfig.get('paymentGateway');
        pi.isAsync = true; // Calling service is hardcoded to async
        pi.internalPaymentDescription = guid;
        pi.amount = (Decimal) opp.Amount;
        pi.currencyCode = opp.CurrencyIsoCode;
        pi.incomeCardPaymentId = opp.npe03__Recurring_Donation__r.Card_Payment_Detail__c;

        // Seed
        pi.customerId = (paymentConfig.get('customerId') == null
            ? (String) opp.npe03__Recurring_Donation__r.Card_Payment_Detail__r.Gateway_Customer_Reference__c
            : paymentConfig.get('customerId'));

        System.debug('@@@ Payment Service - Customer Id ' + pi.customerId);
        HTTPResponse res = makeCallout();
        // 202 Accepted on the other hand means that the request have been accepted for processing, and the service will now start
        if (res.getStatusCode() == 202) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * @description Load Default Payload Params from CMT HTTP Body
     * @author agentgill | 28/06/2020
     * @return Map<String, String>
     **/
    private static Map<String, String> loadConfig(String ServiceName) {
        HTTPCalloutService paymentConfig = new HTTPCalloutService(
            String.valueOf(ServiceName)
        );
        Map<String, String> jsonMap = (Map<String, String>) JSON.deserialize(
            (String) paymentConfig.getRequestBody(),
            Map<String, String>.class
        );
        return jsonMap;
    }

    /**
     * @description Handle Callout to Payment Service
     * @author agentgill | 28/06/2020
     * @return HTTPResponse
     **/
    public static HTTPResponse makeCallout() {
        HTTPCalloutService service = new HTTPCalloutService(SERVICE_NAME);
        service.setRequestBody(JSON.serialize(pi));
        System.debug('@@@ NewPaymentService JSON ' + JSON.serialize(pi));
        System.debug('@@@ NewPaymentService service ' + service);
        HTTPResponse res = service.sendRequest();
        System.debug('@@@ NewPaymentService res ' + res);
        return res;
    }

    /**
     * @description Payload Data Type
     */
    private class PaymentIntent {
        private Boolean isAsync { get; set; }
        private String APIKey { get; set; }
        private String paymentGateway { get; set; }
        private String incomeUserName { get; set; }
        private String incomeCardPaymentId { get; set; }
        private Decimal amount { get; set; }
        private String currencyCode { get; set; }
        private String customerId { get; set; } // Stripe
        private String internalPaymentDescription { get; set; }
    }
}