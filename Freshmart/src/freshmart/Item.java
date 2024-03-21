package freshmart;

public class Item {

    private int itemId;
    private String itemName;
    private double price;
    private String description;
    private String imgURL;

    public Item(int itemId, String itemName, double price, String description, String imgURL) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.price = price;
        this.description = description;
        this.imgURL = imgURL;
    }

    @Override
    public String toString() {
        return "Item{"
                + "itemId=" + itemId
                + ", itemName='" + itemName + '\''
                + ", price=" + price
                + ", description='" + description + '\''
                + ", imgURL='" + imgURL + '\''
                + '}';
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

}
