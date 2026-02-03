#!/bin/bash
# meta-6a Skill 质量检查脚本
# 版本：v0.1.1
# 用途：自动化检查 skill 的完整性、一致性和格式正确性

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 计数器
FAILURES=0
PASSES=0
WARNINGS=0

# 打印函数
print_header() {
    echo -e "\n${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
}

print_section() {
    echo -e "\n${YELLOW}▶ $1${NC}\n"
}

print_pass() {
    echo -e "${GREEN}✓ PASS${NC}: $1"
    ((PASSES++))
}

print_fail() {
    echo -e "${RED}✗ FAIL${NC}: $1"
    ((FAILURES++))
}

print_warn() {
    echo -e "${YELLOW}⚠ WARN${NC}: $1"
    ((WARNINGS++))
}

# 获取脚本所在目录的父目录（skill 根目录）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${BLUE}"
echo "██╗      ██████╗ ███████╗████████╗███████╗██████╗ ███╗   ███╗"
echo "██║     ██╔═══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║"
echo "██║     ██║   ██║███████╗   ██║   █████╗  ██║  ██║██╔████╔██║"
echo "██║     ██║   ██║╚════██║   ██║   ██╔══╝  ██║  ██║██║╚██╔╝██║"
echo "███████╗╚██████╔╝███████║   ██║   ███████╗██████╔╝██║ ╚═╝ ██║"
echo "╚══════╝ ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝╚═════╝ ╚═╝     ╚═╝"
echo -e "${NC}"
print_header "meta-6a Skill 质量检查 v0.1.1"
echo "Skill 路径: $SKILL_ROOT"
echo "检查时间: $(date '+%Y-%m-%d %H:%M:%S')"

# ============================================================================
# 检查 1：文件完整性
# ============================================================================
print_section "检查 1/6：文件完整性"

REQUIRED_FILES=(
    "SKILL.md"
    "README.md"
    "USAGE.md"
    "CHANGELOG.md"
    "Workflows/quick_check.md"
    "Workflows/full_analysis.md"
    "examples/cases.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$SKILL_ROOT/$file" ]; then
        print_pass "文件存在: $file"
    else
        print_fail "文件缺失: $file"
    fi
done

# ============================================================================
# 检查 2：YAML Frontmatter 验证
# ============================================================================
print_section "检查 2/6：YAML Frontmatter"

SKILL_FILE="$SKILL_ROOT/SKILL.md"
if [ -f "$SKILL_FILE" ]; then
    # 检查 frontmatter 存在
    if grep -q "^---$" "$SKILL_FILE"; then
        print_pass "SKILL.md 包含 YAML frontmatter"

        # 检查必需字段
        if grep -q "^name: meta-6a" "$SKILL_FILE"; then
            print_pass "name 字段正确"
        else
            print_fail "name 字段缺失或错误"
        fi

        if grep -q "^version: 0\.1\.1" "$SKILL_FILE"; then
            print_pass "version 字段为 0.1.1"
        else
            VERSION=$(grep "^version:" "$SKILL_FILE" | cut -d' ' -f2)
            print_warn "version 字段为 $VERSION（期望 0.1.1）"
        fi

        if grep -q "^description:" "$SKILL_FILE"; then
            print_pass "description 字段存在"

            # 检查 USE WHEN
            if grep -q "^description:.*USE WHEN" "$SKILL_FILE"; then
                print_pass "description 包含 USE WHEN"
            else
                print_warn "description 缺少 USE WHEN 声明"
            fi
        else
            print_fail "description 字段缺失"
        fi

        if grep -q "^last_updated:" "$SKILL_FILE"; then
            print_pass "last_updated 字段存在"
        else
            print_warn "last_updated 字段缺失"
        fi
    else
        print_fail "SKILL.md 缺少 YAML frontmatter（--- 开头和结尾）"
    fi
else
    print_fail "SKILL.md 文件不存在"
fi

# ============================================================================
# 检查 3：触发词一致性
# ============================================================================
print_section "检查 3/6：触发词一致性"

# 从 SKILL.md 提取声明的触发词
QUICK_CHECK_TRIGGERS_SKILL=$(grep -A 1 "快速验证触发词：" "$SKILL_ROOT/SKILL.md" | grep '"' | sed 's/.*"\(.*\)".*/\1/' | tr '\n' ' ')
FULL_ANALYSIS_TRIGGERS_SKILL=$(grep -A 1 "完整分析触发词：" "$SKILL_ROOT/SKILL.md" | grep '"' | sed 's/.*"\(.*\)".*/\1/' | tr '\n' ' ')

# 验证每个文档中的触发词
check_document_triggers() {
    local doc=$1
    local doc_name=$(basename "$doc")

    # 检查是否包含快速验证触发词
    found_quick=0
    for trigger in 验证6A 检查6A 6A检查 meta-check 验证一下; do
        if grep -q "$trigger" "$doc" 2>/dev/null; then
            ((found_quick++))
        fi
    done

    if [ $found_quick -ge 3 ]; then
        print_pass "$doc_name 包含快速验证触发词（$found_quick/5）"
    else
        print_warn "$doc_name 快速验证触发词不完整（$found_quick/5）"
    fi

    # 检查是否包含完整分析触发词
    found_full=0
    for trigger in 完整6A 6A分析 deep-analysis 完整分析 深度分析; do
        if grep -q "$trigger" "$doc" 2>/dev/null; then
            ((found_full++))
        fi
    done

    if [ $found_full -ge 3 ]; then
        print_pass "$doc_name 包含完整分析触发词（$found_full/5）"
    else
        print_warn "$doc_name 完整分析触发词不完整（$found_full/5）"
    fi
}

check_document_triggers "$SKILL_ROOT/README.md"
check_document_triggers "$SKILL_ROOT/USAGE.md"
check_document_triggers "$SKILL_ROOT/Workflows/quick_check.md"

# ============================================================================
# 检查 4：PAI Integration 格式
# ============================================================================
print_section "检查 4/6：PAI Integration 格式（v0.2.25）"

PAI_INTEGRATION_SECTION="$SKILL_ROOT/SKILL.md"
if grep -q "THINKING TOOLS ASSESSMENT" "$PAI_INTEGRATION_SECTION"; then
    print_pass "包含 THINKING TOOLS ASSESSMENT"

    # 检查所有必需的 thinking tools
    REQUIRED_TOOLS=("Council:" "RedTeam:" "FirstPrinciples:" "Science:" "BeCreative:" "Prompting:" "Meta6A:")
    for tool in "${REQUIRED_TOOLS[@]}"; do
        if grep -q "$tool" "$PAI_INTEGRATION_SECTION"; then
            print_pass "包含 $tool"
        else
            print_fail "缺少 $tool"
        fi
    done

    # 检查 justify exclusion 格式
    if grep -q "(justify exclusion):" "$PAI_INTEGRATION_SECTION"; then
        print_pass "包含 (justify exclusion) 格式"
    else
        print_fail "缺少 (justify exclusion) 格式"
    fi
else
    print_fail "缺少 THINKING TOOLS ASSESSMENT 部分"
fi

# ============================================================================
# 检查 5：AIAgent 决策点定义
# ============================================================================
print_section "检查 5/6：AIAgent 决策点定义"

if grep -q "决策点" "$SKILL_ROOT/SKILL.md"; then
    print_pass "SKILL.md 包含决策点定义"

    # 检查是否在 AIAgent 阶段
    if grep -B 5 "AIAgent" "$SKILL_ROOT/SKILL.md" | grep -q "决策点"; then
        print_pass "决策点定义在 AIAgent 阶段附近"
    else
        print_warn "决策点定义位置可能不正确"
    fi
else
    print_fail "缺少 AIAgent 决策点定义"
fi

# ============================================================================
# 检查 6：版本号一致性
# ============================================================================
print_section "检查 6/6：版本号一致性"

check_version() {
    local file=$1
    local file_name=$(basename "$file")

    if grep -q "v0\.1\.1\|version: 0\.1\.1\|版本：v0.1.1" "$file"; then
        print_pass "$file_name 版本号为 0.1.1"
    elif grep -q "v0\.1\.0\|version: 0\.1\.0" "$file"; then
        print_fail "$file_name 版本号为 0.1.0（应为 0.1.1）"
    else
        print_warn "$file_name 版本号未明确声明"
    fi
}

check_version "$SKILL_ROOT/SKILL.md"
check_version "$SKILL_ROOT/README.md"
check_version "$SKILL_ROOT/USAGE.md"
check_version "$SKILL_ROOT/CHANGELOG.md"

# 检查日期一致性
if grep -q "2026-02-03" "$SKILL_ROOT/SKILL.md" "$SKILL_ROOT/README.md" "$SKILL_ROOT/USAGE.md"; then
    print_pass "日期一致（2026-02-03）"
else
    print_warn "日期可能不一致"
fi

# ============================================================================
# 总结
# ============================================================================
print_header "检查总结"

echo -e "${GREEN}通过: $PASSES${NC}"
echo -e "${YELLOW}警告: $WARNINGS${NC}"
echo -e "${RED}失败: $FAILURES${NC}"

if [ $FAILURES -eq 0 ]; then
    echo -e "\n${GREEN}🎉 所有关键检查通过！${NC}\n"
    exit 0
else
    echo -e "\n${RED}❌ 发现 $FAILURES 个问题，请修复后重试${NC}\n"
    exit 1
fi
