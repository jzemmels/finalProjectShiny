library(shiny)
library(plotly)
library(finalProject)

# Define server logic required to draw a normal plot
means <- data.frame() #initialize an emtpy data frame to be reactively updated with sample means
sample <- data.frame()

server <- function(input, output) {
  
  output$distPlot <- renderPlotly({ #Server logic for the Normal Plot tab of the shiny app
    print(plotNormal(mu = input$normalPlot_mu,
                     sigma = input$normalPlot_sigma,
                     alpha = input$alpha,
                     obs = input$xbar,
                     direction = input$dir,
                     plotly=TRUE))
  })
  
  samplePlt <- eventReactive(input$drawSample,{ #Updates the sample histogram when the drawSample button is pressed
    sample <<- randomSample(mu=input$sampleDist_mu,
                            sigma = input$sampleDist_sigma,
                            sampleSize=input$sampleSize,
                            numSamples=input$numSamples) #Updates the global sample dataframe
    
    randomSample_histogram(sample,
                           variableName = input$name,
                           plotly=TRUE) #Updates histogram of random sample
  })
  
  output$randomSampleDist <- renderPlotly({
    samplePlt()
  })
  
  meansPlt <- eventReactive(input$drawSample,{ #Updates the mean sampling distribution histogram when the drawSample button is pressed
    means <<- updateSampleMeans(sampleMeans = means,
                                randomSample = sample) #Updates the global means dataframe
    
    sampleMeans_histogram(means,
                          variableName = input$name,
                          plotly=TRUE) #Updates histogram of means
  })
  
  output$meanSamplingDist <- renderPlotly({
    meansPlt()
  })
}