library(shiny)
library(plotly)
library(finalProject)

# Define server logic required to draw a normal plot
server <- function(input, output) {
  
  output$distPlot <- renderPlotly({
    print(plotNormal(mu = input$mu,
                     sigma = input$sigma,
                     alpha = input$alpha,
                     obs = input$xbar,
                     direction = input$dir,
                     plotly=TRUE))
  })
  
  output$sampleDataDist <- renderPlotly(({
    
  }))
}