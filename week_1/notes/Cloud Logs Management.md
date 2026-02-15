主题：**云原生日志管理与分析平台**，覆盖云原生架构、日志处理全链路、前后端开发、运维监控。

采用开源组件（如 Elastic Stack：Elasticsearch+Logstash+Kibana）进行二次开发。

### 项目核心技术栈
| 技术 | 开发语言 | 应用场景 |
| --- | --- | --- |
| 网络与协议 | TCP/UDP/HTTP、Syslog/GELF/Logfmt | 日志传输（支持不同采集端的协议接入）；需理解协议格式、数据分包 / 粘包处理、传输加密（TLS/SSL） |
| 后端 | Ruby / Java | Ruby（快速开发原型、适配日志采集 / 数据分析）；Java (大型分布式系统、生态成熟） |
| 前端 | Angular / TypeScript | 开发日志检索页、可视化仪表盘、配置界面（需掌握组件封装、状态管理、接口联调） |
| 分布式存储 | Elasticsearch / ClickHouse | Elasticsearch 核心存储 + 检索引擎（需掌握索引设计、分片策略、聚合查询、集群部署）；ClickHouse 更适合海量日志实时分析（写入性能优于 ES） |
| 消息队列 | Kafka/RabbitMQ | 日志缓冲（解耦采集端与存储端，应对峰值流量）；需掌握 Topic 设计、分区策略、消费组配置 |
| 云原生基础设施 | Kubernetes（K8s） | 平台部署与弹性扩展（支持容器化部署、自动扩缩容、滚动更新）；需掌握 Pod/Deployment/Service 配置、ConfigMap/Secret 管理 |
| 日志采集工具 | Fluentd/Fluent Bit/Filebeat | 多来源日志采集（应用日志、容器日志、服务器日志）；需掌握采集配置、数据解析（JSON / 正则）、输出到 Kafka/ES |
| 数据库 | PostgreSQL/MongoDB | 存储业务数据（用户信息、权限配置、告警规则、采集源配置）；需掌握事务、索引优化、分库分表（高并发场景） |

