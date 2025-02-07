package com.project.shopapp.cotrollers;


import com.project.shopapp.dtos.CategoryDTO;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/categories")

public class CategoryController {
    // Hiển thị tất cả các Categories
    @GetMapping("")// http://localhost:6868/api/v1/categories?page=1&limit=10
    public ResponseEntity<String> getAllCategories(
            @RequestParam("page") int page,
            @RequestParam("limit") int limit
    ){
        return  ResponseEntity.ok(String.format("getAllCategories, page =%d, limit = %d",page, limit));
    }


    @PostMapping("")
    // Nếu tham số truyền vào là một Object thì sao ? => Data Transfer Object = Request Object
    public ResponseEntity<?> insertCategories(@Valid @RequestBody CategoryDTO categoryDTO,
                                                   BindingResult result){
        if(result.hasErrors()){
           List<String> errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errorMessages);
        }
        return  ResponseEntity.ok("Post " + categoryDTO);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateCategory(@PathVariable Long id){
        return ResponseEntity.ok("insertCategory with id = " +id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteCategory(@PathVariable Long id){
        return ResponseEntity.ok("deleteCategory with id = " +id );
    }
}
