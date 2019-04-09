library(shiny)
library(plotly)
library(finalProject)

# Define server logic required to draw a normal plot
means <- data.frame() #initialize an emtpy data frame to be reactively updated with sample means
sample <- data.frame()
totalNumSamples <- 0

server <- function(input, output) {
  
  output$distPlot <- renderPlotly({ #Server logic for the Normal Plot tab of the shiny app
    print(plotNormal(mu = input$normalPlot_mu,
                     sigma = input$normalPlot_sigma,
                     alpha = input$alpha,
                     obs = input$xbar,
                     direction = input$dir,
                     plotly=TRUE))
  })
  
  output$randomSampleDist <- renderPlotly({
    samplePlt()
  })
  
  output$randomSampleTable <- renderTable({
    sampleSummary()
  },)
  
  output$meanSamplingDist <- renderPlotly({
    meansPlt()
  })
  
  output$meansTable <- renderTable({
    meansSummary()
  })
  
  observeEvent(input$drawSample,{ #Anytime the buttom is clicked, creates a new random sample
    sample <<- randomSample(mu=input$sampleDist_mu,
                            sigma = input$sampleDist_sigma,
                            sampleSize=input$sampleSize,
                            numSamples=input$numSamples) #Updates the global sample dataframe
    totalNumSamples <<- as.integer(totalNumSamples + input$numSamples) #update with total number of samples drawn since starting the app
  })
  
  samplePlt <- eventReactive(input$drawSample,{ #Updates the sample histogram when the drawSample button is pressed
    randomSample_histogram(sample,
                           variableName = input$name,
                           plotly=TRUE) #Updates histogram of random sample
  })
  
  sampleSummary <- eventReactive(input$drawSample,{
    dat <- sample[,ncol(sample)]

    tbl <- data.frame(Mean = mean(dat), 
                      stdDev = sd(dat),
                      sampleNum = totalNumSamples)
    return(t(tbl))
  })
  
  meansPlt <- eventReactive(input$drawSample,{ #Updates the mean sampling distribution histogram when the drawSample button is pressed
    means <<- updateSampleMeans(sampleMeans = means,
                                sampleData = sample) #Updates the global means dataframe

    sampleMeans_histogram(means,
                          variableName = input$name,
                          plotly=TRUE) #Updates histogram of means
  })
  
  meansSummary <- eventReactive(input$drawSample,{
    tbl <- data.frame(`mean(SampleMeans)` = mean(means$means),
                      `sd(SampleMeans)` = sd(means$means),
                      `total(SampleMeans)` = totalNumSamples)
    tbl
  })
}