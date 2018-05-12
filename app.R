library(rhandsontable)
library(DT)
library(shiny)
library(googlesheets)


mydata <- data.frame("Business_area" = ("Example - Marketing"),
                     "Comment"= ("Example - Computers recently upgraded, but no data science experience"),
                     stringsAsFactors=FALSE)

# I would like to assign topic to the company name provided in the table below
# Also - as a note - I am not sure where this command would fit within the 'shiny' structure. 

#topic <- "COMPANY"
#naming_fn_stub<-function(x){
#  paste0(x,Sys.time())
#}
#dest_sheet<-naming_fn_stub(topic)

shinyApp(
ui <- fluidPage(
  titlePanel("Data Science Readiness Review"),
  

  textInput("name", "Company", ""),
  selectInput("wordofmouth", "How did you hear about our data science readiness review?", 
              c("", "Email", "Blog post", "Twitter", "Recommendation", "I've used Steph's office hours", "I've worked with Steph before")),
  #checkboxInput("used_shiny", "", FALSE),
  #sliderInput("r_num_years", "Number of years using R", 0, 1, 2, ticks = FALSE),
  selectInput("os_type", "Operating system used most frequently",
              c("", "A mixture",  "Windows", "Mac", "Linux")),
  hr(),
  
  
  #I would like to separte these here into two pages accessed by a next button when mandatory fields are filled.
  #actionButton("next", "Next")

  DTOutput("mytable"),
  actionButton('add', 'Add Row') #I cannot make this work!! No idea what I'm missing.
),




server <- function(input, output, session) {
  mytable <- datatable(mydata)
  output$mytable = renderDT(mytable, editable=TRUE)
  
 observeEvent(input$add, { 
   mytable %>% addRow(mytable)
    })
  
  }

)

shinyApp(ui,server)