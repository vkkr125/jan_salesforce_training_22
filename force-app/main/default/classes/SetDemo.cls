public class SetDemo {
    public setDemo(){
        // to initialize a set 
        Set<String> colorSet = new Set<String>();
        // to add values to set we use set method
        colorSet.add('Black');
        colorSet.add('Green');
        colorSet.add('yellow');
        
        // to print the size of the Set we use size method 
        System.debug('Set size is ' + colorSet.size()); // 3
        colorSet.add('Green');
        colorSet.add('Red');
        System.debug('Set size is ' + colorSet.size()); // 4
        
        // Apex is case insensitive, but the values in the set are case sensitive
        COLORSET.add('GREEN');
        System.debug('Set size is ' + coLoRsEt.size()); // 5
        System.debug('Set values are ' + colorSet);
        
        // set has contains method which is used to find if set contains an element or not
        System.debug('Do set contains values : GREEN ' + colorSet.contains('GREEN')); // true
        
        // to remove any element we have remove method
        colorSet.remove('GREEN'); // this will remove GREEN element from set
        System.debug('set size is ' + colorSet.size());
        System.debug('Set values are ' + colorSet);
        
        // to add one set to another,, List to set as well , we have addAll Method
        List<String> tempList = new List<String>();
        tempList.add('Orange');
        Set<String> tempSet = new Set<String>();
        tempSet.add('Pink');
        colorSet.addAll(tempList);
        colorSet.addAll(tempSet);
        
        System.debug('Set size is ' + colorSet.size());
        System.debug('Set values are ' + colorSet);
        
        // To Iterate the set
        for(String color : colorSet){
            System.debug('>>> ' + color);
        }
        // to clear the Set
        colorSet.clear();
        System.debug('Set size is ' + colorSet.size());
        System.debug('Set Values are ' + colorSet);
        
        
    }
}