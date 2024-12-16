package org.example.dao;

import org.example.mappers.ProductMapper;
import org.example.models.Product;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.GetGeneratedKeys;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import org.jdbi.v3.sqlobject.transaction.Transactional;
import java.util.List;
import java.util.UUID;

public interface ProductDAO extends Transactional<ProductDAO> {
    @SqlQuery("SELECT * FROM PRODUCTS")
    @UseRowMapper(ProductMapper.class)
    List<Product> getAllProducts();

    @SqlUpdate("INSERT INTO PRODUCTS(PRODUCT_NAME, PRODUCT_MANUFACTURER, WARRANTY, PRODUCT_MANUFACTURING_DATE) VALUES (:productName, :productManufacturer, :warranty, :productManufacturingDate)")
    @GetGeneratedKeys
    UUID insert(@BindBean Product product);
}
