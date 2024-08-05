package gov.michigan.lara.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RestController
public class ErrorJsonController {

    @RequestMapping("/error-json")
    public Map<String, Object> handleErrorJson(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        Integer statusCode = status != null ? Integer.valueOf(status.toString()) : 500;

        Map<String, Object> errorAttributes = new HashMap<>();
        errorAttributes.put("status", statusCode);
        errorAttributes.put("message", request.getAttribute(RequestDispatcher.ERROR_MESSAGE));
        errorAttributes.put("path", request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI));
        errorAttributes.put("timestamp", System.currentTimeMillis());

        return errorAttributes;
    }

    @GetMapping("/500")
    public String test500() {
        throw new RuntimeException("Internal server error");
    }
}
