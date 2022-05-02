/**
 * @File Name          : NewPaymentServiceTest.cls
 * @Description        :
 * @Author             : agentgill
 * @Group              :
 * @Last Modified By   : agentgill
 * @Last Modified On   : 07-10-2020
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    6/22/2020   agentgill     Initial Version
 **/
@isTest
public with sharing class NewPaymentServiceTest {
    public static final Integer RESPONSE_SUCCESS = 202;
    public static final String RESPONSE_BODY = '{ "internalPaymentDescription":"XXX", "apiKey":"testapikey", "incomeUserName":"HUAPB", "paymentGateway":"Stripe" }'; // TODO: Confirm once we hit SP endpoint
    public static final String REQUEST_BODY = '{ "internalPaymentDescription":"XXX" }'; // TODO: Confirm once we hit SP endpoint

    @TestSetup
    static void makeData() {
        /*
        Callable npspApi = (System.Callable)Type.forName('npsp', 'Callable_API').newInstance();
        Boolean isNpspTriggerDisabled = (Boolean)npspApi.call('TDTM.DisableAllTriggers', new Map<String, Object>());*/
        List<npsp__Trigger_Handler__c> handlers = npsp.TDTM_Config_API.getCachedRecords();
        for (npsp__Trigger_Handler__c th : handlers) {
            if (th.npsp__Object__c == 'Opportunity') {
                th.npsp__Active__c = false;
            }
        }
        List<Contact> contacts = (List<Contact>) TestFactory.createSObjectList(
            new Contact(),
            1,
            true
        );

        List<npe03__Recurring_Donation__c> rds = new List<npe03__Recurring_Donation__c>();

        for (Contact c : [
            SELECT Id, AccountId
            FROM Contact
            WHERE Id IN :contacts
        ]) {
            
            Opportunity opp = new Opportunity();
            opp.Name = 'testOpp';
            opp.Amount = 5;
            opp.StageName = 'Awaiting Payment Details';
            opp.CloseDate = Date.Today();
            opp.AccountId = c.AccountId;
            opp.website_code__c='UK';
            opp.Skip_Process_Automation__c =true;  
        	insert opp;

        Income_Card_Payment__c cardPayment = new Income_Card_Payment__c(Opportunity__c = opp.Id, Contact__c = c.Id, Payment_Status__c = 'Created', Transaction_Type__c = 'Sale',Gateway_Customer_Reference__c='cus_IXaICGcDMa0FK9');
        insert cardPayment;

        Income_Card_Payment_History__c cardPaymentHistory = new Income_Card_Payment_History__c(Income_Card_Payment__c = cardPayment.Id, Payment_Status__c = 'Successful', Transaction_Type__c = 'Sale', Transaction_Date__c = Date.Today() + 5);
        insert cardPaymentHistory;
            npe03__Recurring_Donation__c rd = (npe03__Recurring_Donation__c) TestFactory.createSObject(
                new npe03__Recurring_Donation__c(
                    npe03__Contact__c = c.Id,
                    npe03__Amount__c = 100,
                    npsp__StartDate__c = Date.today(),
                    npe03__Date_Established__c = Date.today(),
                    npsp__PaymentMethod__c = 'Card Payment',
                    npsp__Day_of_Month__c = String.valueOf(Date.today().day()),
                    Card_Payment_Detail__c=cardPayment.Id,
                    Opportunity__c = opp.Id
                ),
                'TestFactoryDefaults.RDDefaults'
            );
            rds.add(rd);
        }

        insert rds;
    }

    /**
     * @description Test Request Payment Method
     * @author agentgill | 6/22/2020
     * @return void
     **/
    @isTest
    private static void testRequestPayment() {
        StaticResource jsonResponse = [
            SELECT Id, Body
            FROM StaticResource
            WHERE Name = :'NewPaymentServiceTest'
            LIMIT 1
        ];
        // Inject Callout Mock
        HTTPCalloutServiceMock serviceMock = new HTTPCalloutServiceMock(
            RESPONSE_SUCCESS,
            jsonResponse.Body.toString()
        );
        Test.setMock(HTTPCalloutMock.class, serviceMock);

        List<Opportunity> testOpps = [SELECT Id, Name FROM Opportunity];
        System.debug('>>> testOpps ' + testOpps);

        Opportunity oppTest = [
            SELECT
                npe03__Recurring_Donation__r.Opportunity__c,npe03__Recurring_Donation__r.Regional_Code__c,
                Id, Amount, CurrencyIsoCode,
               npe03__Recurring_Donation__r.Card_Payment_Detail__c,npe03__Recurring_Donation__r.Card_Payment_Detail__r.Gateway_Customer_Reference__c
            FROM Opportunity
            WHERE
                npe03__Recurring_Donation__r.npsp__PaymentMethod__c = 'Card Payment'
                AND CloseDate = TODAY
                AND npe03__Recurring_Donation__r.npsp__Status__c = 'Active'
                AND StageName = 'Pledged'
            ORDER BY Id
        ];

        System.debug('>>> oppTest ' + oppTest);

        Sobject sObj = (Sobject) oppTest;

        Test.startTest();
        NewPaymentService paymentService = new NewPaymentService();
        paymentService.requestPayment(sObj, 'TESTGUID');

        Test.stopTest();
        // TODO: Add Valid Test
        System.assertEquals(
           2,
            [SELECT COUNT() FROM Opportunity],
            'Something went wrong'
        );
    }

    /**
     * @description Test Callout
     * @author agentgill | 6/22/2020
     * @return void
     **/
    @isTest
    private static void testCallout() {
        HTTPCalloutServiceMock serviceMock = new HTTPCalloutServiceMock(
            RESPONSE_SUCCESS,
            RESPONSE_BODY
        );
        Test.setMock(HTTPCalloutMock.class, serviceMock);
        Test.startTest();
        HTTPResponse resCallout = NewPaymentService.makeCallout();
        System.assertEquals(
            RESPONSE_SUCCESS,
            resCallout.getStatusCode(),
            'Response code should be ' + RESPONSE_SUCCESS
        );
        System.assertEquals(
            RESPONSE_BODY,
            resCallout.getBody(),
            'Response body should be:- ' + RESPONSE_BODY
        );
        Test.stopTest();
    }
}