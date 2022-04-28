public class Calculator {
    Integer num1,num2;
    public Integer result;
    public Calculator(Integer n1,Integer n2){
        this.num1 = n1;
        this.num2 = n2;
        
    }
    public void sum(){
        this.result = this.num1 + this.num2;
        System.debug('sum of both numbers is ' + result);
    }    
    public void multiply(){
        this.result = this.num1 * this.num2;
        System.debug('multiplication of both numbers is :' + this.result);
    }
    
}