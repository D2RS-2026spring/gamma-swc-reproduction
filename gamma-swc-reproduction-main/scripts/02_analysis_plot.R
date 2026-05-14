# 脚本2：用真实数据生成论文核心图表（解决NA问题）
library(tidyverse)
library(ggplot2)
library(broom)

# ---------------------- 1. 加载清洗后的真实数据 ----------------------
cal_k40 <- read_csv("data/processed/cal_k40_clean.csv", show_col_types = FALSE)

# 打印数据基本信息
cat("=== 加载清洗后的数据成功！ ===\n")
cat("数据行数：", nrow(cal_k40), "\n")
cat("列名：", colnames(cal_k40), "\n")
cat("k40_counts列类型：", class(cal_k40$k40_counts), "\n")

# ---------------------- 2. 生成40K计数率的描述性统计（论文表1） ----------------------
desc_stats <- cal_k40 %>%
  summarise(
    最小值 = min(k40_counts, na.rm = TRUE),
    最大值 = max(k40_counts, na.rm = TRUE),
    平均值 = mean(k40_counts, na.rm = TRUE),
    标准差 = sd(k40_counts, na.rm = TRUE),
    中位数 = median(k40_counts, na.rm = TRUE)
  ) %>%
  round(2)

# 保存描述性统计结果
if (!dir.exists("results/tables")) {
  dir.create("results/tables", recursive = TRUE)
}
write_csv(desc_stats, "results/tables/k40_descriptive_stats.csv")

# ---------------------- 3. 生成40K计数率的时间序列图 ----------------------
cal_k40 <- cal_k40 %>%
  mutate(
    base_date = as.Date(paste0(Year, "-01-01")),
    date = base_date + days(DOY - 1)
  )

p1 <- ggplot(cal_k40, aes(x = date, y = k40_counts)) +
  geom_line(color = "#1f77b4", linewidth = 0.8) +
  geom_point(color = "#1f77b4", size = 1.5, alpha = 0.7) +
  labs(
    title = "40K计数率时间序列变化",
    x = "日期",
    y = "40K计数率（次/分钟）",
    caption = "数据来源：论文原始数据"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# 保存图表
if (!dir.exists("results/figures")) {
  dir.create("results/figures", recursive = TRUE)
}
ggsave("results/figures/k40_timeseries.png", p1, width = 10, height = 6, dpi = 300)

# ---------------------- 4. 生成40K计数率的分布直方图 ----------------------
p2 <- ggplot(cal_k40, aes(x = k40_counts)) +
  geom_histogram(bins = 15, fill = "#1f77b4", color = "white", alpha = 0.7) +
  labs(
    title = "40K计数率分布直方图",
    x = "40K计数率（次/分钟）",
    y = "频数",
    caption = "数据来源：论文原始数据"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("results/figures/k40_histogram.png", p2, width = 8, height = 6, dpi = 300)

# ---------------------- 5. 输出成功提示 ----------------------
cat("\n✅ 分析和作图完成！\n")
cat("已生成：\n")
cat("- results/tables/k40_descriptive_stats.csv（40K计数率描述性统计）\n")
cat("- results/figures/k40_timeseries.png（40K计数率时间序列图）\n")
cat("- results/figures/k40_histogram.png（40K计数率分布直方图）\n")
cat("\n描述性统计结果：\n")
print(desc_stats)