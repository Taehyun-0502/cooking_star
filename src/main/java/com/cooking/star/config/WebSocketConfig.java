package com.cooking.star.config;

import java.util.Map;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.security.core.Authentication;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.server.HandshakeInterceptor;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig  implements WebSocketMessageBrokerConfigurer{

	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		
		registry.enableSimpleBroker("/topic");
		
		registry.setApplicationDestinationPrefixes("/app");
		
		
	}
	
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		
		registry.addEndpoint("/ws")
		.addInterceptors(adminMessageHandshakeInterceptor())
		.setAllowedOriginPatterns("*")
		.withSockJS();
		
		
		
	}

	private HandshakeInterceptor adminMessageHandshakeInterceptor() {
		return new HandshakeInterceptor() {
			@Override
			public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
					org.springframework.web.socket.WebSocketHandler wsHandler, Map<String, Object> attributes)
					throws Exception {

				if (!(request.getPrincipal() instanceof Authentication authentication)) {
					return false;
				}

				return authentication.getAuthorities().stream()
						.anyMatch(authority -> "ROLE_ADMIN".equals(authority.getAuthority())
								|| "ROLE_MANAGER".equals(authority.getAuthority()));
			}

			@Override
			public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
					org.springframework.web.socket.WebSocketHandler wsHandler, Exception exception) {
			}
		};
	}
	
	
	
}
