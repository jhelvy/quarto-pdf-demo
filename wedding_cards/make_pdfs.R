
# Render a pdf for each row in gifts.csv

gifts <- readr::read_csv("gifts.csv")

for (i in 1:nrow(gifts)) {
    row <- gifts[i,]
    output_path <- paste0(row$name, ".pdf")
    if (row$gift_cat == "money") {
        quarto::quarto_render(
            input = "template_money.qmd",
            output_format = "pdf",
            output_file = output_path,
            execute_params = list(name = row$name, gift = row$gift)
        )
    } else {
        quarto::quarto_render(
            input = "template_thing.qmd",
            output_format = "pdf",
            output_file = output_path,
            execute_params = list(name = row$name, gift = row$gift)
        )
    }
}
