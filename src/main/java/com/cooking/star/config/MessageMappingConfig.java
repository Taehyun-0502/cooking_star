package com.cooking.star.config;

import java.util.Locale;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Configuration
public class MessageMappingConfig implements WebMvcConfigurer {

    private final WebSecurityCustomizer customizer;

    MessageMappingConfig(WebSecurityCustomizer customizer) {
        this.customizer = customizer;
    }

	@Bean
	LocaleResolver localeResolver() {
		
		SessionLocaleResolver resolver = new SessionLocaleResolver();
		resolver.setDefaultLocale(Locale.KOREAN);
		
		CookieLocaleResolver resolver2=new CookieLocaleResolver();
		resolver2.setDefaultLocale(Locale.KOREAN);
		
		return resolver2;
		
		
	}
	
}
