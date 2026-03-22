# Stock Monitor

## 项目目标
监控 A 股持仓，自动预警，生成 AI 分析建议，推送飞书通知，展示网页报表。

## 技术栈
- Python 3.11+，单进程
- FastAPI + APScheduler
- SQLite（本地存储）
- 单页 HTML 前端，不用框架

## 架构约束
系统有四个外部依赖，每个都必须通过 Adapter 抽象层访问，Core 层不得直接调用任何外部库：

- MarketAdapter：行情数据（当前实现：akshare）
- BrokerAdapter：持仓数据（当前实现：mock JSON 文件）
- NotifierAdapter：消息通知（当前实现：飞书 Webhook）
- StorageAdapter：持久化（当前实现：SQLite）

换实现时只改 adapters/ 目录，core/ 一行不动。

## 当前阶段
本地验证阶段。BrokerAdapter 使用 mock 数据，不接入真实券商。

## 禁止事项
- API Key 禁止硬编码，统一从环境变量读取
- core/ 目录禁止 import 任何 adapter 的具体实现
- 禁止在没有抽象接口的情况下直接调用外部服务
