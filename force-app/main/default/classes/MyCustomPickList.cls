global class MyCustomPickList extends VisualEditor.DynamicPickList{
    
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('yyyy/MM/dd', 'yyyy/MM/dd');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DataRow value1 = new VisualEditor.DataRow('yyyy/MM/dd', 'yyyy/MM/dd');
        VisualEditor.DataRow value2 = new VisualEditor.DataRow('yyyy/MM/dd hh:mm:ss', 'yyyy/MM/dd hh:mm:ss');
        VisualEditor.DataRow value3 = new VisualEditor.DataRow('MMM dd, yyyy z', 'MMM dd, yyyy z');
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        myValues.addRow(value1);
        myValues.addRow(value2);
        myValues.addRow(value3);
        return myValues;
    }
}



