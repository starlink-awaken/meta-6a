---
name: meta-6a
version: 0.2.1
description: 5A核心框架+扩展模块的结构化思维验证. USE WHEN 需要结构化思维框架验证需求/设计/代码的完整性和可行性，或进行软件开发全生命周期的系统化分析. 与 FirstPrinciples（挑战假设）、Council（多代理辩论）不同，Meta6A 聚焦于结构化覆盖度验证. 核心框架包含5个阶段，支持按需加载扩展模块（如AIAgent）. 支持快速验证、中等分析和完整分析三种模式.
last_updated: 2026-02-03
---

# meta-6a Skill

## 命名说明

> **"meta-6a" 是历史名称，实际框架是 5A 核心**

**为什么叫 meta-6a？**
- 初始设计（v0.1.0）包含 6 个阶段：AIAnalyze、AIArchitect、AIAgent、AIArtifact、AIApply、AIAdvise
- v0.2.0 重构为 **5A 核心框架** + 可选扩展模块架构
- AIAgent 从核心阶段移至 AI Agent 扩展模块
- AIArtifact → AIBuild（更清晰的动词命名）
- AIAdvise → AIImprove（更清晰的动词命名）

**为什么保持 meta-6a 名称？**
- 向后兼容：现有触发词（"6A检查"等）继续有效
- 避免混淆：v0.2.0 已经是 breaking change，不改名减少用户困扰
- 语义保留："6A" 代表完整框架（5A 核心 + AIAgent 扩展 = 6 个 A）

**实际使用**：
- 大多数项目使用 **5A 核心**（AIAnalyze、AIArchitect、AIBuild、AIApply、AIImprove）
- AI Agent 项目使用 **5A + AIAgent 扩展**（相当于原来的 6A）

---

## 5A 核心框架 + 扩展模块

**核心思想**：通过 5 个核心阶段的结构化思维，提升 AI 输出的完整性、一致性和可行性。支持领域扩展模块按需加载。

### 5A 核心阶段

| 阶段 | 名称 | 目标 |
|------|------|------|
| 1 | **AIAnalyze** | 分析现状、识别问题、明确边界 |
| 2 | **AIArchitect** | 设计解决方案、规划架构、定义接口 |
| 3 | **AIBuild** | 构建产物、编写代码、生成文档 |
| 4 | **AIApply** | 应用部署、集成测试、验证功能 |
| 5 | **AIImprove** | 持续优化、收集反馈、迭代改进 |

### 扩展模块

**AIAgent 扩展**（AI Agent 项目专用）：

> **决策点**：本项目是否需要设计 AI 智能体？
>
> **满足以下任一条件** → 插入 AIAgent 扩展：
> - ✅ 项目涉及 LLM API 调用（ChatGPT、Claude、GPT-4 等）
> - ✅ 需要设计 Agent 角色（如"代码审查 Agent"、"客服 Agent"）
> - ✅ 需要定义 Agent 能力和工具（如"Agent 可以访问文件系统"、"Agent 可以执行代码"）
> - ✅ 需要规划 Agent 交互模式（如"多 Agent 协作"、"Agent 人类协作"）
> - ✅ 用户明确提到"AI Agent"、"智能体"、"多代理系统"
>
> **否则** → 使用标准 5A 核心流程

**AIAgent 扩展内容**：
- 设计智能体角色和职责
- 定义智能体能力和工具
- 规划智能体交互模式

## 核心原则

- **轻量级**：纯 prompt 设计，无代码依赖
- **渐进式**：默认简洁输出，可选深度分析
- **可选验证**：提供检查清单，不强制执行
- **人类在环**：最终判断权归用户
- **自然语言**：避免术语，使用清晰表达

## Workflow Routing

| 用户输入 | 工作流 | 说明 | 输出深度 |
|---------|--------|------|----------|
| 快速验证触发词：<br>"验证6A" "检查6A" "meta-check" "验证一下" | `Workflows/quick_check.md` | 快速验证 | 简洁（< 200词，< 10秒） |
| 中等分析触发词：<br>"6A检查" "medium-check" "中等分析" | `Workflows/medium_check.md` | 中等深度分析 | 中等（300-500词，< 30秒） |
| 完整分析触发词：<br>"完整6A" "6A分析" "deep-analysis" "完整分析" "深度分析" | `Workflows/full_analysis.md` | 完整分析 | 详细（无限制，< 60秒） |
| 框架说明触发词：<br>"6A框架" "6A说明" "什么是6A" "6A是什么" | 内嵌 prompt（见下方框架介绍） | 框架介绍 | 中等（300-500词） |

## Quick Reference

**快速验证模式**（默认）：
- 输出：✅ 5A快速验证 + 关键洞察 + 下一步建议
- 深度：简洁（< 200词，聚焦关键问题和建议）
- 适用：日常对话中的快速检查、初步验证
- 时间：< 10秒
- 触发词："验证6A" "检查6A" "6A检查" "meta-check" "验证一下"

**中等分析模式**（日常深入）：
- 输出：✅ 5A中等分析 + 问题分析 + 关键阶段分析（2-3个）+ 综合建议
- 深度：中等（300-500词，平衡简洁和详细）
- 适用：需要比快速验证更深入，但不需要完整分析的场景
- 时间：< 30秒
- 触发词："6A检查" "medium-check" "中等分析"

**完整分析模式**（可选）：
- 输出：完整的5A各阶段分析（或5A+扩展）+ 详细建议 + 综合评分
- 深度：详细（无词数限制，全面覆盖所有阶段）
- 适用：复杂项目、重要决策、需要文档记录
- 时间：< 60秒
- 触发词："完整6A" "6A分析" "deep-analysis" "完整分析" "深度分析"

**框架说明模式**：
- 输出：5A核心框架介绍 + 扩展模块说明 + 使用场景 + 触发词说明
- 深度：中等（300-500词）
- 适用：首次使用或需要回顾框架
- 触发词："6A框架" "6A说明" "什么是6A" "6A是什么"

## Usage Examples

**场景1：快速验证需求**
```
User: 帮我验证一下这个需求："开发一个用户登录功能"
AI: [触发 quick_check]
     ✅ 5A快速验证
     📊 问题识别...
     🎯 关键建议...
     💡 下一步...
```

**场景2：完整分析**
```
User: 对这个项目做完整的6A分析
AI: [触发 full_analysis]
     [展开完整的5A各阶段分析，或5A+扩展]
```

## Quality Gates (Optional)

在思考阶段（THINK），AI 会自动评估：
- 是否需要应用6A思维框架
- 当前问题是否适合用6A分析
- 应该使用快速验证还是完整分析

## Integration with PAI Algorithm

本 skill 设计为 **Thinking Tool**，在 PAI Algorithm 的 THINK 阶段被评估：

```
🔍 **THINKING TOOLS ASSESSMENT** (justify exclusion):
│ Council:          EXCLUDE — 单个清晰的分析任务，无需多代理辩论
│ RedTeam:          EXCLUDE — 无需压力测试的方案或假设
│ FirstPrinciples:  INCLUDE — 当需要从第一性原理验证框架设计时
│ Science:          EXCLUDE — 非迭代实验任务
│ BeCreative:       EXCLUDE — 分析任务无需发散性思考
│ Prompting:        EXCLUDE — 非提示词生成任务
│ Meta6A:           INCLUDE — 需要结构化思维框架验证完整性/可行性时
```

**何时使用 Meta6A**：
- 验证需求、设计、代码的完整性
- 进行结构化问题分析
- 需要系统性思维框架覆盖开发全生命周期
- 检查是否遗漏关键阶段或决策点

**与其他 Thinking Tools 的关系**：
- **Meta6A → FirstPrinciples**：先用 Meta6A 发现完整性问题，再用 FirstPrinciples 深挖假设
- **Meta6A → Council**：先用 Meta6A 验证覆盖度，再用 Council 权衡多个方案
- **Meta6A → RedTeam**：先用 Meta6A 构建完整方案，再用 RedTeam 压力测试

## Customization

用户可以创建自定义检查清单或示例：

1. 在 `examples/` 目录添加案例
2. 修改 `Workflows/*.md` 调整输出格式
3. 添加领域特定的 6A 适配

## Anti-Patterns (避免)

❌ **不要做**：
- 强制执行所有5个阶段（应该按需使用）
- 强制加载扩展模块（仅在项目类型匹配时使用）
- 使用大量术语和缩写（保持自然语言）
- 输出冗长的分析报告（默认简洁）
- 无视用户实际需求（灵活适配）

✅ **应该做**：
- 默认简洁，可选详细
- 使用清晰的表达
- 聚焦关键问题和建议
- 尊重用户选择

## Version History

- **v0.2.0** (2026-02-03):
  - **[BREAKING]** 重构为 5A 核心框架 + 扩展模块架构
  - AIArtifact 重命名为 AIBuild（更清晰的动词命名）
  - AIAdvise 重命名为 AIImprove（更清晰的动词命名）
  - AIAgent 从核心阶段移至 AI Agent 扩展模块
  - 保持向后兼容：现有触发词继续有效
- **v0.1.1** (2026-02-03):
  - 补充完整分析工作流（full_analysis.md）
  - 修复 PAI Integration 格式到 v0.2.25 规范
  - 统一触发词定义，消除文档不一致
  - 添加 AIAgent 阶段决策点定义
  - 添加输出深度规范（简洁/详细/中等）
  - 新增 CHANGELOG.md
- **v0.1.0** (2026-02-03): 初始版本，基于 Council 多代理辩论设计
