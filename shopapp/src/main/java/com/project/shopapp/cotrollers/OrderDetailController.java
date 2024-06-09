package com.project.shopapp.controllers;

import com.project.shopapp.dtos.OrderDTO;
import com.project.shopapp.dtos.OrderDetailDTO;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("${api.prefix}/order_details")
public class OrderDetailController {

    @PostMapping
    public ResponseEntity<String> createOrderDetail(
            @Valid @RequestBody OrderDetailDTO newOrderDetail
    ){
        return ResponseEntity.ok("create OrderDetail here");
    }

    @GetMapping("/{id}")
    public ResponseEntity<String> getOrderDetail(
            @Valid @PathVariable("id") Long id
    ){
        return ResponseEntity.ok("getOrderDetail with id  = " + id);
    }

    @GetMapping("/order/{orderId}")
    public ResponseEntity<String> getOrderDetails(
            @Valid @PathVariable("orderId") Long orderId
    ){
        return ResponseEntity.ok("getOrderDetails with orderId = " + orderId);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateOrderDetail(
            @Valid @PathVariable("id") Long id,
            @RequestBody OrderDetailDTO newOrderDetailData
    ){
        return ResponseEntity.ok("updateOrderDetail with id = " + id + ", newOrderDetailData: " + newOrderDetailData);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrderDetail(
            @Valid @PathVariable("id") Long id
    ){
        return ResponseEntity.noContent().build();
    }
}
