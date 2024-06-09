package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class OrderDetailDTO {

    @JsonProperty("order_id")
    @NotNull(message = "Order ID cannot be null")
    @Min(value = 1, message = "Order's ID must be > 0")
    private Long orderId;

    @JsonProperty("product_id")
    @NotNull(message = "Product ID cannot be null")
    @Min(value = 1, message = "Product's ID must be > 0")
    private Long productId;

    @NotNull(message = "Price cannot be null")
    @Min(value = 0, message = "price >= 0")
    private Long price;

    @JsonProperty("number_of_product")
    @NotNull(message = "Number of products cannot be null")
    @Min(value = 1, message = "number of product must be >= 1")
    private int numberOfProducts;

    @JsonProperty("total_money")
    @NotNull(message = "Total money cannot be null")
    @Min(value = 0, message = "total_money must be >= 0")
    private int totalMoney;

    private String color;
}
