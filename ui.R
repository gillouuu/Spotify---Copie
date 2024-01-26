base::source("packages.R")
base::source("global.r")

ui <- dashboardPage(skin = "black",
                    dbHeader,
                    dashboardSidebar(disable = TRUE),
                    dashboardBody(
                      box(title = "Important information",
                          solidHeader = FALSE,
                          p("This dashboard presents summarized data"),
                          p("Note: Only artists with at leasts 5 songs"),
                          width = 12,
                          background = "green"),
                      box(
                        title = "Artist",
                        solidHeader = FALSE,
                        width = 6,
                        column(3, align = "center"),
                        column(6, pickerInput(
                          inputId = "selected_artist",
                          choices = unique(spotify_data$artist_name)), multiple = TRUE),
                        column(3, align = "center")
                      ),
                      box(
                        title = "Chat with ChatGPT",
                        solidHeader = FALSE,
                        width = 6,
                        column(3, align = "center"),
                        column(6, align = "center"),
                        column(3, align = "center"),
                        br(),
                        br(),
                        br()
                      ),
                      box(
                        title = "Stats",
                        solidHeader = FALSE,
                        width = 6,
                        valueBoxOutput("numStreams", width = 6),
                        valueBoxOutput("numTracks", width = 6),
                        valueBoxOutput("numArtists", width = 6),
                        valueBoxOutput("numGenre", width = 6),
                        
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                
                        fluidRow(box(plotlyOutput("tracksPerYearArtistPlot")),
                                 box(plotlyOutput("genrePopularityPlot"))



                        )
                      ),
                       br(), 
                      box(title = "Track & playlist presence",
                          dataTableOutput("datatable_track")
                      )

                    ))


