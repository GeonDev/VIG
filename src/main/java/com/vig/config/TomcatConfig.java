package com.vig.config;

import org.apache.catalina.Context;
import org.apache.catalina.webresources.StandardRoot;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TomcatConfig { 
	@Bean
    public ServletWebServerFactory embeddedServletContainerFactory() {
    return new TomcatServletWebServerFactory() {

        @Override
        protected void postProcessContext(Context context) {
            final int maxCacheSize = 40 * 1024;
            StandardRoot standardRoot = new StandardRoot(context);
            standardRoot.setCacheMaxSize(maxCacheSize);
            context.setResources(standardRoot);
        }
    };
}

}
