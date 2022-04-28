<aura:application extends="force:slds">
    <!-- <aura:attribute name="applabel" type="String" default="My Label Default Value from Application"/>
    <aura:attribute name="appamount" type="Decimal" default="0.2"/>
    <c:Demo2Attribute label="{!v.applabel}" amount="{!v.appamount}"/>
    <c:Demo3AllAttributesType /> -->

    <!-- each component has a hidden body {!v.body}  here in below
    heder of facets will be set via message provided footer as well and rest of
    the values will be set to the body attribute -->
    
    <!-- <c:Demo4Facets>
        This is the content of body facet <br/>
        <c:Demo1HelloWorld />
        <aura:set attribute="header">
            This is the header set
        </aura:set>
        <aura:set attribute="footer">
            This is the footer set
        </aura:set>
        <c:Demo2Attribute />
        <c:Demo3AllAttributesType />

    </c:Demo4Facets> -->

    <!-- <c:Demo5FacetChild>
        This is child facet
    </c:Demo5FacetChild> -->

    <!-- <c:Demo5Auraif /> -->
    <!-- <c:Demo7AuraIteration /> -->
    <!-- <c:Demo8LocalGlobalIds /> -->
    <!-- <c:Demo9CSS /> -->
    <!-- <c:Demo2Attribute /> -->

    <!-- <c:Demo11CSStoggle /> -->
    <!-- <c:Demo12CallingApex/> -->
    <!-- <c:Demo13CallingApexWithParam/> -->
    <!-- <c:Demo14AuraMethods /> -->
    <!-- <c:Demo15UsingExternalJS/> -->
    <!-- <c:Demo16UsingStaticResources /> -->
     <!-- <c:Demo17UsingAuraComponent />  -->

     <!-- <c:Demo19cmpEventHandler /> -->



    <!-- <c:Demo4Facets>
        <c:Demo20AppEventHandler />
        <c:Demo20AppEventFire />
    </c:Demo4Facets> -->
     <!-- <c:Demo19GrandParent /> -->

    <!-- Demo21 even handling -->
    <!-- <aura:handler name="bubbleevent" event="c:cmpevent" action="{!c.handleBubble}"/>
    <c:Demo21Parent /> -->
    <!-- <c:Demo12CallingApex/> -->

    <!-- <c:Demo22Wrapper /> -->

    <!-- <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>
    <aura:handler name="render" value="{!this}" action="{!c.onRender}"/> -->
    <c:Demo23LifeCycle/>



</aura:application>