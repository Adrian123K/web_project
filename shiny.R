
############## set this file location to working directory ##########################
packages <- 'rstudioapi'
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))
}
library('rstudioapi')
current_dir<-dirname(rstudioapi::getSourceEditorContext()$path)
setwd('')

package_in<-function(p_name,option=1){
  packages <- p_name
  if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
    install.packages(setdiff(packages, rownames(installed.packages())))
  }
  if (option==1){
    library(p_name,character.only = TRUE)
  }
}

###########################1. 패키지 설치##########################################

package_in('shinydashboard')
package_in('shiny')
package_in('reticulate')



######################### 2. 화면 개발 ###########################################

sidebar <- dashboardSidebar(
  sidebarMenu(
    fileInput("file1", "Choose CSV File",
              multiple = TRUE,
              accept = c("text/csv",".xlsx",".png", ".jpeg", 
                         "text/comma-separated-values,text/plain",
                         ".csv"))
  )
  
  
)


body <- dashboardBody(
  tabItem(tabName = "barplot",
          mainPanel(
            textOutput('plot_bar')
          )
  )
  
)

ui<-dashboardPage(
  dashboardHeader(title='my graph'),
  sidebar,
  body
)

######################3. 서버단 개발 ########################################


server <- function(input, output,session) {
  options(warn = -1)
  options(shiny.maxRequestSize = 30*1024^2)
  
  
  
  
  dataload<-reactive({
    
    req(input$file1)
    
    j = input$file1
    return (j)
  })
  
  output$plot_bar <- renderPrint({
    
    
    py$j <- dataload()
    
    library(reticulate)
    use_condaenv("Anaconda3")
    
    use_virtualenv("r-reticulate") 
    use_python("C:\\Users\\knit\\Anaconda3")
    
    source_python("C:\\Users\\knit\\p3.py", envir = parent.frame(), convert = TRUE)
    
    y3 <- py$y3
    
    
    
    if (y3=='1'){
      aa <- '정상'
    } else {
      aa <- '불량'
    }
    
    return (aa)
    
    
  })  
  
}

######################### 4. 샤이니 실행 ###############################

shinyApp(ui = ui, server = server)
