public with sharing class ControllerItemSingle {
    /**
    get list ids Items for get List Items
     */
    public List<ID> lItems = new List<Id>();
    /**
    value current item on page
     */
    public Item__c item { get; set; }
    /**
    List items for wrapper
     */
    public List<Item__c> items { get; set; }
    /**
    variable witch chancging depends on current count selected items for single item
     */
    private String globalItem { get; set; }
    /**
    get List category for display on left block page
     */
    public List<Category__c> categories { get; set; }
    /**
    varible for counting count items on stock
     */
    public Integer count { get; set; }
    /**
    List with Items and count every item on stock
     */
    public List<WrapperItem> wrapperItems = new List<WrapperItem>();

    public JunctionBasket__c junctionBasket { get; set; }


    public ControllerItemSingle(ApexPages.StandardSetController controller) {
        item = [
                SELECT id,Name, Price__c, Photo__c, Description__c,Count__c
                FROM Item__c
                WHERE id = :ApexPages.currentPage().getParameters().get('idItem')
        ];
        categories = [
                SELECT Id, Name
                FROM Category__c
        ];
    }


    public void getListItems() {
        items = [
                SELECT id, Name__c, Price__c, name, Description__c, Count__c
                FROM Item__c
                WHERE id in:lItems
        ];
    }


    public void add() {
        Cookie counter = ApexPages.currentPage().getCookies().get('item');
        if (counter == null) {
            globalItem = ApexPages.currentPage().getParameters().get('idItem');
            CookieJar cookieJar = new CookieJar(countingItems(globalItem));
        } else {
            String currentItem = ApexPages.currentPage().getParameters().get('idItem');
            globalItem = counter.getValue() + countingItems(currentItem);
            CookieJar cookieJar = new CookieJar(globalItem);
        }
    }

    public String countingItems(String currentItem){
        String itemCount = currentItem;
        for (Integer i = 0; i < count - 1; i++) {
            itemCount = itemCount + ApexPages.currentPage().getParameters().get('idItem');
        }
        return itemCount;
    }

    public void fullWrpper() {
        for (Item__c item : items) {
            wrapperItems.add(new WrapperItem(item, count));
        }
    }

    ///////////////// GET ///////////////////

    public String getCount() {
        Cookie counter = ApexPages.currentPage().getCookies().get('item');
        if (counter == null) {
            return null;
        }
        return counter.getValue();
    }

    public List<WrapperItem> getWrapperItems() {
        return wrapperItems;
    }

    public Item__c getItem() {
        return item;
    }


}