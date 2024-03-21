package freshmart;

import java.time.LocalDateTime;

public class Purchase {

    private int purchaseId;
    private User user;
    private String itemName;
    private double price;
    private String imgURL;
    private int quantity;
    private Integer rate;
    private String comment;
    private LocalDateTime createdAt;

    public Purchase(int purchaseId, User user, String itemName, double price, String imgURL, int quantity, Integer rate, String comment, LocalDateTime createdAt) {
        this.purchaseId = purchaseId;
        this.user = user;
        this.itemName = itemName;
        this.price = price;
        this.imgURL = imgURL;
        this.quantity = quantity;
        this.rate = rate;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    public int getPurchaseId() {
        return purchaseId;
    }

    public void setPurchaseId(int purchaseId) {
        this.purchaseId = purchaseId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Integer getRate() {
        return rate;
    }

    public void setRate(Integer rate) {
        this.rate = rate;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

}
