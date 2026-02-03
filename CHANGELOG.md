# Changelog

All notable changes to the meta-6a skill will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-02-03

### Breaking Changes
- **框架重构**：从 6A 固定框架重构为 5A 核心框架 + 可选扩展模块架构
- **阶段重命名**：
  - `AIArtifact` → `AIBuild`（更清晰的动词命名）
  - `AIAdvise` → `AIImprove`（更清晰的动词命名）
- **AIAgent 变更**：从核心阶段移至 AI Agent 扩展模块

### Added
- **扩展模块系统**：支持按需加载领域特定扩展
  - **AIAgent 扩展**：AI Agent 项目专用，在 AIArchitect 和 AIBuild 之间插入
- **决策点明确化**：清晰定义何时加载 AIAgent 扩展的判断条件

### Changed
- **框架命名**：meta-6a 名称保持不变（历史兼容），但实际使用 5A 核心
- **触发词兼容**：现有所有触发词保持有效（"6A"等触发词仍可用）

### Migration Guide
从 v0.1.x 升级到 v0.2.0：
1. 核心流程从 6 阶段变为 5 阶段
2. AI Agent 项目会自动加载 AIAgent 扩展（相当于原第3阶段）
3. 现有触发词无需修改，继续有效
4. 工作流文件需要更新阶段名称（AIArtifact→AIBuild, AIAdvise→AIImprove）

## [0.1.1] - 2026-02-03

### Added
- **完整分析工作流**：创建了 `Workflows/full_analysis.md`，支持完整的 6A 框架分析
- **AIAgent 决策点**：明确定义了何时需要执行 AIAgent 阶段的判断逻辑
- **输出深度规范**：在 SKILL.md Quick Reference 中添加了三种输出深度的明确定义（简洁/详细/中等）
- **变更日志**：新增 `CHANGELOG.md` 文档记录版本历史
- **YAML Frontmatter**：为 SKILL.md 添加了标准的 YAML frontmatter

### Fixed
- **PAI Integration 格式**：更新到 PAI Algorithm v0.2.25 规范
  - 添加了所有 6 个 thinking tools 的评估模板
  - 添加了 justification（理由）字段
  - 更新了示例格式
- **触发词一致性**：统一了所有文档（SKILL.md、README.md、USAGE.md、quick_check.md）中的触发词定义
  - 快速验证：6个触发词（原3-5个不一致）
  - 完整分析：5个触发词（原2-3个不一致）
  - 框架说明：4个触发词（原2个）
- **文档一致性**：
  - 统一版本号为 0.1.1
  - 统一日期为 2026-02-03
  - 移除了错误的行数声明（USAGE.md）
  - 修正了文件路径硬编码问题

### Changed
- **6A 框架说明**：在 SKILL.md 中添加了 AIAgent 阶段的可选性说明
- **Quick Reference**：重新组织了输出格式说明，更清晰地区分三种模式
- **示例质量**：补充了技术选型、性能分析、安全审查等新示例场景（cases.md）

### Improved
- **文档专业度**：通过 CHANGELOG.md 提升了项目的专业性和可维护性
- **用户体验**：统一的触发词定义减少了用户困惑
- **PAI 集成**：符合最新规范的 THINKING TOOLS ASSESSMENT 格式

### Technical Debt Addressed
- 修复了 full_analysis.md 缺失导致的 P0 级别问题
- 修复了 PAI Integration 格式过时导致的集成问题
- 修复了触发词定义混乱导致的功能触发问题

## [0.1.0] - 2026-02-03

### Added
- **初始版本发布**
- **快速验证工作流**：`Workflows/quick_check.md` - 支持 <10 秒的快速验证
- **6A 思维框架**：定义了 6 个阶段的完整框架
- **5 个使用示例**：覆盖需求验证、设计验证、代码审查、项目规划、完整需求确认
- **核心文档**：
  - SKILL.md - 技能定义和路由
  - README.md - 使用说明
  - USAGE.md - 独立使用指南
  - examples/cases.md - 使用示例

### Design Decisions
- 采用轻量级设计（纯 prompt，无代码依赖）
- 默认简洁输出，可选深度分析
- 人类在环，提供建议而非强制执行
- 作为 PAI Algorithm 的 Thinking Tool 集成

---

## 版本说明

### 版本号规则
- **Major (主版本)**：不兼容的 API 变更或框架重构
- **Minor (次版本)**：向后兼容的功能新增
- **Patch (补丁版本)**：向后兼容的问题修复

### 当前状态
- v0.1.0 → v0.1.1：补丁版本，修复问题 + 小改进
- 下一个版本计划：v0.2.0（如果采纳框架重构建议）

### 预规划的 v0.2.0（未决定）
可能包含的重大变更：
- [ ] 重构为 5A 核心框架 + 可选扩展模块
- [ ] AIAgent 从核心阶段移至扩展模块
- [ ] 统一阶段命名为动词形式
- [ ] 增加详细设计阶段（AIDesign）

---

**维护者**: PAI (Personal AI Infrastructure)
**项目地址**: `~/.claude/skills/meta-6a/`
**最后更新**: 2026-02-03
