package org.example.services;

import lombok.RequiredArgsConstructor;
import org.example.dao.ProductDAO;
import org.example.dto.ProductDTO;
import org.example.models.Product;
import org.example.utils.ErrorResponse;
import org.jdbi.v3.core.Jdbi;

import java.util.ArrayList;
import java.util.List;

public class ProductService{
    private final Jdbi dbi;

    public ProductService(Jdbi dbi) {
        this.dbi = dbi;
    }

    public List<ProductDTO> getAllProducts() throws Exception {
        try {
            List<ProductDTO> productsDTO = new ArrayList<>();
            dbi.useHandle(handle -> {
                ProductDAO productDAO = handle.attach(ProductDAO.class);
                List<Product> products = productDAO.getAllProducts();
                for(Product p : products) {
                    ProductDTO productDTO = ProductDTO.builder()
                            .productName(p.getProductName())
                            .productManufacturer(p.getProductManufacturer())
                            .warranty(p.isWarranty())
                            .productManufacturingDate((p.getProductManufacturingDate()).toString())
                            .build();
                    productsDTO.add(productDTO);
                }
            });
            return productsDTO;
        } catch (Exception e) {
            throw new Exception(e);
        }
    }
}
