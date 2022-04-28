public class ListDemo {
    public ListDemo(){
        // to initialize a list
        // best practices :
        // always create meaningfull name, always append List at the end like collegeList etc
        List<String> colorList = new List<String>();
        List<Account> accountList = new List<Account>();
        List<Integer> integerList = new List<Integer>();
        
        // to add values to the list use add method
        colorList.add('Black');
        colorList.add('Greeen');
        colorList.add('Yellow');
        colorList.add('Black');
        
        // display the size of list
        System.debug('The list of size is' + colorList.size());
        // to get the values values at particulat at index, we use ge method
        String color = colorList.get(3);
        System.debug('The color at index 3 is ' + color);
        
        // to add the value at particular
        colorList.add(2,'Orange');
        System.debug('The list is ' + colorList);
        // to find first occurance of any element , we use indexOf method
        System.debug('The index of orange is ' + colorList.indexOf('Orange'));
 
        // to add one list into another we will use addAll method
        
        List<String> tempList = new List<String>();
        tempList.add('pink');
        tempList.add('Red');
        
        colorList.addAll(tempList);
        colorList.remove(colorList.indexOf('Orange'));
        System.debug('The list after removing orange is ' + colorList);
        
        // to iterate on list uisng for loop
        for(Integer i = 0; i<colorList.size(); i++){
            System.debug('Value at Index ' + ' is ' + colorList.get(i));
        }
        // iteration using foreach loop
        Integer count = 0;
        for(String colorName : colorList){
            System.debug('Value at Index ' + count + ' is ' + colorName);
            count ++;
        }
        colorList.clear();
        System.debug('size after clear method is ' + colorList.size());
        
    
    }
    
    // two ways to iterate the string as character 
    public void StringIteration(){
        String myName = 'vicky kumar';
        List<String> ListOfStringsAsCharacters = myName.split('');
        for(String ch : ListOfStringsAsCharacters){
            System.debug(ch);
        }
        
        // 2nd way
        for(Integer i = 0; i<myName.length(); i++){
            System.debug(myName.substring(i, i + 1));
        } 
        
    }
    
    // find the factorial of a number
    public Integer test_function(Integer val){
        return val + val <= 1 ? val : test_function(val - 1); 
    }
    
    public void test_set(){
        Set<Integer> st1 = new Set<Integer>();
        Set<Integer> st2 = new Set<Integer>();
        for(Integer i = 1; i<10; i++){
            st1.add(i);
            st2.add(i);      
        }
        
        if(st1 == st2){
            System.debug('sets are equal');
        }else{
            System.debug('sets are not equal');
        }
    }
   
}