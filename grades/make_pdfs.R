
# Render a single pdf with default values for params

quarto::quarto_render(
    input = "template.qmd",
    output_format = "pdf",
    output_file = "template.pdf"
)

# Render a pdf for each row in grades.csv

grades <- readr::read_csv("grades.csv")

for (i in 1:nrow(grades)) {
    row <- grades[i,]
    output_path <- file.path("pdf", paste0(row$assignment, " ", row$name, ".pdf"))
    quarto::quarto_render(
        input = "template.qmd",
        output_format = "pdf",
        output_file = output_path,
        execute_params = list(
            name       = row$name,
            assignment = row$assignment,
            grade      = row$grade,
            feedback   = row$feedback
        )
    )
}
