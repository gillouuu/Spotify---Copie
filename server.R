# Define the server logic
server <- function(input, output, session) {
  
  filtered_data <-reactive({
    spotify_data%>%
      filter(artist_name %in% input$selected_artist)
    
  })
  
  
  # Calculate number of streams
  num_streams <- reactive({
    filtered_data()%>%
      summarise(n_streams = sum(streams))%>%
      pull()
    
  })
  
  # Calculate number of tracks
  num_tracks <- reactive({
    filtered_data()%>%
      summarise(n_tracks = n()) %>%
      pull()
      
    
  })
  
  # Calculate number of artists
  num_artists <- reactive({
    length(input$selected_artist)
  })
  # Calculate number of genre
  num_genre <- reactive({
      unique_genres <- unique(filtered_data()$genre_by_bpm)
      num_unique <- length(unique_genres)
      return(num_unique)
   
  })
  
  
  output$numStreams <- renderValueBox({
    valueBox(value = num_streams(), color = "olive", subtitle = "Number of streams")
    
  })
  
  output$numTracks <- renderValueBox({
    valueBox(value = num_tracks(), color = "olive", subtitle = "Number of tracks")
  
  })
  
  
  output$numArtists <- renderValueBox({
    valueBox(value = num_artists(), color = "olive", subtitle = "Number of artists")
  
  })
  
  
  output$numGenre <- renderValueBox({
    valueBox(value = num_genre(), color = "olive", subtitle = "Number of genre")
    
  })
  
  
  output$datatable_track <- renderDT({
    data <- filtered_data() %>% 
      ...
    
    datatable(data, options = list(
      scrollX = TRUE,
      paginate = T,
      lengthMenu = c(5, 10, 15),
      pageLength = 20
    ))
    
  })
  
  output$tracksPerYearArtistPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      ...
    
    p <- ggplot()
    ...
      theme_minimal() 
    
    ggplotly(p)
    
  })
  
  # Render the interactive plotly plot
  output$genrePopularityPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      ...
    
    p <- ggplot()
    ...
    theme_minimal() 
    
    ggplotly(p)
    
  })
  
}





