library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Exploring the Total cyber crimes in metropolitan cities from 2019 to 2021",
                  titleWidth = 650) ,
  dashboardSidebar(
    sidebarMenu(
         id = "sidebar",
         
         #first menu item
         menuItem("Dataset", tabName = "data", icon = icon("database")),
         menuItem(text = "Visualization", tabName = "Viz", icon = icon("chart-line")),
         menuItem(text = "Hypotheses Testing", tabName = "Hyp_test", icon = icon("pie-chart"))
    )
  ),
  dashboardBody(
    tabItems(
      # first tab Item
      tabItem(tabName = "data", 
              #tab box
              tabBox(id = 't1', width = 12,
                     tabPanel("About", 
                              icon = icon("address-card"), 
                              h4("About the Dataset"),
                              p("The dataset contains information about the number of cyber crimes reported in 53 metropolitan cities across India."),
                              p("Data Source: https://data.gov.in/"),
                              p("This dataset includes various details such as the types of cyber crimes reported, the frequency of incidents, and other relevant information."),
                              p("The goal of this analysis is to explore patterns, trends, and insights related to cyber crimes in metropolitan areas."),
                              img(src = "image1.jpg", width = "500px", height = "500px", alt = "Cyber Crime Image"),
                              
                     ),
                     tabPanel("Description of Varaibles", 
                              icon = icon("address-card"), 
                              h4("Variables and their meanings"),
                              p("Metropolitan cities : Name of the cities"),
                              p("2019 CR : Cases Registered in 2019"),
                              p("2019 Total Arrested : Number of persons arrested in 2019"),
                              p("2020 CR : Cases Registered in 2020"),
                              p("2020 Total Arrested : Number of persons arrested in 2020"),
                              p("2021 CR : Cases Registered in 2021"),
                              p("2021 Total Arrested : Number of persons arrested in 2021"),
                              
                     ),
                     tabPanel(title = "Data", icon = icon("address-card"), dataTableOutput("dataT")),
                     tabPanel(title = "Structure", icon = icon("address-card"), verbatimTextOutput("structure")),
                     tabPanel(title = "Summary Stats", icon = icon("address-card"), verbatimTextOutput("summary"))
                     )
              ),
      tabItem(tabName = "Viz",
              tabBox(id = 't2', width = 12,
                     tabPanel(
                       "Histograms",icon = icon("address-card"),
                       sidebarLayout(
                         sidebarPanel(
                           selectInput("year", "Select Year:", choices = c("2019", "2020", "2021"), selected = "2019"),
                           sliderInput("bins", "Number of Bins:", min = 1, max = 50, value = 30)
                         ),
                         mainPanel(
                           plotOutput("histogram")
                         )
                       )
                     ),
                     
                     tabPanel("Top 10 Cities with high cyber crime cases registered",icon = icon("address-card"),
                     sidebarLayout(
                       sidebarPanel(
                         selectInput("year_1", "Select Year:", choices = c("2019", "2020", "2021"), selected = "2019"),
                       ),
                       mainPanel(
                         dataTableOutput("top_cities_cases")
                       )
                     )
                   ),
                   
                   tabPanel("Top 10 Cities with high cyber crime accused arrested",icon = icon("address-card"),
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("year_2", "Select Year:", choices = c("2019", "2020", "2021"), selected = "2019"),
                              ),
                              mainPanel(
                                dataTableOutput("top_cities_arrested")
                              )
                            )
                   ),
                   tabPanel("Trend of cyber crimes registered in top metropilitan cities",icon = icon("address-card"),
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("selected_city", "Select City:",
                                            choices = c("Bengaluru", "Mumbai", "Hyderabad",
                                                        "Lucknow", "Jaipur", "Varanasi",
                                                        "Vishakhapatnam", "Kanpur",
                                                        "Allahabad", "Ghaziabad"),
                                            selected = "Bengaluru"),
                              ),
                              mainPanel(
                                plotlyOutput("trend_chart")
                              )
                            )     
                   )
              )     
        
      ),
      tabItem(tabName = "Hyp_test",
              tabBox(id = 't2', width = 12,
                     tabPanel("ANOVA test on Cases Registered from 2019 to 2021", icon = icon("address-card"),
                              fluidRow(
                                column(width = 5),
                                column(width = 5,
                                       verbatimTextOutput("anova_result_1")),
                                column(width = 5)
                              )
                     
                     ),
                     tabPanel("ANOVA test on number of accused arrested from 2019 to 2021 ", icon = icon("address-card"),
                              fluidRow(
                                column(width = 5),
                                column(width = 5,
                                       verbatimTextOutput("anova_result_2")),
                                column(width = 5)
                              )
                     
                     )
                
              )
        
        
      )
    )
  )
)