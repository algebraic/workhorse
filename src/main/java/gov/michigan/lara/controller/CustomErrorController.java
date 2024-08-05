package gov.michigan.lara.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import gov.michigan.lara.config.UserDetailsUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, HttpServletResponse response, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        Integer statusCode = status != null ? Integer.valueOf(status.toString()) : 500;

        if (isApiRequest(request)) {
            Map<String, Object> errorAttributes = new HashMap<>();
            errorAttributes.put("status", statusCode);
            errorAttributes.put("message", request.getAttribute(RequestDispatcher.ERROR_MESSAGE));
            errorAttributes.put("path", request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI));
            errorAttributes.put("timestamp", System.currentTimeMillis());
            response.setStatus(statusCode);
            return "forward:/error-json";
        } else {
            model.addAttribute("displayname", UserDetailsUtil.getCurrentUserDisplayName());
            model.addAttribute("statusCode", statusCode);
            model.addAttribute("message", request.getAttribute(RequestDispatcher.ERROR_MESSAGE));
            model.addAttribute("exception", request.getAttribute(RequestDispatcher.ERROR_EXCEPTION));
            return "error";
        }
    }

    private boolean isApiRequest(HttpServletRequest request) {
        String accept = request.getHeader("Accept");
        return accept != null && accept.contains("application/json");
    }
}
