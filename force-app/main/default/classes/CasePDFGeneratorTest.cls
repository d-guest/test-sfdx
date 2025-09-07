@isTest
public class CasePDFGeneratorTest {
    @isTest
    static void testGeneratePDF() {
        // Create a test case
        Case testCase = new Case(Subject = 'Test Case', Status = 'New');
        insert testCase;

        // Test the PDF generation
        Test.startTest();
        String result = CasePDFGenerator.generatePDF(testCase.Id);
        Test.stopTest();

        // Verify the result
        System.assertEquals('PDF generated and attached to Case.', result);

        // Check if ContentVersion was created
        List<ContentVersion> contentVersions = [SELECT Id, Title FROM ContentVersion WHERE Title LIKE 'Case_%'];
        System.assertEquals(1, contentVersions.size(), 'One ContentVersion should be created.');

        // Check if ContentDocumentLink was created
        List<ContentDocumentLink> contentDocumentLinks = [SELECT Id, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId = :testCase.Id];
        System.assertEquals(1, contentDocumentLinks.size(), 'One ContentDocumentLink should be created.');
    }
}
