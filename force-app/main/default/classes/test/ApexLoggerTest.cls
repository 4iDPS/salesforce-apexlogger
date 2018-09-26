@isTest
public class ApexLoggerTest {
    @isTest
    public static void test_exception_log() {
        try {
            Integer n = Integer.valueOf('String');
        } catch (Exception ex) {
            new ApexLogger.ErrorLog(ex);
        }
        List<ApexLog__c> actual = [SELECT createddate, classname__c, datelog__c, levellog__c, linelog__c, messagelog__c, methodname__c
                                    FROM ApexLog__c
                                    WHERE classname__c = 'ApexLoggerTest'];
        System.assertNotEquals(0, actual.size());
        System.assertEquals('test_exception_log', actual.get(0).methodname__c);
        System.assertEquals(6, actual.get(0).linelog__c);
    }

    @isTest
    public static void test_info_log() {
        new ApexLogger.InfoLog('Classname', 'MethodName', 'Starting a method.');
        List<ApexLog__c> actual = [SELECT createddate, classname__c, datelog__c, levellog__c, linelog__c, messagelog__c, methodname__c
                            FROM ApexLog__c];
        System.assertNotEquals(0, actual.size());
        System.assertEquals('Classname', actual.get(0).classname__c);
        System.assertEquals('MethodName', actual.get(0).methodname__c);
        System.assertEquals('Starting a method.', actual.get(0).messagelog__c);

    }
}