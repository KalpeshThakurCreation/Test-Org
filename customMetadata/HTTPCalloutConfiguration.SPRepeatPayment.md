<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>SPRepeatPayment</label>
    <protected>false</protected>
    <values>
        <field>Body__c</field>
        <value xsi:type="xsd:string">{
&quot;paymentGateway&quot;:&quot;Stripe&quot;,
&quot;apiKey&quot;:&quot;testapikey&quot;,
&quot;incomeUserName&quot;:&quot;HUAPP&quot;
}</value>
    </values>
    <values>
        <field>CertificateName__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>Endpoint__c</field>
        <value xsi:type="xsd:string">https://test2.smarterpay.com/paymentgatewayapi/repeat</value>
    </values>
    <values>
        <field>HeaderParameters__c</field>
        <value xsi:type="xsd:string">Content-Type:application/json</value>
    </values>
    <values>
        <field>IsCompressed__c</field>
        <value xsi:type="xsd:boolean">false</value>
    </values>
    <values>
        <field>Method__c</field>
        <value xsi:type="xsd:string">POST</value>
    </values>
    <values>
        <field>Timeout__c</field>
        <value xsi:type="xsd:double">120000.0</value>
    </values>
    <values>
        <field>URLParameters__c</field>
        <value xsi:nil="true"/>
    </values>
</CustomMetadata>
