# 脚本1：导入论文真实原始数据并清洗（强制转换数值型，解决NA问题）
library(tidyverse)
library(lubridate)
library(ggplot2)

# ---------------------- 1. 导入真实数据 ----------------------
cal_k40 <- read_csv("data/raw/CalibrationDataK40.csv", show_col_types = FALSE)

# 打印数据基本信息
cat("=== 数据导入成功！列名如下 ===\n")
print(colnames(cal_k40))
cat("\n=== 数据前3行 ===\n")
print(head(cal_k40, 3))

# ---------------------- 2. 数据清洗（核心：强制转换为数值型） ----------------------
cal_k40_clean <- cal_k40 %>%
  # 重命名列
  rename(
    row_index = ...1,
    k40_counts = K,
    k40_sd = sd
  ) %>%
  # 强制转换为数值型（解决字符型问题）
  mutate(
    k40_counts = as.numeric(k40_counts),
    k40_sd = as.numeric(k40_sd),
    Year = as.numeric(Year),
    DOY = as.numeric(DOY)
  ) %>%
  # 去除异常值和缺失值
  filter(k40_counts > 0) %>%
  drop_na(k40_counts) %>%
  # 只保留需要的列
  select(k40_counts, k40_sd, Year, DOY)

# ---------------------- 3. 保存清洗后的数据 ----------------------
if (!dir.exists("data/processed")) {
  dir.create("data/processed", recursive = TRUE)
}

write_csv(cal_k40_clean, "data/processed/cal_k40_clean.csv")

# 输出成功提示
cat("\n✅ 数据清洗完成！\n")
cat("原始数据行数：", nrow(cal_k40), "\n")
cat("清洗后数据行数：", nrow(cal_k40_clean), "\n")
cat("k40_counts列类型：", class(cal_k40_clean$k40_counts), "\n")
cat("已保存到：data/processed/cal_k40_clean.csv\n")