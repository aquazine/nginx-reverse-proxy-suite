# Production-Ready Nginx Layer 7 Reverse Proxy & Load Balancing Suite

A modular, production-grade reverse proxy and ingress configuration blueprint engineered for high-availability microservice routing, WebSocket gateway termination, and dynamic upstream load distribution.

## Architecture Overview

- Clients (HTTP/WebSocket) -> Nginx Layer 7 Edge Router (Port 80/443)
- Header Mutation: Host, X-Real-IP, X-Forwarded-For, X-Forwarded-Proto
- Buffering: Non-blocking epoll memory buffering and worker latency isolation
- Upstream 1: 127.0.0.1:8081 (least_conn, max_fails=3 fail_timeout=10s)
- Upstream 2: 127.0.0.1:8082 (least_conn, max_fails=3 fail_timeout=10s)
- WebSocket Gateway: 127.0.0.1:9001 (HTTP/1.1 Upgrade tunnel)

## Repository Structure

.
├── configs/
│   ├── proxy_params.conf          # Common Layer 7 forwarded headers & buffers
│   ├── reverse_proxy.conf         # Single backend reverse proxy pattern
│   ├── upstream_cluster.conf      # Multi-node load balancing (least_conn)
│   └── websocket_gateway.conf     # Asynchronous bi-directional WebSocket gateway
├── scripts/
│   ├── start_mock_backends.sh     # Lightweight local mock HTTP endpoints
│   └── test_load_balancer.sh      # Automated curl verification harness
└── README.md

## Key Highlights

- Layer 7 Transparency: Preserves upstream auditability via X-Real-IP and X-Forwarded-For headers.
- Request Buffering: Decouples slow clients from application processes.
- Fault Tolerance: Passive health checks with seamless failover across healthy nodes.
- WebSocket Tunneling: Full HTTP/1.1 hop-by-hop upgrade headers for persistent streams.

## Verification

1. Start mock backends:
   ./scripts/start_mock_backends.sh

2. Run load distribution test:
   ./scripts/test_load_balancer.sh lb.local http://127.0.0.1 10
