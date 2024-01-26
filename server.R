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
      select(artist_name, track_name, streams, in_spotify_playlists, in_apple_playlists, in_deezer_playlists)%>%
      rename(artist = artist_name, track = track_name, spotify = in_spotify_playlists, apple = in_apple_playlists,
             deezer = in_deezer_playlists)%>%
      arrange(desc(streams))
      
    
    datatable(data, options = list(
      scrollX = TRUE,
      paginate = TRUE,
      lengthMenu = c(5, 10, 15),
      pageLength = 20
    ))
    
  })
  
  output$tracksPerYearArtistPlot <- renderPlotly({
    
    genre_counts <- filtered_data() %>%
      group_by(genre_by_bpm) %>%
      summarize(num_tracks = n())
    
    
    p <- ggplot(data = genre_counts, aes(x = num_tracks, y = genre_by_bpm, fill = genre_by_bpm)) +
      geom_bar(stat = "identity") +
      labs(x = "Genre", y = "Nombre d'extraits", title = "Nombre d'extraits par genre")+
      theme_minimal()
    
    ggplotly(p)
    
  })
  
  # Render the interactive plotly plot
  output$genrePopularityPlot <- renderPlotly({
    
    
    year_counts <- filtered_data() %>%
      group_by(released_year) %>%
      summarize(num_tracks = n())
    p <- ggplot(data = year_counts, aes(x = released_year, y = num_tracks)) +
      geom_line() +  # Utiliser une courbe (ligne)
      labs(x = "Année", y = "Nombre d'extraits", title = "Nombre d'extraits par année")

    theme_minimal() 
    
    ggplotly(p)
    
  })
  
  
  
  
}





