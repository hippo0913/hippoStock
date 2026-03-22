# 变更记录

## 规划阶段 - 项目启动
- 确定技术方案：Python 单进程，Adapter 模式
- 确定里程碑拆分
- 初始化项目文档（CLAUDE.md / PROGRESS.md / DECISIONS.md）
- 禁止使用 os.environ 读取配置，统一从 _config/cfg.json 读取