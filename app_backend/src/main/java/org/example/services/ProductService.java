package org.example.services;

import lombok.RequiredArgsConstructor;
import org.example.dao.ProductDAO;
import org.example.dto.ProductDTO;
import org.example.models.Product;
import org.example.utils.ErrorResponse;
import org.jdbi.v3.core.Jdbi;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

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

    public UUID createProduct(ProductDTO productDTO) throws Exception {
        try {
            UUID id = dbi.inTransaction(handle -> {
                ProductDAO productDAO = handle.attach(ProductDAO.class);
                Product productModel = Product.builder()
                        .productName(productDTO.getProductName())
                        .productManufacturer(productDTO.getProductManufacturer())
                        .warranty(productDTO.isWarranty())
                        .productManufacturingDate(java.sql.Date.valueOf(productDTO.getProductManufacturingDate()))
                        .build();
                return productDAO.insert(productModel);
            });
            return id;
        } catch (Exception e) {
            throw new Exception(e);
        }
    }
}
