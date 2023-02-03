library(readr)

# Render a single pdf with default values for params

quarto::quarto_render(
    input = "demo.qmd",
    output_format = "pdf",
    output_file = "demo.pdf"
)

# Render a pdf for each row in grades.csv

grades <- read_csv("grades.csv")

for (i in 1:nrow(grades)) {
    row <- grades[i,]
    output_path <- file.path("pdf", paste0(row$name, " ", row$assignment, ".pdf"))
    quarto::quarto_render(
        input = "demo.qmd",
        output_format = "pdf",
        execute_params = list(
            name       = row$name,
            assignment = row$assignment,
            grade      = row$grade
        ),
        output_file = output_path
    )
}

