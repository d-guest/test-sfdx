// Apex script to create mock data for Account, Lead, Opportunity, and Case
// Run this in the Salesforce Developer Console or via sfdx force:apex:execute

List<Account> accounts = new List<Account>();
for (Integer i = 0; i < 5; i++) {
    accounts.add(new Account(Name = 'Test Account ' + i));
}
insert accounts;

List<Lead> leads = new List<Lead>();
for (Integer i = 0; i < 5; i++) {
    leads.add(new Lead(LastName = 'LeadLast' + i, Company = 'Test Account ' + i, Status = 'Open - Not Contacted'));
}
insert leads;

List<Opportunity> opps = new List<Opportunity>();
for (Integer i = 0; i < 5; i++) {
    opps.add(new Opportunity(Name = 'Test Opportunity ' + i, StageName = 'Prospecting', CloseDate = Date.today().addDays(30), AccountId = accounts[i].Id));
}
insert opps;

List<Case> cases = new List<Case>();
for (Integer i = 0; i < 5; i++) {
    cases.add(new Case(Subject = 'Test Case ' + i, AccountId = accounts[i].Id, Status = 'New'));
}
insert cases;

System.debug('Mock data created: ' + accounts.size() + ' Accounts, ' + leads.size() + ' Leads, ' + opps.size() + ' Opportunities, ' + cases.size() + ' Cases.');
