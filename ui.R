library(shiny)
library(plotly)
library(finalProject)


shinyUI(navbarPage("STAT 585",
                   tabPanel("Normal Plot",
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("distributionType",
                                            label="Population Shape",
                                            choices = list("Normal"),
                                            selected="Normal"),
                                numericInput("normalPlot_mu",
                                             label = "Population Mean",
                                             value=0),
                                numericInput("normalPlot_sigma",
                                             label = "Population Standard Deviation",
                                             value=1),
                                numericInput("alpha",
                                             label = "Significance Level",
                                             value=.05),
                                selectInput("dir",
                                            label="Direction of Alternative Hypothesis",
                                            choices = list(intToUtf8("8800"), #8800 is HTML for "not equal to"
                                                           ">",
                                                           "<")),
                                numericInput("xbar",
                                             label= "Sample Mean",
                                             value=0)),
                              # Show a plot of the generated distribution
                              mainPanel(
                                plotlyOutput(outputId = "distPlot")
                              ))),
                   tabPanel("Sampling Distribution of Sample Means",
                            sidebarLayout(
                              sidebarPanel(selectInput("distributionType",
                                                       label="Population Shape",
                                                       choices = list("Normal",
                                                                      "Skewed Right",
                                                                      "Uniform"),
                                                       selected="Normal"),
                                           numericInput("sampleDist_mu",
                                                        label = "Population Mean",
                                                        value=0),
                                           numericInput("sampleDist_sigma",
                                                        label = "Population Standard Deviation",
                                                        value=1),
                                           textInput("name",
                                                     label = "Name of Variable",
                                                     value = "Height"),
                                           numericInput("sampleSize",
                                                        label = "Sample Size",
                                                        value=25),
                                           numericInput("numSamples",
                                                        label = "Number of Samples",
                                                        value=1),
                                           actionButton("drawSample",label = "Draw Additional Samples")),
                              # Show a plot of the generated distribution
                              mainPanel(plotlyOutput(outputId = "randomSampleDist"),
                                plotlyOutput(outputId = "meanSamplingDist")
                              )))))