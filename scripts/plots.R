library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

ann <- read_csv("annotation_summary.csv", show_col_types = FALSE)
gene_long <- ann %>%
  select(sample, n_CDS, n_rRNA, n_tRNA) %>%
  pivot_longer(-sample, names_to = "feature", values_to = "count")
p1 <- ggplot(gene_long, aes(x = sample, y = count, fill = feature)) +
  geom_col(position = "dodge", color = "black", alpha = 0.8) +
  coord_flip() +
  theme_minimal(base_size = 14) +
  labs(
    title = "Comparison of Gene and RNA Counts",
    x = "Pipeline (Assembly + Annotation)",
    y = "Count",
    fill = "Feature Type"
  )
p1

p2 <- ggplot(ann, aes(x = sample, y = frac_function, fill = sample)) +
  geom_col(color = "black", alpha = 0.8, show.legend = FALSE) +
  coord_flip() +
  scale_y_continuous(labels = scales::percent_format(), limits = c(0, 1)) +
  theme_minimal(base_size = 14) +
  labs(
    title = "Functional Annotation Coverage",
    subtitle = "Percentage of CDS with non-hypothetical functions",
    x = "Pipeline",
    y = "Functional Fraction"
  )

p2

p3 <- ggplot(ann, aes(x = n_contigs, y = frac_function, color = sample)) +
  geom_point(size = 6, alpha = 0.9) +
  theme_minimal(base_size = 14) +
  labs(
    title = "Impact of Assembly Fragmentation on Annotation",
    x = "Number of Contigs (Lower is better)",
    y = "Functional Fraction (Higher is better)"
  )
p3

p4 <- ggplot(ann, aes(x = sample, y = runtime_min, fill = sample)) +
  geom_col(color = "black", alpha = 0.8, show.legend = TRUE) +
  coord_flip() +
  theme_minimal(base_size = 14) +
  labs(
    title = "Runtime Efficiency",
    x = "Pipeline",
    y = "Runtime (Minutes)"
  )

p4

#the plot to compare SPAdes and Flye

#dataset using with exact QUAST results
assembly_data <- data.frame(
  Assembler = c("Flye", "SPAdes"),
  N50 = c(4947119, 1459399),
  Contigs = c(4, 15)
)

#data for plotting
assembly_long <- assembly_data %>%
  pivot_longer(cols = c(N50, Contigs), names_to = "Metric", values_to = "Value")


p_assembly <- ggplot(assembly_long, aes(x = Assembler, y = Value, fill = Assembler)) +
  geom_col(color = "black", alpha = 0.8, width = 0.6) +
  facet_wrap(~Metric, scales = "free_y") +
  scale_fill_manual(values = c("Flye" = "red", "SPAdes" = "blue")) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    strip.text = element_text(size = 14, face = "bold"),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5)
  ) +
  labs(
    title = "Assembly Contiguity Benchmarking",
    x = "Assembly Tool",
    y = "Metric Value"
  )

# Display the plot
print(p_assembly)

