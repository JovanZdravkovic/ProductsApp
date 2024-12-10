package org.example.models;

import lombok.Builder;
import lombok.Data;

import java.sql.Date;
import java.util.UUID;

@Data
@Builder
public class Product {
    private UUID id;
    private String productName;
    private String productManufacturer;
    private boolean warranty;
    private Date productManufacturingDate;
}
