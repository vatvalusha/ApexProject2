public with sharing class CookieJar {
    public Cookie idItem;
    public String item;
    public List<String> listItems = new List<String>();

    public CookieJar(){}

    /**
    Create constructoer with initialization Cookie on current Page
    and Add this Cookie in List Cookies rewriting ald value

     */
    public CookieJar(String item) {
        this.item = item;
        idItem = new Cookie('item', item, null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[]{idItem});
    }

    /**
    Get list items on current session
     */
    private String getItemString() {
        Cookie item = ApexPages.currentPage().getCookies().get('item');
        if(item == null) {
            return 'null';
        }
        return item.getValue();
    }

    /**
    Clear List cookie if don't using for current session
     */
    public void clearCookie(Cookie cookie){
        ApexPages.currentPage().setCookies(new System.Cookie[] { new System.Cookie(cookie.getName(), null, null, 0, false) });
        ApexPages.currentPage().getCookies().put(cookie.getName(), null);

    }
}