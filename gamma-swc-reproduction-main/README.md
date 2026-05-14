\# 伽马能谱法估算农田土壤含水量论文复现



\## 项目简介

本项目复现了Becker等人(2024)发表在Sensors期刊上的论文《Field Testing of Gamma-Spectroscopy Method for Soil Water Content Estimation in an Agricultural Field》，验证了伽马射线光谱法在农田尺度连续监测土壤含水量的可行性。



\## 数据说明

\- 数据来源：https://figshare.com/articles/dataset/Data\_From\_Gamma-Spectroscopy\_Method\_for\_Soil\_Water\_Content\_Estimation\_in\_an\_Agricultural\_Field/25723959

\- 数据格式：CSV

\- 主要变量：采样日期、40K计数率、重量法土壤含水量(g/g)、作物类型(玉米/大豆)



\## 文件结构

\- `data/raw/`：原始数据

\- `data/processed/`：清洗后的分析数据

\- `scripts/`：R分析脚本，按执行顺序编号

\- `results/figures/`：生成的结果图表

\- `report/report.qmd`：最终研究报告



\## 运行环境

\- R version: 4.4.0

\- 关键R包：tidyverse, lubridate, ggplot2



\## 作者

\@yuting-Mu @LQY123-Sketch @Zhang-ym-ing @xiaozz-zl @ZHGlory

