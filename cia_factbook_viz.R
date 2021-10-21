library(plotly)
library(crosstalk)
library(openintro)

shared_data <- SharedData$new(cia_factbook, 
                              key = ~country,
                              group = "Select a Country")

p1 <- shared_data %>% 
  plot_ly(x = ~population,
          y = ~internet_users,
          hoverinfo = "text",
          text = ~country) %>% 
  add_markers() %>% 
  layout(title = list(text = "Internet Users vs. Total Population",
                      xanchor = "center",
                      x = 1000),
         xaxis = list(type = "log",
                      title = "Population"), 
         yaxis = list(type = "log",
                      title = "Internet Users")) %>% 
  highlight(on = "plotly_click", 
            persistent = TRUE)

p2 <- shared_data %>% 
  plot_ly(x = ~population_growth_rate, 
          y = ~net_migration_rate,
          hoverinfo = "text",
          text = ~country) %>% 
  add_markers(color = "red") %>% 
  layout(title = "Population Growth vs Net Migration",
         xaxis = list(type = "log",
                      title = "Population Growth Rate"), 
         yaxis = list(type = "log",
                      title = "Net Migration Rate")) %>% 
  highlight(on = "plotly_click", 
            persistent = TRUE)

bscols(
  widths = c(2, 5, 5),
  list(
    filter_select(id = "countries", label = "Select a Country",
                  sharedData = shared_data, group = ~country),
    filter_slider(id = "birthslide", label = "Birth rate",
                 sharedData = shared_data, column = ~birth_rate),
    filter_slider(id = "deathslide", label = "Death rate",
                 sharedData = shared_data, column = ~death_rate)
    ),
  p1, 
  p2
)