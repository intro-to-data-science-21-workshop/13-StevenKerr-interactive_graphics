library(plotly)
library(gapminder)

gapminder %>% 
  plot_ly(x = ~gdpPercap, y = ~lifeExp,
          hoverinfo = "text",
          text = ~paste("</br> Country: ", country,
                        "</br> GDP per capita: ", round(gdpPercap, 0),
                        "</br> Life Expectancy: ", lifeExp,
                        "</br> Population: ", round(pop/1000000, 0), " Mio")) %>% 
  add_text(x = 6500, y = 40, 
           text = ~year, frame = ~year,
           textfont = list(size = 150, 
                           color = toRGB("gray80"))) %>% 
  add_markers(size = ~pop, color = ~continent,
              frame = ~year, ids = ~country,
              marker = list(sizemode = "diameter")) %>% 
  layout(title = list(text = "GDP per capita vs. Life Expectancy from 1952 to 2007",
                      xanchor = "center",
                      x = 1000),
         xaxis = list(type = "log",
                      title = "GDP per capita"), 
         yaxis = list(type = "log",
                      title = "Life Expectancy at birth"),
         showlegend = FALSE) -> ani_plot

ani_plot %>% 
  animation_opts(frame = "500",
                 transition = "500",
                 easing = "linear",
                 redraw = TRUE) %>% 
  animation_slider(hide = TRUE)
