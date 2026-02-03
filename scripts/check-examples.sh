#!/bin/bash
# meta-6a Skill 示例验证脚本
# 版本：v0.1.1
# 用途：验证 examples/cases.md 中的示例质量

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 输出格式（默认 text，可选 json）
OUTPUT_FORMAT="text"

# 解析参数
while [[ $# -gt 0 ]]; do
    case $1 in
        --json)
            OUTPUT_FORMAT="json"
            shift
            ;;
        *)
            # 未知参数，忽略
            shift
            ;;
    esac
done

# 计数器
TOTAL_CHECKS=0
PASSED_CHECKS=0

# 打印函数
print_header() {
    if [[ "$OUTPUT_FORMAT" == "text" ]]; then
        echo -e "\n${BLUE}═══════════════════════════════════════════════════════════════${NC}"
        echo -e "${BLUE}$1${NC}"
        echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
    fi
}

print_section() {
    if [[ "$OUTPUT_FORMAT" == "text" ]]; then
        echo -e "\n${YELLOW}▶ $1${NC}\n"
    fi
}

print_check() {
    ((TOTAL_CHECKS++))
    if [ "$2" = "PASS" ]; then
        if [[ "$OUTPUT_FORMAT" == "json" ]]; then
            echo "{\"status\": \"pass\", \"check\": \"$1\"}"
        else
            echo -e "${GREEN}✓ [${TOTAL_CHECKS}]${NC} $1"
        fi
        ((PASSED_CHECKS++))
    elif [ "$2" = "WARN" ]; then
        if [[ "$OUTPUT_FORMAT" == "json" ]]; then
            echo "{\"status\": \"warn\", \"check\": \"$1\"}"
        else
            echo -e "${YELLOW}⚠ [${TOTAL_CHECKS}]${NC} $1"
        fi
    else
        if [[ "$OUTPUT_FORMAT" == "json" ]]; then
            echo "{\"status\": \"fail\", \"check\": \"$1\"}"
        else
            echo -e "${RED}✗ [${TOTAL_CHECKS}]${NC} $1"
        fi
    fi
}

# 获取路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(dirname "$SCRIPT_DIR")"
EXAMPLES_FILE="$SKILL_ROOT/examples/cases.md"

if [[ "$OUTPUT_FORMAT" == "text" ]]; then
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║        meta-6a Skill 示例验证 v0.1.1                         ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    print_header "示例质量验证"
    echo "示例文件: $EXAMPLES_FILE"
    echo "检查时间: $(date '+%Y-%m-%d %H:%M:%S')"
fi

if [ ! -f "$EXAMPLES_FILE" ]; then
    if [[ "$OUTPUT_FORMAT" == "json" ]]; then
        echo "{\"error\": \"示例文件不存在\"}"
    else
        echo -e "${RED}错误: 示例文件不存在${NC}"
    fi
    exit 1
fi

# ============================================================================
# 检查 1：示例数量
# ============================================================================
print_section "检查 1/5：示例数量"

EXAMPLE_COUNT=$(grep -c "^## 示例" "$EXAMPLES_FILE" || echo 0)
if [ $EXAMPLE_COUNT -ge 8 ]; then
    print_check "示例数量: $EXAMPLE_COUNT 个（≥ 8）" "PASS"
else
    print_check "示例数量: $EXAMPLE_COUNT 个（< 8，建议补充）" "FAIL"
fi

# ============================================================================
# 检查 2：示例结构
# ============================================================================
print_section "检查 2/5：示例结构完整性"

# 提取所有示例编号
EXAMPLE_NUMBERS=$(grep "^## 示例 [0-9]" "$EXAMPLES_FILE" | sed 's/.*示例 \([0-9]*\).*/\1/')

for num in $EXAMPLE_NUMBERS; do
    # 检查是否包含场景描述
    if grep -A 5 "^## 示例 $num" "$EXAMPLES_FILE" | grep -q "\*\*场景\*\*"; then
        print_check "示例 $num: 包含场景描述" "PASS"
    else
        print_check "示例 $num: 缺少场景描述" "FAIL"
    fi

    # 检查是否包含用户输入
    if grep -A 10 "^## 示例 $num" "$EXAMPLES_FILE" | grep -q "User:"; then
        print_check "示例 $num: 包含用户输入" "PASS"
    else
        print_check "示例 $num: 缺少用户输入" "FAIL"
    fi

    # 检查是否包含 AI 输出
    if grep -A 15 "^## 示例 $num" "$EXAMPLES_FILE" | grep -q "AI:"; then
        print_check "示例 $num: 包含 AI 输出" "PASS"
    else
        print_check "示例 $num: 缺少 AI 输出" "FAIL"
    fi

    # 检查 AI 输出是否包含 6A 快速验证格式
    if grep -A 20 "^## 示例 $num" "$EXAMPLES_FILE" | grep -q "✅ 6A快速验证"; then
        print_check "示例 $num: AI 输出格式正确" "PASS"
    else
        print_check "示例 $num: AI 输出格式可能不正确" "FAIL"
    fi
done

# ============================================================================
# 检查 3：触发词使用
# ============================================================================
print_section "检查 3/5：触发词使用规范性"

VALID_TRIGGERS=(验证6A 检查6A 6A检查 meta-check 验证一下 完整6A 6A分析 deep-analysis 完整分析 深度分析)

# 检查每个示例的用户输入是否使用有效的触发词
for num in $EXAMPLE_NUMBERS; do
    USER_INPUT=$(grep -A 10 "^## 示例 $num" "$EXAMPLES_FILE" | grep "User:" | sed 's/.*User: //')

    # 方法1：检查是否包含精确触发词
    has_valid_trigger=0
    for trigger in "${VALID_TRIGGERS[@]}"; do
        if echo "$USER_INPUT" | grep -q "$trigger"; then
            has_valid_trigger=1
            break
        fi
    done

    # 方法2：如果没有精确触发词，检查是否包含自然语言变体
    # 支持模式："帮我验证"、"检查这个"、"验证这个"、"对这个...做验证"等
    if [ $has_valid_trigger -eq 0 ]; then
        # 检查是否包含关键词组合：验证/检查 + 上下文词
        if echo "$USER_INPUT" | grep -qE "(验证|检查|6A)" && \
           echo "$USER_INPUT" | grep -qE "(这个|这段|这个项目|一下|需求|设计|代码)"; then
            has_valid_trigger=1
        fi
    fi

    if [ $has_valid_trigger -eq 1 ]; then
        print_check "示例 $num: 使用有效触发词" "PASS"
    else
        print_check "示例 $num: 未使用有效触发词" "FAIL"
    fi
done

# ============================================================================
# 检查 4：AI 输出格式
# ============================================================================
print_section "检查 4/5：AI 输出格式一致性"

# 快速验证格式的必需元素
QUICK_CHECK_ELEMENTS=("📊 问题识别" "🎯 关键建议" "💡 下一步行动")

for num in $EXAMPLE_NUMBERS; do
    AI_OUTPUT=$(sed -n "/^## 示例 $num/,/^## 示例 $((num+1))/p" "$EXAMPLES_FILE" | sed '1,/AI:/d')

    # 检查是否包含必需元素
    has_all_elements=1
    for element in "${QUICK_CHECK_ELEMENTS[@]}"; do
        if ! echo "$AI_OUTPUT" | grep -q "$element"; then
            has_all_elements=0
            break
        fi
    done

    if [ $has_all_elements -eq 1 ]; then
        print_check "示例 $num: AI 输出包含所有必需元素" "PASS"
    else
        print_check "示例 $num: AI 输出缺少必需元素" "FAIL"
    fi
done

# ============================================================================
# 检查 5：输出词数估算
# ============================================================================
print_section "检查 5/5：输出词数估算（快速验证 < 200 词）"

estimate_word_count() {
    # 简单估算：中文字符 + 英文单词
    echo "$1" | wc -w | awk '{print $1}'
}

for num in $EXAMPLE_NUMBERS; do
    AI_OUTPUT=$(sed -n "/^## 示例 $num/,/^## 示例 $((num+1))/p" "$EXAMPLES_FILE" | sed '1,/AI:/d')

    # 估算词数（粗略）
    WORD_COUNT=$(estimate_word_count "$AI_OUTPUT")

    if [ $WORD_COUNT -lt 250 ]; then  # 宽松阈值
        print_check "示例 $num: 输出词数约 $WORD_COUNT（< 250）" "PASS"
    else
        print_check "示例 $num: 输出词数约 $WORD_COUNT（≥ 250，可能超出快速验证限制）" "WARN"
    fi
done

# ============================================================================
# 场景覆盖度分析
# ============================================================================
print_section "场景覆盖度分析"

# 场景定义（使用普通数组以兼容 bash 3.x）
# 格式："场景名称|关键词1|关键词2|..."
SCENARIOS=(
    "需求验证|验证需求|需求验证|快速验证需求"
    "设计验证|设计验证|验证设计|技术选型验证"
    "代码审查|代码审查|审查代码|验证代码|代码质量"
    "项目规划|项目规划|规划项目|项目验证"
    "完整需求确认|完整需求|需求完整|需求已经很完整"
    "技术选型|技术选型|选型验证"
    "性能分析|性能分析|性能优化|响应时间|查询慢"
    "安全审查|安全审查|安全|漏洞|注入"
)

for scenario_entry in "${SCENARIOS[@]}"; do
    # 解析场景名称和关键词
    scenario_name=$(echo "$scenario_entry" | cut -d'|' -f1)
    keywords=$(echo "$scenario_entry" | cut -d'|' -f2- | sed 's/|/|/g')

    # 使用扩展正则表达式匹配关键词中的任意一个
    if grep -qE "$keywords" "$EXAMPLES_FILE"; then
        print_check "场景覆盖: $scenario_name" "PASS"
    else
        print_check "场景覆盖: $scenario_name（缺失）" "FAIL"
    fi
done

# ============================================================================
# 总结
# ============================================================================
if [[ "$OUTPUT_FORMAT" == "json" ]]; then
    # JSON 格式总结
    FAILED_CHECKS=$((TOTAL_CHECKS - PASSED_CHECKS))
    PASS_RATE=$((PASSED_CHECKS * 100 / TOTAL_CHECKS))
    echo "{\"total\": $TOTAL_CHECKS, \"passed\": $PASSED_CHECKS, \"failed\": $FAILED_CHECKS, \"pass_rate\": ${PASS_RATE}%}"
else
    # 文本格式总结
    print_header "验证总结"

    PASS_RATE=$((PASSED_CHECKS * 100 / TOTAL_CHECKS))

    echo -e "总检查数: ${TOTAL_CHECKS}"
    echo -e "${GREEN}通过: $PASSED_CHECKS${NC}"
    echo -e "${RED}失败: $((TOTAL_CHECKS - PASSED_CHECKS))${NC}"
    echo -e "通过率: ${PASS_RATE}%"

    if [ $PASS_RATE -ge 90 ]; then
        echo -e "\n${GREEN}🎉 示例质量优秀！（通过率 ≥ 90%）${NC}\n"
        exit 0
    elif [ $PASS_RATE -ge 70 ]; then
        echo -e "\n${YELLOW}⚠️  示例质量良好，但有改进空间（通过率 70-89%）${NC}\n"
        exit 0
    else
        echo -e "\n${RED}❌ 示例质量需要改进（通过率 < 70%）${NC}\n"
        exit 1
    fi
fi
