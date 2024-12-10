package org.example.mappers;

import org.example.models.Product;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

public class ProductMapper implements RowMapper<Product> {

    @Override
    public Product map(ResultSet rs, StatementContext ctx) throws SQLException {
        return Product.builder()
                .id(UUID.fromString(rs.getString("id")))
                .productName(rs.getString("product_name"))
                .productManufacturer(rs.getString("product_manufacturer"))
                .warranty(rs.getBoolean("warranty"))
                .productManufacturingDate(rs.getDate("product_manufacturing_date"))
                .build();
    }
}
