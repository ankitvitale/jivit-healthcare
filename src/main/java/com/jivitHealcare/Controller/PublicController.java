package com.jivitHealcare.Controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PublicController {
    private static final Logger logger = LoggerFactory.getLogger(PublicController.class);

    @RequestMapping("/{path:^(?!api|index\\.html|static|js|css|img|favicon\\.ico).*}")
    public String forwardFrontendRoutes() {
        logger.info("Forwarding frontend route to index.html");
        return "forward:/index.html";
    }
}

