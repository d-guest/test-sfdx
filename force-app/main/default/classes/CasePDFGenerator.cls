public with sharing class CasePDFGenerator {
    @AuraEnabled
    public static String generatePDF(Id caseId) {
        // Query the Case to ensure access
        Case c = [SELECT Id, CaseNumber FROM Case WHERE Id = :caseId LIMIT 1];

        // Render the Visualforce page as PDF
        PageReference pdfPage = Page.CasePDFPage;
        pdfPage.getParameters().put('id', caseId);
        Blob pdfBlob = pdfPage.getContentAsPDF();

        // Create a ContentVersion (File) record
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Case_' + c.CaseNumber + '_PDF';
        cv.PathOnClient = 'Case_' + c.CaseNumber + '.pdf';
        cv.VersionData = pdfBlob;
        insert cv;

        // Link the file to the Case
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;
        cdl.LinkedEntityId = caseId;
        cdl.ShareType = 'V';
        cdl.Visibility = 'AllUsers';
        insert cdl;

        return 'PDF generated and attached to Case.';
    }
}