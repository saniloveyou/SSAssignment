package Cart;

import com.utar.model.entity.Product;

public class Cart{
    public Product product;
    private int quantity;

    public Cart() {}

    public Product getProduct() {
        return this.product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}
