---
name: meta-6a
version: 0.1.1
description: 6A思维框架验证与结构化分析. USE WHEN 需要结构化思维框架验证需求/设计/代码的完整性和可行性，或进行软件开发全生命周期的系统化分析. 与 FirstPrinciples（挑战假设）、Council（多代理辩论）不同，Meta6A 聚焦于结构化覆盖度验证. 支持快速验证和完整分析两种模式.
last_updated: 2026-02-03
---

# meta-6a Skill

## 6A思维框架

**核心思想**：通过6个阶段的结构化思维，提升AI输出的完整性、一致性和可行性。

**6个阶段**：
1. **AIAnalyze** - 分析现状、识别问题、明确边界
2. **AIArchitect** - 设计解决方案、规划架构、定义接口
3. **AIAgent** - [可选] 设计智能体、定义角色、规划交互
   > **决策点**：本项目是否需要设计 AI 智能体？
   > - 是（AI Agent 项目）→ 执行本阶段
   > - 否（其他项目）→ 跳过，直接进入 AIArtifact
4. **AIArtifact** - 构建产物、编写代码、生成文档
5. **AIApply** - 应用部署、集成测试、验证功能
6. **AIAdvise** - 持续优化、收集反馈、迭代改进

## 核心原则

- **轻量级**：纯 prompt 设计，无代码依赖
- **渐进式**：默认简洁输出，可选深度分析
- **可选验证**：提供检查清单，不强制执行
- **人类在环**：最终判断权归用户
- **自然语言**：避免术语，使用清晰表达

## Workflow Routing

| 用户输入 | 工作流 | 说明 | 输出深度 |
|---------|--------|------|----------|
| 快速验证触发词：<br>"验证6A" "检查6A" "6A检查" "meta-check" "验证一下" | `Workflows/quick_check.md` | 快速验证 | 简洁（< 200词，< 10秒） |
| 完整分析触发词：<br>"完整6A" "6A分析" "deep-analysis" "完整分析" "深度分析" | `Workflows/full_analysis.md` | 完整分析 | 详细（无限制，< 60秒） |
| 框架说明触发词：<br>"6A框架" "6A说明" "什么是6A" "6A是什么" | 内嵌 prompt（见下方框架介绍） | 框架介绍 | 中等（300-500词） |

## Quick Reference

**快速验证模式**（默认）：
- 输出：✅ 6A快速验证 + 关键洞察 + 下一步建议
- 深度：简洁（< 200词，聚焦关键问题和建议）
- 适用：日常对话中的快速检查、初步验证
- 时间：< 10秒
- 触发词："验证6A" "检查6A" "6A检查" "meta-check" "验证一下"

**完整分析模式**（可选）：
- 输出：完整的6A各阶段分析 + 详细建议 + 综合评分
- 深度：详细（无词数限制，全面覆盖所有阶段）
- 适用：复杂项目、重要决策、需要文档记录
- 时间：< 60秒
- 触发词："完整6A" "6A分析" "deep-analysis" "完整分析" "深度分析"

**框架说明模式**：
- 输出：6A框架介绍 + 使用场景 + 触发词说明
- 深度：中等（300-500词）
- 适用：首次使用或需要回顾框架
- 触发词："6A框架" "6A说明" "什么是6A" "6A是什么"

## Usage Examples

**场景1：快速验证需求**
```
User: 帮我验证一下这个需求："开发一个用户登录功能"
AI: [触发 quick_check]
     ✅ 6A快速验证
     📊 问题识别...
     🎯 关键建议...
     💡 下一步...
```

**场景2：完整分析**
```
User: 对这个项目做完整的6A分析
AI: [触发 full_analysis]
     [展开完整的6A各阶段分析]
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
- 强制执行所有6个阶段（应该按需使用）
- 使用大量术语和缩写（保持自然语言）
- 输出冗长的分析报告（默认简洁）
- 无视用户实际需求（灵活适配）

✅ **应该做**：
- 默认简洁，可选详细
- 使用清晰的表达
- 聚焦关键问题和建议
- 尊重用户选择

## Version History

- **v0.1.1** (2026-02-03):
  - 补充完整分析工作流（full_analysis.md）
  - 修复 PAI Integration 格式到 v0.2.25 规范
  - 统一触发词定义，消除文档不一致
  - 添加 AIAgent 阶段决策点定义
  - 添加输出深度规范（简洁/详细/中等）
  - 新增 CHANGELOG.md
- **v0.1.0** (2026-02-03): 初始版本，基于 Council 多代理辩论设计
