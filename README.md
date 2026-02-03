# meta-6a Skill - README

> 轻量级 5A 核心框架 + 扩展模块的结构化思维验证 skill
>
> 版本：v0.2.0 | 基于 Council 多代理辩论设计

## 快速开始

### 安装

本 skill 已安装在：
```
~/.claude/skills/meta-6a/
```

### 使用方法

**方式1：快速验证（推荐）**
```
User: 验证6A [你的需求/设计/代码]
User: 检查6A [你的需求/设计/代码]
User: 6A检查 [你的需求/设计/代码]
User: meta-check [你的需求/设计/代码]
User: 验证一下 [你的需求/设计/代码]
```

**方式2：完整分析**
```
User: 完整6A分析 [你的项目]
User: deep-analysis [你的项目]
User: 完整分析 [你的项目]
User: 深度分析 [你的项目]
User: 6A框架 [查看说明]
```

## 核心特性

✅ **轻量级**：纯 prompt 设计，无代码依赖
✅ **渐进式**：默认简洁，可选详细
✅ **快速**：验证 < 10秒，分析 < 60秒
✅ **实用**：聚焦关键问题和建议

## 5A 核心框架

| 阶段 | 名称 | 目标 |
|------|------|------|
| 1 | AIAnalyze | 分析现状、识别问题、明确边界 |
| 2 | AIArchitect | 设计解决方案、规划架构、定义接口 |
| 3 | AIBuild | 构建产物、编写代码、生成文档 |
| 4 | AIApply | 应用部署、集成测试、验证功能 |
| 5 | AIImprove | 持续优化、收集反馈、迭代改进 |

### 扩展模块

**AIAgent 扩展**（AI Agent 项目专用）：

| 决策条件 | 操作 |
|---------|------|
| 项目类型 = AI Agent | 在 AIArchitect 和 AIBuild 之间插入 AIAgent 扩展 |
| 其他项目 | 使用标准 5A 核心流程 |

## 使用场景

### 场景1：需求验证
```
你: 验证6A "开发一个用户登录功能"
AI: [快速验证报告]
```

### 场景2：设计验证
```
你: 检查6A "使用 REST API + MongoDB + React"
AI: [快速验证报告]
```

### 场景3：代码审查
```
你: 6A检查 [你的代码]
Ai: [快速验证报告]
```

## 输出示例

```
✅ 5A快速验证

📊 问题识别
- 核心问题：[一句话]
- 完整性：[完整/不完整]
- 紧急程度：[高/中/低]
- 影响范围：[描述]

🎯 关键建议
1. [建议1]
2. [建议2]
3. [建议3]

💡 下一步行动
[具体行动]

⚠️ 风险提示
[如果有]
```

## 与 Phase 1 的关系

**重要变更**：本 skill 替代了之前设计的重量级 Phase 1 方案

| 维度 | Phase 1（已废弃） | meta-6a skill（当前） |
|------|-------------------|----------------------|
| 复杂度 | 重量级（引擎+代码） | 轻量级（纯prompt） |
| 实施时间 | 4周 | 1周 |
| 依赖 | TypeScript/Python | 无 |
| 维护成本 | 高 | 低 |
| 使用门槛 | 需要学习框架 | 即用即懂 |

## 设计原则（来自 Council）

基于四代理（Architect、Designer、Engineer、Researcher）的辩论共识：

1. **Thinking Tool 定位**（Researcher: Ava）
   - 注册到 PAI Algorithm THINK 阶段
   - 与 Council、FirstPrinciples 同级

2. **纯 Prompt 实现**（Engineer: Marcus）
   - 无需代码，SKILL.md + 工作流即可
   - 1周完成 MVP

3. **延迟验证**（Architect: Serena）
   - 提供建议而非强制执行
   - 人类在环，最终判断权归用户

4. **认知负荷优先**（Designer: Aditi）
   - 默认简洁输出
   - 可选展开详细

## 文件结构

```
meta-6a/
├── SKILL.md                    # 核心定义和路由
├── CHANGELOG.md                # 版本变更记录
├── Workflows/
│   ├── quick_check.md          # 快速验证工作流（默认）
│   └── full_analysis.md        # 完整分析工作流（可选）
├── examples/
│   └── cases.md                # 使用示例
├── scripts/
│   ├── check-skill.sh          # Skill 质量检查脚本
│   └── check-examples.sh       # 示例验证脚本
└── README.md                   # 本文档
```

## 质量检查脚本

meta-6a skill 包含自动化质量检查脚本，确保文件完整性和一致性。

### 可用脚本

**1. `scripts/check-skill.sh`** - Skill 质量检查

检查项目：
- ✅ 文件完整性（7 个必需文件）
- ✅ YAML Frontmatter 验证
- ✅ 触发词一致性（跨所有文档）
- ✅ PAI Integration 格式（v0.2.25）
- ✅ AIAgent 决策点定义
- ✅ 版本号一致性

**使用方法**：
```bash
cd /path/to/meta-6a
./scripts/check-skill.sh
```

**输出示例**：
```
═══════════════════════════════════════════════════════════════
meta-6a Skill 质量检查 v0.1.1
═══════════════════════════════════════════════════════════════
Skill 路径: /path/to/meta-6a
检查时间: 2026-02-03 12:00:00

▶ 检查 1/6：文件完整性

✓ PASS: 文件存在: SKILL.md
✓ PASS: 文件存在: README.md
...

▶ 检查 2/6：YAML Frontmatter
...

═══════════════════════════════════════════════════════════════
检查总结

通过: 25
警告: 2
失败: 0

🎉 所有关键检查通过！
```

**2. `scripts/check-examples.sh`** - 示例质量验证

检查项目：
- ✅ 示例数量（≥ 8 个）
- ✅ 示例结构完整性
- ✅ 触发词使用规范性
- ✅ AI 输出格式一致性
- ✅ 输出词数估算
- ✅ 场景覆盖度分析

**使用方法**：
```bash
cd /path/to/meta-6a
./scripts/check-examples.sh
```

**输出示例**：
```
═══════════════════════════════════════════════════════════════
示例质量验证
═══════════════════════════════════════════════════════════════
示例文件: /path/to/meta-6a/examples/cases.md

▶ 检查 1/5：示例数量
✓ [1] 示例数量: 8 个（≥ 8）

▶ 检查 2/5：示例结构完整性
✓ [2] 示例 1: 包含场景描述
✓ [3] 示例 1: 包含用户输入
...

═══════════════════════════════════════════════════════════════
验证总结

总检查数: 45
通过: 43
失败: 2
通过率: 95%

🎉 示例质量优秀！（通过率 ≥ 90%）
```

### 集成到 CI/CD

推荐在以下情况运行检查脚本：

1. **提交前**：确保本地修改不破坏 skill 质量
2. **Pull Request**：作为 CI 检查的一部分
3. **发布前**：全面验证 skill 状态

**GitHub Actions 示例**：
```yaml
name: Skill Quality Check

on: [push, pull_request]

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Check Skill Quality
        run: ./scripts/check-skill.sh
      - name: Check Examples
        run: ./scripts/check-examples.sh
```

### 自定义检查

你可以修改脚本以适应特定需求：

- 添加新的检查项
- 调整阈值（如示例数量、词数限制）
- 修改输出格式
- 集成其他工具（如 linter、formatter）

---

## 反馈与改进

### 如何反馈

如果 skill 有问题或建议：
1. 在对话中说明问题
2. 提供具体场景
3. 建议改进方向

### 自定义

用户可以：
- 修改 `Workflows/*.md` 调整输出格式
- 在 `examples/` 添加新示例
- 适应特定领域的 6A 工作流
- 扩展 `scripts/*.sh` 添加自定义检查

## 版本历史

- **v0.2.0** (2026-02-03):
  - **[BREAKING]** 重构为 5A 核心框架 + 扩展模块架构
  - AIArtifact 重命名为 AIBuild
  - AIAdvise 重命名为 AIImprove
  - AIAgent 从核心阶段移至 AI Agent 扩展模块
  - 保持向后兼容：现有触发词继续有效
- **v0.1.1** (2026-02-03):
  - 补充完整分析工作流（full_analysis.md）
  - 修复 PAI Integration 格式到 v0.2.25 规范
  - 统一触发词定义
  - 添加 AIAgent 决策点定义
  - 添加输出深度规范
  - 新增 CHANGELOG.md
- **v0.1.0** (2026-02-03): 初始版本，基于 Council 多代理辩论设计

## 许可证

MIT License

---

**创建者**: PAI (Personal AI Infrastructure)
**设计方法**: Council 多代理辩论
**工作目录**: `/Users/xiamingxing/.claude/skills/meta-6a/`
