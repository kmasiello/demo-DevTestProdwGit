library(shiny)
library(thematic)

thematic_shiny(font = "auto")
# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = bslib::bs_theme(
        bg = "#002B36", fg = "#EEE8D5", primary = "#2AA198",
        # bslib also makes it easy to import CSS fonts
        base_font = bslib::font_google("Pacifico")
    ),
    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 60,
                        value = 25)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = "#2AA198", border = 'gray')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
