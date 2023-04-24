package Cart;

import com.utar.model.entity.Orderdetail;
import com.utar.model.entity.Product;

public class Cart{
    public Orderdetail orderdetail;
    private Product product;

    public Cart() {}

    public Orderdetail getOrderdetail() {
        return this.orderdetail;
    }

    public void setOrderdetail(Orderdetail orderdetail) {
        this.orderdetail = orderdetail;
    }

}
