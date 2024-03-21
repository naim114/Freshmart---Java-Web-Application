package freshmart;

public class Cart {

    private int cartId;
    private User user;
    private Item item;
    private int quantity;

    public Cart(int cartId, User user, Item item, int Quantity) {
        this.cartId = cartId;
        this.user = user;
        this.item = item;
        this.quantity = Quantity;
    }

    @Override
    public String toString() {
        return "Cart{"
                + "cartId=" + cartId
                + ", user=" + user
                + ", item=" + item
                + ", quantity=" + quantity
                + '}';
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int Quantity) {
        this.quantity = Quantity;
    }

}
