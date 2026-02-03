# meta-6a v0.1.x to v0.2.0 Migration Guide

## Overview

v0.2.0 is a major version update featuring framework restructuring and scenario-based example organization.

## Major Changes

### 1. Framework Restructuring (6A to 5A Core)

**Before (v0.1.x)**:
- 6 core stages: AIAnalyze, AIArchitect, AIAgent, AIArtifact, AIApply, AIAdvise

**After (v0.2.0)**:
- 5 core stages: AIAnalyze, AIArchitect, AIBuild, AIApply, AIImprove
- Extension module: AIAgent (for AI Agent projects only)

**Impact**:
- Most projects unaffected (using core 5A)
- AI Agent projects require explicit AIAgent extension loading

### 2. Scenario-Based Example Organization

**Before**:
- All examples in single `examples/cases.md` file

**After**:
- `examples/cases.md` - Index file
- `examples/backend/` - Backend API examples
- `examples/frontend/` - Frontend component examples
- `examples/ai-agent/` - AI Agent system examples
- `examples/common/` - Common scenario examples

**Impact**:
- Original example content unchanged, only reorganized
- Easier to find domain-specific examples

### 3. New Medium Analysis Workflow

**Added**:
- `Workflows/medium_check.md` - Medium depth analysis (300-500 words)
- Trigger words: "6A检查" "medium-check" "中等分析"

## Backward Compatibility

### Maintained Compatibility
- All trigger words remain unchanged
- Quick check and full analysis modes unchanged
- Output format remains consistent

### Requires Adjustment
- Documentation mentioning "6A framework" should be updated to "5A core + extensions"
- AI Agent project examples should clarify AIAgent extension usage

## Migration Steps

### For Existing Users

#### Step 1: Update Local Skill
```bash
cd ~/.claude/skills/meta-6a
git pull origin main
```

#### Step 2: Check Compatibility
```bash
# Run quality check
./scripts/check-skill.sh

# Should see 100% pass rate
```

#### Step 3: Update Custom Content (if applicable)
If you modified:
- Custom workflows: Check if dependent on "AIAgent" stage
- Custom examples: Consider moving to appropriate scenario directory

### For Contributors

#### Step 1: Update Examples
```bash
# Move examples to corresponding directories
mv examples/cases.md examples/common/requirement.md
```

#### Step 2: Update Documentation
- Change "6A" to "5A"
- Change "AIArtifact" to "AIBuild"
- Change "AIAdvise" to "AIImprove"

#### Step 3: Run Checks
```bash
./scripts/check-skill.sh
./scripts/check-examples.sh
```

## FAQ

### Q1: Will my AI Agent projects be affected?

**A**: No. The framework still supports AIAgent, it's just moved from core stage to extension module.
- Old version: AIAgent stage executes automatically
- New version: Explicit decision point, load extension when project type = AI Agent

### Q2: Can I still use existing examples?

**A**: Yes. Example content is completely unchanged, only reorganized into different directories.

### Q3: Do I need to modify my code?

**A**: No. meta-6a is a pure prompt skill, no code modifications required.

### Q4: How to determine if I should use AIAgent extension?

**A**: Decision point:
```
Does this project require designing AI agents?
|-- Yes -> Load AIAgent extension
`-- No -> Proceed directly to AIBuild stage
```

## New Features

### Added in v0.2.0
1. **Medium analysis workflow** (medium_check.md)
2. **Script JSON output** (--json parameter)
3. **Scenario-based example grouping** (backend/frontend/ai-agent/common)

### Added in v0.1.2
1. **Backend API design examples**
2. **Frontend component design examples**
3. **AI Agent system design examples**

## Rollback Plan

If you encounter issues, rollback to v0.1.1:

```bash
cd ~/.claude/skills/meta-6a
git checkout v0.1.1
```

## Support

- **GitHub Issues**: https://github.com/starlink-awaken/meta-6a/issues
- **Documentation**: See README.md and USAGE.md

---

**Document Version**: 1.0
**Last Updated**: 2026-02-03
**Maintainer**: PAI (Personal AI Infrastructure)
