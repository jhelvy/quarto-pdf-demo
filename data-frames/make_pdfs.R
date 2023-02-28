# install.packages('nycflights13')
library(nycflights13)
library(dplyr)

# Render a pdf summarizing flights for each month
months <- sort(unique(flights$month))
flights <- flights %>%
    left_join(airlines, by = 'carrier')

for (i in months) {
    month <- month.name[i]
    delay_summary <- flights %>%
        filter(month == i, !is.na(dep_delay), !is.na(arr_delay)) %>%
        group_by(name) %>%
        summarise(
            mean_dep_delay = round(mean(dep_delay), 1),
            mean_arr_delay = round(mean(arr_delay), 1)
        )
    quarto::quarto_render(
        input = "template.qmd",
        output_format = "pdf",
        output_file = paste0(month, ".pdf"),
        execute_params = list(
            df = jsonlite::toJSON(delay_summary),
            month = month
        )
    )
}
