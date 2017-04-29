public with sharing class ControllerBasket {
    private String items { get; set; }
    private CookieJar cookieJar = new CookieJar();
    private List<String> listItems { get; set; }
    private Set<Id> setId = new Set<ID>();
    private List<ID> listIDs = new List<Id>();
    private List<Item__c> lItems = new List<Item__c>();


    /*
    Tottal sum prices all item on basket
     */
    public Integer tottalPrice { get; set; }

    /**
    Zero objject for empty basket
     */
    public WrapperItem singl = new WrapperItem(new Item__c(Name__c = '-', Price__c = 0), 0);

    /**
    Map where save count itema
     */
    public Map<ID, Integer> count = new Map<Id, Integer>();

    public List<WrapperItem> wrapperItems = new List<WrapperItem>();

    public List<Integer> couter = new List<Integer>();

    public ControllerBasket(ApexPages.StandardSetController controller) {
        tottalPrice = 0;
        Cookie item = ApexPages.currentPage().getCookies().get('item');
        if (item == null) {
            wrapperItems = new List<WrapperItem>();
            wrapperItems.add(singl);

        } else {
            items = item.getValue();
            listItems = items.split('(?<=\\G.{18})');
            getListIds(listItems);
            getSetIds(listItems);
            getListItems(listIDs);
            findSameEl(listIDs);
            getTotalPrice();
        }
    }


    public void getTotalPrice() {
        for (WrapperItem wrapperItem : wrapperItems) {
            tottalPrice = tottalPrice + (Integer) (wrapperItem.id.Price__c * wrapperItem.counter);
        }
    }
    /**
        Parser String cookie and get id from String
     */
    private void getSetIds(List<String> items) {
        for (String str : items)
            setId.add(ID.valueOf(str));
    }

    /**
        Get Object Item__c by id from getSetIds
     */

    private void getListItems(List<ID> ids) {
        lItems = [
                SELECT Name__c, Price__c, Category__r.Name,Category__c, Count__c
                FROM Item__c
                WHERE id in:ids
        ];
    }


    private void getListIds(List<String> items) {
        for (String str : items)
            listIDs.add(ID.valueOf(str));

    }

    public PageReference buy() {

        Basket__c basket;
        List<JunctionBasket__c> junctionBaskets = new List<JunctionBasket__c>();
        Cookie cookieUser = ApexPages.currentPage().getCookies().get('user');
        if (cookieUser == null) {
            return new PageReference(Label.pageRegistration);
        }
        basket = new Basket__c(ShopUser__c = cookieUser.getValue());
        insert basket;

        for (Item__c item : lItems) {
            if (item.Count__c >= count.get(item.id)) {
                junctionBaskets.add(new JunctionBasket__c(ItemReference__c = item.id, BasketReference__c = basket.id, ItemCount__c = count.get(item.id)));
                item.Count__c = item.Count__c - count.get(item.id);

            } else {
                throw new MathException(Label.error);
            }
        }
        upsert lItems;
        insert junctionBaskets;

        cancelBuying();
        PageReference bs = new PageReference(Label.basketPage);
        bs.setRedirect(true);
        return bs;
    }

    public PageReference cancelBuying() {
        Cookie cookie = ApexPages.currentPage().getCookies().get('item');
        if (cookie != null) {
            cookieJar.clearCookie(cookie);
        }
        PageReference basket = new PageReference(Label.basketPage);
        basket.setRedirect(true);
        return basket;
    }


    private void findSameEl(List<ID> idlist) {
        Integer counter = 0;
        for (Integer i = 0; i < idlist.size(); i++) {
            for (Integer k = 0; k < idlist.size(); k++) {
                if (idlist.get(i) == idlist.get(k)) {
                    counter++;
                }
            }
            count.put(idlist.get(i), counter);
            counter = 0;
        }
        for (Item__c item : lItems) {
            wrapperItems.add(new WrapperItem(item, count.get(item.id)));
        }
    }


    public PageReference backMain() {
        return new PageReference(Label.IndexPage);
    }

    ////////////////////////////////////////////////////////
    //////////////////GETters and SETters///////////////////
    ////////////////////////////////////////////////////////
    public List<Item__c> getlItems() {
        return lItems;
    }

    public List<WrapperItem> getWrapperItems() {
        return wrapperItems;
    }


}