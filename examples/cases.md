# meta-6a Skill 使用示例索引

> 本文档是所有示例的索引，按场景分类展示。点击链接查看具体示例。

## 目录结构

```
examples/
├── cases.md              # 本文件：示例索引
├── backend/              # 后端开发场景
├── frontend/             # 前端开发场景
├── ai-agent/             # AI Agent 系统设计
└── common/               # 通用场景
```

---

## 所有示例快速浏览

**通用场景**（8 个示例）：
1. [需求验证](common/requirement.md) - 需求初期快速验证，识别不完整的关键点
2. [设计验证](common/design.md) - 技术方案可行性验证，缓存/数据库架构
3. [代码审查](common/code.md) - 代码质量检查，错误处理、参数验证
4. [项目规划](common/project.md) - 新项目 MVP 规划，分阶段实施
5. [完整需求确认](common/complete.md) - 成熟需求的快速确认，给出可执行信号
6. [技术选型验证](common/tech-stack.md) - 全栈技术选型，服务边界和数据流
7. [性能分析](common/performance.md) - 性能问题定位，数据库查询优化
8. [安全审查](common/security.md) - 安全漏洞识别，SQL 注入等严重风险

**后端开发**（1 个示例）：
9. [API 设计](backend/api-design.md) - REST API 规范设计，分页、搜索、认证

**前端开发**（1 个示例）：
10. [组件设计](frontend/component-design.md) - React 组件架构，状态管理、性能优化

**AI Agent 系统**（1 个示例）：
11. [Agent 系统设计](ai-agent/agent-system.md) - 智能客服 Agent，意图识别、知识库检索

---

## 通用场景 (Common)

| 示例 | 文件 | 描述 |
|------|------|------|
| 1. 快速验证需求 | [common/requirement.md](common/requirement.md) | 需求初期快速验证，识别不完整的关键点 |
| 2. 设计验证 | [common/design.md](common/design.md) | 技术方案可行性验证，缓存/数据库架构 |
| 3. 代码审查 | [common/code.md](common/code.md) | 代码质量检查，错误处理、参数验证 |
| 4. 项目规划 | [common/project.md](common/project.md) | 新项目 MVP 规划，分阶段实施 |
| 5. 完整需求确认 | [common/complete.md](common/complete.md) | 成熟需求的快速确认，给出可执行信号 |
| 6. 技术选型验证 | [common/tech-stack.md](common/tech-stack.md) | 全栈技术选型，服务边界和数据流 |
| 7. 性能分析 | [common/performance.md](common/performance.md) | 性能问题定位，数据库查询优化 |
| 8. 安全审查 | [common/security.md](common/security.md) | 安全漏洞识别，SQL 注入等严重风险 |

---

## 后端开发 (Backend)

| 示例 | 文件 | 描述 |
|------|------|------|
| 9. API 设计 | [backend/api-design.md](backend/api-design.md) | REST API 规范设计，分页、搜索、认证 |

---

## 前端开发 (Frontend)

| 示例 | 文件 | 描述 |
|------|------|------|
| 10. 组件设计 | [frontend/component-design.md](frontend/component-design.md) | React 组件架构，状态管理、性能优化 |

---

## AI Agent 系统 (AI Agent)

| 示例 | 文件 | 描述 |
|------|------|------|
| 11. Agent 系统设计 | [ai-agent/agent-system.md](ai-agent/agent-system.md) | 智能客服 Agent，意图识别、知识库检索 |

---

## 快速验证 vs 完整分析

### 快速验证（默认）

**优点**：
- 快速（< 10秒）
- 简洁（200词以内）
- 聚焦关键问题

**适用场景**：
- 日常对话中的快速检查
- 需求初步验证
- 获取第一印象

### 完整分析（可选）

**优点**：
- 全面（6A各阶段详细分析）
- 深入（具体建议和行动）
- 系统化（结构化思维框架）

**适用场景**：
- 重要项目决策
- 复杂系统设计
- 需要文档记录

**触发方式**：
- 用户明确说"完整6A分析"
- 用户说"deep-analysis"
- 或在快速验证后询问"需要详细分析吗？"

---

## 使用建议

1. **按场景查找**：根据当前开发阶段选择对应场景的示例
2. **学习结构**：每个示例都包含场景、用户输入、AI 输出、价值四部分
3. **复制复用**：可以直接复制示例中的对话模式到你的应用中
