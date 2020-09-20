package com.github.eugene.controller;

import com.github.eugene.dao.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/employee")
public class EmployeeController {

    private static final String SUCCESS_STATUS = "success";
    private static final String ERROR_STATUS = "error";
    private static final int CODE_SUCCESS = 100;
    private static final int AUTH_FAILURE = 102;

    @Autowired
    private EmployeeRepository repo;

    @GetMapping
    public BaseResponse getAll() {
        return new BaseResponse(SUCCESS_STATUS, 200, repo.findAll());
    }

    @GetMapping("/{id}")
    public BaseResponse getById(@PathVariable(value="id") Long id) {
        return new BaseResponse(SUCCESS_STATUS,2, repo.findById(id));
    }

}
