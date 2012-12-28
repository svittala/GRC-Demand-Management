<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_email_to_Allocated_resource_and_Project_Manager</fullName>
        <description>Send email to Allocated resource and Project Manager</description>
        <protected>false</protected>
        <recipients>
            <field>Resource_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Skill_Approval_Email</template>
    </alerts>
    <rules>
        <fullName>Resource Allocation</fullName>
        <actions>
            <name>Send_email_to_Allocated_resource_and_Project_Manager</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Position__c.Status__c</field>
            <operation>equals</operation>
            <value>E-Filled</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
