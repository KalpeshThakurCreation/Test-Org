<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ES_New_Supporter_Alert</fullName>
        <description>ES New Supporter Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>info@humanappeal.es</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Spain_Templates/New_Supporter_Spain</template>
    </alerts>
    <alerts>
        <fullName>FR_New_Supporter_Alert</fullName>
        <description>FR New Supporter Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>contact@humanappeal.fr</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>France_Templates/New_Supporter_France</template>
    </alerts>
    <alerts>
        <fullName>GDPR_Consent_Notification</fullName>
        <description>GDPR Consent Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>npe01__WorkEmail__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customercare@humanappeal.org.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Donor_Care_UK/Donor_Consent_Notification</template>
    </alerts>
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Signup_Notification_Email_Alert_Contact</fullName>
        <description>Volunteer Signup Notification Email Alert - Contact</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Signup_Notification</template>
    </alerts>
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Signup_Thank_You_Email_Alert_Contact</fullName>
        <description>Volunteer Signup Thank You Email Alert - Contact</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Signup_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>IE_New_Supporter_Alert</fullName>
        <description>IE New Supporter Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>info@humanappeal.ie</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Ireland_Templates/New_Supporter_Ireland</template>
    </alerts>
    <alerts>
        <fullName>New_Supporter_Alert</fullName>
        <description>New Supporter Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>customercare@humanappeal.org.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Donor_Care_UK/New_Supporter_v2</template>
    </alerts>
    <fieldUpdates>
        <fullName>AR_Set_Region_Code</fullName>
        <field>Regional_Office_Site_Code__c</field>
        <literalValue>AR</literalValue>
        <name>AR - Set Region Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blank_out_personal_email</fullName>
        <field>npe01__HomeEmail__c</field>
        <name>Blank out personal email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blank_out_work_email</fullName>
        <field>npe01__WorkEmail__c</field>
        <name>Blank out work email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Orphan_Owner</fullName>
        <field>OwnerId</field>
        <lookupValue>sadak.mirza@humanappeal.org.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Change Orphan Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Personal_to_email</fullName>
        <field>Email</field>
        <formula>npe01__HomeEmail__c</formula>
        <name>Copy Personal to email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Work_Email_to_Default_Email</fullName>
        <field>Email</field>
        <formula>npe01__WorkEmail__c</formula>
        <name>Copy Work Email to Default Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_Set_Region_Code</fullName>
        <field>Regional_Office_Site_Code__c</field>
        <literalValue>ES</literalValue>
        <name>ES - Set Region Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FR_Set_Region_Code</fullName>
        <field>Regional_Office_Site_Code__c</field>
        <literalValue>FR</literalValue>
        <name>FR - Set Region Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IE_Set_Region_Code</fullName>
        <field>Regional_Office_Site_Code__c</field>
        <literalValue>IE</literalValue>
        <name>IE - Set Region Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_CAVE_No</fullName>
        <field>Can_Appeal_Via_Email__c</field>
        <literalValue>No</literalValue>
        <name>Set CAVE = No</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_CAVE_Yes</fullName>
        <field>Can_Appeal_Via_Email__c</field>
        <literalValue>Yes</literalValue>
        <name>Set CAVE = Yes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Email_Opt_In_Date_to_today</fullName>
        <field>Email_Opt_In_Date__c</field>
        <formula>Today ()</formula>
        <name>Set Email Opt In Date to today()</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Email_Opt_In_to_false</fullName>
        <field>Email_Single_Opt_In__c</field>
        <literalValue>0</literalValue>
        <name>Set Email Opt In to false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Email_Opt_In_to_true</fullName>
        <field>Email_Single_Opt_In__c</field>
        <literalValue>1</literalValue>
        <name>Set Email Opt In to true</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Email_Opt_Out_Date_to_null</fullName>
        <field>Email_Opt_Out_Date__c</field>
        <name>Set Email Opt Out Date to null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Email_Opt_Out_Date_to_today</fullName>
        <field>Email_Opt_Out_Date__c</field>
        <formula>Today()</formula>
        <name>Set Email Opt Out Date to today()</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Email_Opt_Out_to_false</fullName>
        <field>HasOptedOutOfEmail</field>
        <literalValue>0</literalValue>
        <name>Set Email Opt Out to false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Email_Opt_Out_to_true</fullName>
        <field>HasOptedOutOfEmail</field>
        <literalValue>1</literalValue>
        <name>Set Email Opt Out to true</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Email_Unique</fullName>
        <description>Set Email Unique Field - External Id and forces uniqueness in contacts</description>
        <field>Email__c</field>
        <formula>Email</formula>
        <name>Set Email Unique</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Feedback_Reports_via_Email_to_Yes</fullName>
        <field>Feedback_Notifications_Via_Email__c</field>
        <literalValue>Yes</literalValue>
        <name>Set Feedback Reports via Email to Yes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_File_Destroy_Date_Field</fullName>
        <description>Set the File Destroy date field</description>
        <field>File_destroy_date__c</field>
        <formula>DATE(
YEAR(TODAY()) + IF(MONTH(TODAY()) &gt; 6, 1, 0),
MOD(MONTH(TODAY()) + 6, 12),
DAY(TODAY())
)</formula>
        <name>Set File Destroy Date Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Gift_Aid_Declaration_Start_Date</fullName>
        <description>Set Gift Aid Declaration Start Date</description>
        <field>Gift_Aid_Declaration_Start_Date__c</field>
        <formula>TODAY()</formula>
        <name>Set Gift Aid Declaration Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Gift_Aid_Effective_Date</fullName>
        <description>Set Gift Aid Effective Date</description>
        <field>Gift_Aid_Effective_Date__c</field>
        <formula>TODAY()</formula>
        <name>Set Gift Aid Effective Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Is_AR_Donor_To_True</fullName>
        <field>Is_AR_Donor__c</field>
        <literalValue>1</literalValue>
        <name>Set Is AR Donor To True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Is_ES_Donor_To_True</fullName>
        <field>Is_ES_Donor__c</field>
        <literalValue>1</literalValue>
        <name>Set Is ES Donor To True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Is_FR_Donor_To_True</fullName>
        <field>Is_FR_Donor__c</field>
        <literalValue>1</literalValue>
        <name>Set Is FR Donor To True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Is_IE_Donor_To_True</fullName>
        <field>Is_IE_Donor__c</field>
        <literalValue>1</literalValue>
        <name>Set Is IE Donor To True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Is_UK_Donor_To_True</fullName>
        <field>Is_UK_Donor__c</field>
        <literalValue>1</literalValue>
        <name>Set Is UK Donor To True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Regional_Office_Code</fullName>
        <field>Regional_Office_Site_Code__c</field>
        <literalValue>UK</literalValue>
        <name>Set Regional Office Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Resubscribed_to_No</fullName>
        <field>Resubscribed__c</field>
        <literalValue>0</literalValue>
        <name>Set Resubscribed to No</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Resubscribed_to_Yes</fullName>
        <field>Resubscribed__c</field>
        <literalValue>1</literalValue>
        <name>Set Resubscribed to Yes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SMS_Opt_In_Date_to_today</fullName>
        <field>SMS_Opt_In_Date__c</field>
        <formula>Today ()</formula>
        <name>Set SMS Opt In Date to today()</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SMS_Opt_In_to_false</fullName>
        <field>SMS_Single_Opt_In__c</field>
        <literalValue>0</literalValue>
        <name>Set SMS Opt In to false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SMS_Opt_In_to_true</fullName>
        <field>SMS_Single_Opt_In__c</field>
        <literalValue>1</literalValue>
        <name>Set SMS Opt In to true</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SMS_Opt_Out_Date_to_today</fullName>
        <field>SMS_Opt_Out_Date__c</field>
        <formula>Today()</formula>
        <name>Set SMS Opt Out Date to today()</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SMS_Opt_Out_date_to_null</fullName>
        <field>SMS_Opt_Out_Date__c</field>
        <name>Set SMS Opt Out date to null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SMS_Opt_Out_to_false</fullName>
        <field>Has_Opted_Out_Of_SMS__c</field>
        <literalValue>0</literalValue>
        <name>Set SMS Opt Out to false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SMS_Opt_Out_to_true</fullName>
        <field>Has_Opted_Out_Of_SMS__c</field>
        <literalValue>1</literalValue>
        <name>Set SMS Opt Out to true</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SMS_PD_to_DMS</fullName>
        <field>SMS_Preference_declared__c</field>
        <literalValue>DMS Data</literalValue>
        <name>Set SMS PD to DMS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Thomson_Status_update</fullName>
        <description>When Next Thomson reuter check date is less then 30 days then update the field to &apos;Renew Required&apos;</description>
        <field>Thomson_Status__c</field>
        <formula>&quot;Renew Required&quot;</formula>
        <name>Thomson Status update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Thomson_Status_update_to_empty</fullName>
        <description>Thomson Status update to empty</description>
        <field>Thomson_Status__c</field>
        <name>Thomson Status update to empty</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Unique_Donor_Identifier</fullName>
        <description>IF(IsBlank(Email),FirstName&amp;&apos;-&apos;&amp;LastName&amp;&apos;-&apos;&amp; Text(Regional_Office_Code__c),FirstName&amp;&apos;-&apos;&amp;LastName&amp;&apos;-&apos;&amp; Email &amp;&apos;-&apos;&amp; Text(Regional_Office_Code__c))</description>
        <field>Unique_Donor_Id__c</field>
        <formula>IF(IsBlank(Email),FirstName&amp;&apos;-&apos;&amp;LastName&amp;&apos;-&apos;&amp; Text(Regional_Office_Code__c),FirstName&amp;&apos;-&apos;&amp;LastName&amp;&apos;-&apos;&amp; Email &amp;&apos;-&apos;&amp; Text(Regional_Office_Code__c))</formula>
        <name>Unique Donor Identifier</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Donor_Id_with_Region_Office_Code</fullName>
        <description>Update Donor ID field with the preferred naming convention</description>
        <field>Donor_ID__c</field>
        <formula>IF(NOT(ISBLANK(Text(Regional_Office_Code__c))),Text(Regional_Office_Code__c)+DonorIDnumber__c , Text(Owner.Payment_Country_Code__c)+DonorIDnumber__c)</formula>
        <name>Update Donor Id with Region Office Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactAlternateEmailUpdate</fullName>
        <field>npe01__AlternateEmail__c</field>
        <formula>Email</formula>
        <name>Contact.AlternateEmail.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactHomePhoneUpdate</fullName>
        <field>HomePhone</field>
        <formula>Phone</formula>
        <name>Contact.HomePhone.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactMobilePhoneUpdate</fullName>
        <field>MobilePhone</field>
        <formula>Phone</formula>
        <name>Contact.MobilePhone.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactOtherEmailUpdate</fullName>
        <field>OtherPhone</field>
        <formula>Phone</formula>
        <name>Contact.OtherEmail.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactPersonalEmailUpdate</fullName>
        <field>npe01__HomeEmail__c</field>
        <formula>Email</formula>
        <name>Contact.PersonalEmail.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactPreferredEmail</fullName>
        <field>Email</field>
        <formula>CASE( 
npe01__Preferred_Email__c , 

&quot;Work&quot;, 
if(len(npe01__WorkEmail__c)&gt;0, npe01__WorkEmail__c, 
if(len(npe01__HomeEmail__c)&gt;0, npe01__HomeEmail__c, 
npe01__AlternateEmail__c)), 

&quot;Personal&quot;, 
if(len(npe01__HomeEmail__c)&gt;0, npe01__HomeEmail__c, 
if(len(npe01__WorkEmail__c)&gt;0, npe01__WorkEmail__c, 
npe01__AlternateEmail__c)), 

&quot;Home&quot;, 
if(len(npe01__HomeEmail__c)&gt;0, npe01__HomeEmail__c, 
if(len(npe01__WorkEmail__c)&gt;0, npe01__WorkEmail__c, 
npe01__AlternateEmail__c)), 

&quot;Alternate&quot;, 
if(len(npe01__AlternateEmail__c)&gt;0, npe01__AlternateEmail__c, 
if(len(npe01__WorkEmail__c)&gt;0, npe01__WorkEmail__c, 
npe01__HomeEmail__c)), 

If(LEN(npe01__WorkEmail__c)&gt;0 , npe01__WorkEmail__c , 
if(LEN( npe01__HomeEmail__c)&gt;0, npe01__HomeEmail__c, 
npe01__AlternateEmail__c 
)))</formula>
        <name>Contact.PreferredEmail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactPreferredPhone</fullName>
        <description>Populates the standard Phone field displayed on activities based on the Preferred Phone field value.</description>
        <field>Phone</field>
        <formula>CASE(
  npe01__PreferredPhone__c ,
&quot;Work&quot;,
  npe01__WorkPhone__c  ,
&quot;Home&quot;,
 HomePhone,
&quot;Mobile&quot;,
 MobilePhone,
&quot;Other&quot;,
 OtherPhone,
If(LEN( npe01__WorkPhone__c )&gt;0 , npe01__WorkPhone__c  ,
if(LEN(  HomePhone)&gt;0,  HomePhone,
if(LEN( MobilePhone)&gt;0, MobilePhone,
OtherPhone
))))</formula>
        <name>Contact.PreferredPhone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactWorkEmailUpdate</fullName>
        <field>npe01__WorkEmail__c</field>
        <formula>Email</formula>
        <name>Contact.WorkEmail.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactWorkPhoneUpdate</fullName>
        <field>npe01__WorkPhone__c</field>
        <formula>Phone</formula>
        <name>Contact.WorkPhone.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__PreferredPhonetoWork</fullName>
        <field>npe01__PreferredPhone__c</field>
        <literalValue>Work</literalValue>
        <name>Preferred Phone to Work</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__SetPrefEmailtoWork</fullName>
        <field>npe01__Preferred_Email__c</field>
        <literalValue>Work</literalValue>
        <name>Set Pref Email to Work</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__SetWorkEmailtoEmail</fullName>
        <field>npe01__WorkEmail__c</field>
        <formula>Email</formula>
        <name>Set Work Email to Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__WorkPhonetoPhone</fullName>
        <field>npe01__WorkPhone__c</field>
        <formula>Phone</formula>
        <name>Work Phone to Phone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npo02__ContactPreferredPhone_WithHousehold</fullName>
        <description>FOR USE WITH HOUSEHOLDS. Populates the standard Phone field displayed on activities based on the Preferred Phone field value.</description>
        <field>Phone</field>
        <formula>CASE( 
npe01__PreferredPhone__c , 
&quot;Work&quot;, 
npe01__WorkPhone__c , 
&quot;Household&quot;,
 npo02__Formula_HouseholdPhone__c ,
&quot;Home&quot;, 
HomePhone, 
&quot;Personal&quot;,
HomePhone,
&quot;Mobile&quot;, 
MobilePhone, 
&quot;Other&quot;, 
OtherPhone, 
If(LEN( npe01__WorkPhone__c )&gt;0 , npe01__WorkPhone__c , 
if(LEN( HomePhone)&gt;0, HomePhone, 
if(LEN( MobilePhone)&gt;0, MobilePhone, 
OtherPhone 
))))</formula>
        <name>Contact.PreferredPhone_WithHousehold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>AR - Set Region Code From Owner</fullName>
        <actions>
            <name>AR_Set_Region_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Is_AR_Donor_To_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(NOT(CONTAINS(Owner.Alias,&apos;inte&apos;)),NOT(ISNULL(Text(Owner.Payment_Country_Code__c))),Text(Owner.Payment_Country_Code__c)= &apos;AR&apos;,NOT(Is_AR_Donor__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>CAVE %3D No %28Opt Out%29</fullName>
        <actions>
            <name>Set_Email_Opt_In_to_false</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Email_Opt_Out_Date_to_today</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Email_Opt_Out_to_true</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Can_Appeal_Via_Email__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CAVE %3D changes from No to Yes %28Opt In%29 RESUBSCRIBE</fullName>
        <actions>
            <name>Set_Email_Opt_In_Date_to_today</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Email_Opt_In_to_true</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Email_Opt_Out_to_false</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Resubscribed_to_Yes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND ( OR ( ISPICKVAL (PRIORVALUE(Can_Appeal_Via_Email__c) , &quot;No&quot;),
           HasOptedOutOfEmail = True
          ),
     ISPICKVAL (Can_Appeal_Via_Email__c , &quot;Yes&quot;)  
    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CAVE %3D changes to Yes %28Opt In%29</fullName>
        <actions>
            <name>Set_Email_Opt_In_Date_to_today</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Email_Opt_In_to_true</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Email_Opt_Out_to_false</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISPICKVAL (Can_Appeal_Via_Email__c , &quot;Yes&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CAVS %3D Yes %28Opt In%29</fullName>
        <actions>
            <name>Set_SMS_Opt_In_Date_to_today</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_SMS_Opt_In_to_false</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_SMS_Opt_In_to_true</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Can_Appeal_Via_Sms__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Orphan Owner</fullName>
        <actions>
            <name>Change_Orphan_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>RecordType.DeveloperName = &apos;Orphan&apos;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Contact is edited with CAVE %3D Yes %26 FB via Email not No</fullName>
        <actions>
            <name>Set_Feedback_Reports_via_Email_to_Yes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Can_Appeal_Via_Email__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Feedback_Notifications_Via_Email__c</field>
            <operation>notEqual</operation>
            <value>No</value>
        </criteriaItems>
        <description>Anyone opted in to email is opted into Feedback reports via email unless they have stipulated not.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ES - Set Region Code From Owner</fullName>
        <actions>
            <name>ES_Set_Region_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Is_ES_Donor_To_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(NOT(CONTAINS(Owner.Alias,&apos;inte&apos;)),NOT(ISNULL(Text(Owner.Payment_Country_Code__c))),Text(Owner.Payment_Country_Code__c)= &apos;ES&apos;,NOT(Is_ES_Donor__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Email %3D work %3D personal</fullName>
        <actions>
            <name>Blank_out_personal_email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Blank_out_work_email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND ( Email =  npe01__WorkEmail__c ,
      Email =  npe01__HomeEmail__c ,
      ISBLANK( npe01__AlternateEmail__c )
    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FR - Set Region Code From Owner</fullName>
        <actions>
            <name>FR_Set_Region_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Is_FR_Donor_To_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(NOT(CONTAINS(Owner.Alias,&apos;inte&apos;)),NOT(ISNULL(Text(Owner.Payment_Country_Code__c))),Text(Owner.Payment_Country_Code__c)= &apos;FR&apos;,NOT(Is_FR_Donor__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>GW_Volunteers__Volunteer Signup - Contact</fullName>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Notification_Email_Alert_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Thank_You_Email_Alert_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Thank_You_Sent_Contact</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>When a contact is updated or created from VolunteersSignup(FS) or VolunteersJobListing(FS), thank them and notify the volunteer manager.  Note if you are not using VolunteersSignup(FS), you can de-activate this rule to avoid multiple emails being sent.</description>
        <formula>GW_Volunteers__Volunteer_Last_Web_Signup_Date__c =  TODAY()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IE - Set Region Code From Owner</fullName>
        <actions>
            <name>IE_Set_Region_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Is_IE_Donor_To_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(NOT(CONTAINS(Owner.Alias,&apos;inte&apos;)),NOT(ISNULL(Text(Owner.Payment_Country_Code__c))),Text(Owner.Payment_Country_Code__c)= &apos;IE&apos;,NOT(Is_IE_Donor__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Make the Thomson status empty</fullName>
        <actions>
            <name>Thomson_Status_update_to_empty</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Make the Thomson status empty when Check is updated</description>
        <formula>AND(Contact_Type__c = &apos;Volunteer&apos;, Next_Thomson_Reuter_Check__c - TODAY() &gt; 31 )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Personal %3D Email and other emails blank</fullName>
        <actions>
            <name>Blank_out_personal_email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND ( Email =  npe01__HomeEmail__c ,
      ISBLANK ( npe01__WorkEmail__c ),
      ISBLANK (  npe01__AlternateEmail__c )
    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Personal the only email</fullName>
        <actions>
            <name>Copy_Personal_to_email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__HomeEmail__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__WorkEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__AlternateEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SMS Opt In is ticked</fullName>
        <actions>
            <name>Set_SMS_Opt_In_Date_to_today</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_SMS_Opt_Out_to_false</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.SMS_Single_Opt_In__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SMS Opt In is ticked update to DMS</fullName>
        <actions>
            <name>Set_SMS_PD_to_DMS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.SMS_Single_Opt_In__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SMS Opt Out is ticked</fullName>
        <actions>
            <name>Set_SMS_Opt_In_to_false</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_SMS_Opt_Out_Date_to_today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Has_Opted_Out_Of_SMS__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Email Unique</fullName>
        <actions>
            <name>Set_Email_Unique</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set Email Unique</description>
        <formula>/* Update by CG/Mike 14/05*/  Is_UK_Donor__c &amp;&amp; NOT( $Permission.Do_Not_Set_Contact_Emails )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set File Destroy Date of Volunteer</fullName>
        <actions>
            <name>Set_File_Destroy_Date_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.GW_Volunteers__Volunteer_Status__c</field>
            <operation>equals</operation>
            <value>Leaver</value>
        </criteriaItems>
        <description>When the Volunteer Status set to Leaver then set the Date of File destroy field.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Gift Aid Dates</fullName>
        <actions>
            <name>Set_Gift_Aid_Declaration_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Gift_Aid_Effective_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Set Gift Aid Dates</description>
        <formula>AND( Gift_Aid_Declared__c,  ISBLANK(Gift_Aid_Declaration_Start_Date__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Region Code From Owner</fullName>
        <actions>
            <name>Set_Regional_Office_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Upon Empty Regional Office Code update From Record Owner</description>
        <formula>ISBLANK(Text(Regional_Office_Code__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Thomson Reuter Check renews required</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Is_Active__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Is_Volunteer__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When Next Thomson Reuter Check need to renew then this workflow will update the Thomson status to Required.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Thomson_Status_update</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contact.Next_Thomson_Reuter_Check__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Unique Donor Identifier</fullName>
        <actions>
            <name>Unique_Donor_Identifier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Constructing Unique Donor Identifier - For All Regions except UK</description>
        <formula>RecordType.DeveloperName =&apos;Donor&apos; &amp;&amp; ISBLANK(Unique_Donor_Id__c) &amp;&amp; Text(Regional_Office_Code__c) &lt;&gt; &apos;UK&apos; &amp;&amp; Text(Regional_Office_Code__c) &lt;&gt; &apos;AR&apos; &amp;&amp; Text(Regional_Office_Code__c) &lt;&gt; &apos;FR&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Donor Id with Region Office Code</fullName>
        <actions>
            <name>Update_Donor_Id_with_Region_Office_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Appending Respective Region Code to Donor Id.</description>
        <formula>RecordType.DeveloperName &lt;&gt; &apos;Orphan&apos;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Work %3D Email and other emails blank</fullName>
        <actions>
            <name>Blank_out_work_email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND ( Email =  npe01__WorkEmail__c ,
      ISBLANK ( npe01__HomeEmail__c ),
      ISBLANK (  npe01__AlternateEmail__c )
    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Work is the only email</fullName>
        <actions>
            <name>Copy_Work_Email_to_Default_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__HomeEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__WorkEmail__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__AlternateEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EEmailChanged_Alternate</fullName>
        <actions>
            <name>npe01__ContactAlternateEmailUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>If the standard Email field is newly entered or changed AND the Preferred Email picklist is set to Alternate THEN Salesforce will fill in the Alternate Email field with the email address entered in the standard Email field.</description>
        <formula>AND(      ISPICKVAL( npe01__Preferred_Email__c ,&quot;Alternate&quot;),      OR(           AND(                ISNEW(),                LEN(Email)&gt;0           ),           ISCHANGED( Email )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EEmailChanged_Personal</fullName>
        <actions>
            <name>npe01__ContactPersonalEmailUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>If the standard Email field is newly entered or changed AND the Preferred Email picklist is set to Personal or Home THEN Salesforce will fill in the Personal Email field with the email address entered in the standard Email field.</description>
        <formula>AND(     OR( ISPICKVAL( npe01__Preferred_Email__c ,&quot;Personal&quot;),ISPICKVAL( npe01__Preferred_Email__c ,&quot;Home&quot;)),      OR(           AND(                ISNEW(),                LEN(Email)&gt;0           ),           ISCHANGED( Email )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EEmailChanged_Work</fullName>
        <actions>
            <name>npe01__ContactWorkEmailUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>If the standard Email field is newly entered or changed AND the Preferred Email picklist is set to Work THEN Salesforce will fill in the Work Email field with the email address entered in the standard Email field.</description>
        <formula>AND(      ISPICKVAL( npe01__Preferred_Email__c ,&quot;Work&quot;),      OR(           AND(                ISNEW(),                LEN(Email)&gt;0           ),           ISCHANGED( Email )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPhoneChanged_Home</fullName>
        <actions>
            <name>npe01__ContactHomePhoneUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>If the standard Phone field is newly entered or changed AND the Preferred Phone picklist is set to Home THEN Salesforce will fill in the Home Phone field with the phone number entered in the standard Phone field.</description>
        <formula>AND(      ISPICKVAL( npe01__PreferredPhone__c ,&quot;Home&quot;),      OR(           AND(                ISNEW(),                LEN(Phone)&gt;0           ),           ISCHANGED( Phone )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPhoneChanged_Mobile</fullName>
        <actions>
            <name>npe01__ContactMobilePhoneUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>If the standard Phone field is newly entered or changed AND the Preferred Phone picklist is set to Mobile THEN Salesforce will fill in the Mobile Phone field with the phone number entered in the standard Phone field.</description>
        <formula>AND(      ISPICKVAL( npe01__PreferredPhone__c ,&quot;Mobile&quot;),      OR(           AND(                ISNEW(),                LEN(Phone)&gt;0           ),           ISCHANGED( Phone )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPhoneChanged_Other</fullName>
        <actions>
            <name>npe01__ContactOtherEmailUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>If the standard Phone field is newly entered or changed AND the Preferred Phone picklist is set to Other THEN Salesforce will fill in the Other Phone field with the phone number entered in the standard Phone field.</description>
        <formula>AND(      ISPICKVAL( npe01__PreferredPhone__c ,&quot;Other&quot;),      OR(           AND(                ISNEW(),                LEN(Phone)&gt;0           ),           ISCHANGED( Phone )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPhoneChanged_Work</fullName>
        <actions>
            <name>npe01__ContactWorkPhoneUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>If the standard Phone field is newly entered or changed AND the Preferred Phone picklist is set to Work THEN Salesforce will fill in the Work Phone field with the phone number entered in the standard Phone field.</description>
        <formula>AND(      ISPICKVAL( npe01__PreferredPhone__c ,&quot;Work&quot;),      OR(           AND(                ISNEW(),                LEN(Phone)&gt;0           ),           ISCHANGED( Phone )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPreferred_Email%5F%5Fc</fullName>
        <actions>
            <name>npe01__ContactPreferredEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow OVERWRITES the existing value in the standard Email field based on the Preferred Email field value.  This rule needs to be turned on manually after an Upgrade to this package.</description>
        <formula>OR( LEN(Email)=0, ISCHANGED(npe01__Preferred_Email__c) , ISCHANGED(npe01__WorkEmail__c) , ISCHANGED(npe01__HomeEmail__c) , ISCHANGED(npe01__AlternateEmail__c)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPreferred_Phone%5F%5Fc</fullName>
        <actions>
            <name>npe01__ContactPreferredPhone</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow OVERWRITES the existing value in the standard Phone field based on the Preferred Phone field value.  This rule needs to be turned on manually after an Upgrade to this package.</description>
        <formula>OR(  LEN(Phone)=0, ISCHANGED(npe01__PreferredPhone__c) ,  ISCHANGED(npe01__WorkPhone__c) ,  ISCHANGED(HomePhone) ,  ISCHANGED(MobilePhone) , ISCHANGED(OtherPhone)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Email only%3A Paste to Work</fullName>
        <actions>
            <name>npe01__SetPrefEmailtoWork</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>npe01__SetWorkEmailtoEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__Preferred_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__HomeEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__AlternateEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__WorkEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>If there is a value in the standard Email field AND no values in any NPSP email fields or Preferred Email, then Salesforce updates two fields: Work Email is updated with the email address in the standard Email field and Preferred Email is set to Work.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Phone only%3A Paste to Work</fullName>
        <actions>
            <name>npe01__PreferredPhonetoWork</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>npe01__WorkPhonetoPhone</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Contact.Phone</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__PreferredPhone__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__WorkPhone__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.MobilePhone</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.HomePhone</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.OtherPhone</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>If there is a value in the standard Phone field AND no values in any NPSP phone fields or Preferred Phone, then Salesforce updates two fields: Work Phone is updated with the phone number in the standard Phone field and Preferred Phone is set to Work.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>npo02__Contact%2EPreferred_Phone%5F%5Fc WithHousehold</fullName>
        <active>false</active>
        <description>DEPRICATED: This workflow does not do anything yet.</description>
        <formula>1=2</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>GW_Volunteers__Volunteer_Signup_Thank_You_Sent_Contact</fullName>
        <assignedToType>owner</assignedToType>
        <description>An automatic thank you email has been sent to the contact for signing up to be a volunteer.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Volunteer Signup Thank You Sent - Contact</subject>
    </tasks>
</Workflow>
