package org.example.dao;

import org.example.mappers.ProductMapper;
import org.example.models.Product;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import org.jdbi.v3.sqlobject.transaction.Transactional;
import java.util.List;

public interface ProductDAO extends Transactional<ProductDAO> {
    @SqlQuery("SELECT * FROM PRODUCTS")
    @UseRowMapper(ProductMapper.class)
    List<Product> getAllProducts();
}
