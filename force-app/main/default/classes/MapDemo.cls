public class MapDemo {
    // (key,values) pairs
    // key's are unique, values could be duplicates 
    // key's should always be premitive data type
    
    public MapDemo(){
        Map<String,String> monthToColorMap = new Map<String,String>();
        // to add values to the map we use put method
        monthToColorMap.put('Jan','Blue');
        monthToColorMap.put('Feb','Red');
        monthToColorMap.put('March','Black');
        
        // to print the size of map we use Size()
        System.debug('the size of Map is ' + monthToColorMap.size());
        System.debug('Map is ' + monthToColorMap);
        
        // if we add a value to a map with existing key, it overrides the values
        monthToColorMap.put('March','Orange');
        System.debug('After updating March month Map is ' + monthToColorMap);
        
        // to get the value at particular key we use get(key) method
        String color = monthToColorMap.get('Feb');
        System.debug('Color for feb month is ' + color);
        
        // to check if map contains key or not
        System.debug('do Map contains Key : Feb' + monthToColorMap.containsKey('Feb'));
        System.debug('do Map contains Key April : ' + monthToColorMap.containsKey('April'));
        
        // we can extract all the keys from the map in a set 
        Set<String> mapkeySet = monthToColorMap.KeySet();
        System.debug('the keys are ' + mapKeySet);
        
        // we can extract all the values in form of list
        List<String> mapValuesList = new List<String>();
        mapValuesList = monthToColorMap.values();
        System.debug('the values are ' + mapValuesList);
        // to iterate on the map , we iterate on the keys and get the values form the keys
        for(String key : monthToColorMap.keySet()){
            System.debug('for the key : ' + key + ' Valeus is ' + monthToColorMap.get(key));
        }
        // to clear all the values from the map
        monthToColorMap.clear();
        System.debug('the size of Map is ' + monthToColorMap.size());
        
    }
    
    // count the frequency of strings
    public void countFrequency(){
        List<String> strs = new List<String>{'vicky','vicky','kumar','tiwari','rakeshk','rakeshk','vicky'};
        Map<String,Integer> count = new Map<String,Integer>();
        for(String str : strs){
            if(!count.containsKey(str)){
                count.put(str,0);
            }
            count.put(str,count.get(str) + 1);
            
        }
        for(String key : count.keySet()){
            System.debug(key +'   ' +  count.get(key));
        }
       
    }
    
    
}