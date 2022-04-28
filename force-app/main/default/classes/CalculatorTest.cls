// salesforce do  not count test classes under the limitation // any gorverner limit
@isTest
public class CalculatorTest {
    
    @isTest
    static void testSum(){
        Calculator calc = new Calculator(5,10);
        calc.sum();
        
        System.assertEquals(15,calc.result, 'Expected and actual do not match');
    }
    
    static testmethod void testMultiply(){
        Calculator calc = new Calculator(5,10);
        calc.multiply();
        System.assertEquals(50, calc.result, 'Expected and actual do not match');
    }
}