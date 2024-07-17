library(shiny)

# Define the user interface
ui <- fluidPage(
    
    tags$head(
        tags$style(HTML("
            body { 
                font-family: 'Arial', sans-serif; 
                background-color: #f4f4f2; 
                color: #333; 
            }
            .shiny-input-container {
                width: 250px; /* Control dropdown width */
            }
            .navbar {
                background-color: #0056b3;
                border-color: #e7e7e7;
            }
            .navbar-default .navbar-nav>li>a {
                color: white;
            }
            .navbar-default .navbar-brand {
                color: white;
            }
            .tab-content {
                background-color: white;
                padding: 20px;
                border: 1px solid #ddd;
                border-top: none;
                color: #555;
            }
            h2 {
                color: #0056b3;
            }
            h4 {
                border-bottom: 2px solid #0056b3;
                padding-bottom: 10px;
            }
        "))
    ),
    titlePanel("Data Analysis Dashboard", windowTitle = "Dashboard"),
    
    # Using tabsetPanel to separate iPhone and Android data
    tabsetPanel(type = "tabs",
        tabPanel("iPhone Data", 
                 sidebarLayout(
                     sidebarPanel(
                         selectInput("iphoneGraphSelect", "Choose an iPhone Graph:",
                                     choices = list("Message Count per Day" = "1.png",
                                                    "Average Time Sent Message" = "2.png",
                                                    "Message Count per Day" = "3.png",
                                                    "File Extension" = "4.png",
                                                    "Frequency of Photo" = "5.png",
                                                    "Sentiment Analysis Time" = "6.png",
                                                    "Sentiment Analysis Moving Average" = "7.png",
                                                    "Frequency of Message" = "8.png",
                                                    "Network Analysis" = "9.png",
                                                    "Average Response Time" = "10.png",
                                                    "Message Counts Week" = "11.png",
                                                    "Message Counts Week2" = "12.png")),
                         tags$hr()),
                     mainPanel(
                         h3(textOutput("iphoneGraphTitle")),
                         imageOutput("iphoneGraph"),
                         tags$hr(),
                         h4("Hypotheses and Results for iPhone"),
                         uiOutput("iphoneHypothesesOutput"))
                 )),
        tabPanel("Android Data", 
                 sidebarLayout(
                     sidebarPanel(
                         selectInput("androidGraphSelect", "Choose an Android Graph:",
                                     choices = list("Message Count per Day" = "a1.png",
                                                    "Frequency of Photo" = "a2.png",
                                                    "Sentiment Analysis Time" = "a3.png",
                                                    "Sentiment Analysis Moving Average" = "a4.png",
                                                    "Average Response Time" = "a5.png",
                                                    "Message Counts Week" = "a6.png",
                                                    "Average Time Sent Message" = "a7.png")),
                         tags$hr()),
                     mainPanel(
                         h3(textOutput("androidGraphTitle")),
                         imageOutput("androidGraph"),
                         tags$hr(),
                         h4("Hypotheses and Results for Android"),
                         uiOutput("androidHypothesesOutput"))
                 ))
    )
)

server <- function(input, output) {
    # iPhone graph rendering
    output$iphoneGraph <- renderImage({
        path <- normalizePath(file.path("C:/Users/abral/Desktop/Thesis/Data Analysis & Machine Learning/ThesisDaML/Data_Analysis_phone/www/Graph", input$iphoneGraphSelect), mustWork = TRUE)
        list(src = path, contentType = 'image/png', width = 600, height = 400, alt = "This image cannot be displayed")
    }, deleteFile = FALSE)
    
    output$iphoneGraphTitle <- renderText({
        switch(input$iphoneGraphSelect,
               "1.png" = "Daily message counts during intensive and normal usage periods",
               "2.png" = "Variability of daily message counts in intensive and normal usage periods",
               "3.png" = "Time differences between photo creation and modifi-cation dates during intensive and normal usage.",
               "4.png" = "Time differences between creating and modifying media files in intensive and normal usage periods",
               "5.png" = "Daily photo counts during intensive and normal usage periods",
               "6.png" = "Sentiment analysis over time for intensive vs normal usage periods",
               "7.png" = "Comparison of sentiment trends over time during intensive and normal usage periods",
               "8.png" = "Frequency of messages sent and received during intensive and normal usage periods",
               "9.png" = "Network analysis visualizations differences in structure and centrality between intensive and normal usage periods.",
               "10.png" = "average response times foruser in intensive and normal usage periods",
               "11.png" = "Comparison of daily message counts for intensive vs. normal usage periods",
               "12.png" = "Comparison of daily message counts for intensive vs. normal usage periods"
        )
    })
    
    output$iphoneHypothesesOutput <- renderUI({
        switch(input$iphoneGraphSelect,
               "1.png" = HTML("<div>
    <h2>Hypothesis 1: Message Activity Analysis</h2>
    <p><strong>Hypothesis:</strong> Intensive usage periods have a significantly higher average daily message count than normal usage periods.</p>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the average daily message count between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> Intensive usage periods have a significantly higher average daily message count than normal usage periods.</li>
    </ul>
    <p><strong>Results:</strong> The Welch Two Sample t-test yielded a p-value of 0.4714, suggesting no statistically significant difference in message counts between the two periods.</p>
    <p><strong>Interpretation:</strong> This result indicates that user messaging behavior remains consistent across different usage intensities.</p>
    <p><strong>User Pattern Verdict:</strong> Messaging behavior does not fluctuate significantly between different usage intensities, indicating consistent communication habits.</p>

    <h2>Hypothesis 2</h2>
    <p><strong>Hypothesis:</strong> There is greater variability in the daily message counts during normal usage compared to intensive usage.</p>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the variability of daily message counts between normal and intensive usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is greater variability in the daily message counts during normal usage compared to intensive usage. Results: The F test for variance comparison yielded a p-value of 0.4703, indicating no significant difference in daily message count variability (Figure 4.2).</li>
    </ul>
    <p><strong>Interpretation:</strong> So, we can say that the spread of message counts is consistent regardless of usage intensity.</p>
    <p><strong>User Pattern Verdict:</strong> The consistency in message variability suggests stable communication patterns, unaffected by changes in usage intensity.</p>
</div>
"),
               "2.png" = HTML(""),
               
               "3.png" = HTML("<div>
    <h2>Hypothesis 3: Photo Metadata Analysis</h2>
    <p><strong>Hypothesis:</strong> The time difference between creating and modifying photos is significantly different compared to normal usage during intensive usage periods.</p>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the time differences between creating and modifying media files during intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> A significant difference exists between creating and modifying media files during intensive and normal usage periods. Results: The Mann-Whitney U test provides a p-value less than 0.05, indicating significant differences in the time intervals between photo creation and modification (Figure 4.3).</li>
    </ul>
    <p><strong>Interpretation:</strong> We can say that users interact differently with their media files during intensive usage periods, possibly editing or organizing photos sooner after creation compared to normal periods.</p>
    <p><strong>User Pattern Verdict:</strong> The findings imply a more dynamic interaction with media files during intensive usage periods, reflecting a more engaged or different usage behavior in terms of media file management.</p>
</div>
"),
               "4.png" = HTML("<div>
    <h2>Hypothesis 4: Time Differences in Media File Modifications</h2>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the time differences between the creation and modification of media files during intensive and normal usage.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a significant difference in the time differences between creation and modification of media files during intensive and normal usage. Results: The Mann-Whitney U test provides a p-value less than 2.2 × 10<sup>−16</sup>, suggesting strong evidence to reject the null hypothesis and accept the alternative hypothesis.</li>
    </ul>
    <p><strong>Interpretation:</strong> This significant difference in time differences implies that user interaction with media files varies notably between intensive and normal usage periods. During intensive periods, modifications occur either significantly sooner or later after creation compared to normal periods.</p>
    <p><strong>User Behavior Pattern Verdict:</strong> The evidence suggests users are more actively managing their media files during intensive periods, possibly due to higher engagement or different usage contexts. This could reflect more dynamic behavior in terms of content management depending on the intensity of the usage.</p>
</div>
"),
               "5.png" = HTML("<div>
    <h2>Hypothesis 5: Daily Photo Count Variability</h2>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the average daily number of photos taken between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a significant difference in the average daily number of photos taken between intensive and normal usage periods. Results: Statistical tests, including the Shapiro-Wilk normality test, F-test for equal variances, Welch Two Sample t-test, and Mann-Whitney U test, indicate no significant difference in daily photo counts. P-values from these tests consistently suggest accepting the null hypothesis.</li>
    </ul>
    <p><strong>Interpretation:</strong> Despite potential differences in usage intensity, the number of photos taken daily remains consistent, indicating a stable pattern in photo-taking behavior across different usage contexts.</p>
    <p><strong>User Behavior Pattern Verdict:</strong> The user’s photo-taking habits do not significantly fluctuate between different usage intensities, suggesting that the usage context does not influence photo capture frequency.</p>
</div>
"),
               "6.png" = HTML("<div>
    <h2>Hypothesis 6: Sentiment Analysis of Messages</h2>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no difference in the sentiment of messages between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a difference in the sentiment of messages between intensive and normal usage periods. Results: The Mann-Whitney U test and the Welch Two Sample t-test resulted in high p-values, suggesting no significant difference in message sentiments between the two periods.</li>
    </ul>
    <p><strong>Interpretation:</strong> The consistent sentiment scores across different usage intensities imply that the emotional content of messages remains stable, independent of how intensively the device is used.</p>
    <p><strong>User Behavior Pattern Verdict:</strong> This stability in sentiment expression suggests that users maintain a consistent, communicative tone, regardless of the period or intensity of device usage, potentially indicating robustness in emotional expression through text.</p>
</div>
"),
               "7.png" = HTML("<div>
    <h2>Hypothesis 7: Variability in Sentiment Trends Over Time</h2>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the sentiment trend over time between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a significant difference in the sentiment trend over time between intensive and normal usage periods. Results: The independent samples t-test on the sentiment scores over time indicates a high p-value of 0.9, suggesting no significant differences between the average sentiment scores during intensive and normal usage periods.</li>
    </ul>
    <p><strong>Interpretation:</strong> The statistical test indicates that the observed mean differences in sentiment are likely due to random chance, suggesting that the sentiment trends do not significantly diverge between different usage intensities.</p>
    <p><strong>User Behavior Pattern Verdict:</strong> The analysis demonstrates that changes in usage intensity do not affect the overall emotional tone of messages. This result underscores the robustness of users’ emotional expressions, independent of their usage pattern changes.</p>
</div>
"),
               "8.png" = HTML("<div>
    <h2>Hypothesis 8: Messaging Frequency</h2>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no difference in the counts of messages sent and received by the user during intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a difference in the counts of messages sent and received by the user during intensive and normal usage periods. Results: The proportion tests for both sent and received messages resulted in a p-value of 0.6256, suggesting that differences in messaging frequency are not statistically significant.</li>
    </ul>
    <p><strong>Interpretation:</strong> The lack of significant differences in message counts indicates that the user’s communication frequency is stable across different usage intensities, pointing to a consistent interaction pattern irrespective of usage context.</p>
    <p><strong>User Behavior Pattern Verdict:</strong> Users maintain a consistent communication pattern, suggesting that the intensity of device usage does not influence how frequently they engage in messaging activities. This consistency might reflect a habitual aspect of user behavior that remains stable over varying contexts.</p>
</div>
"),
               "9.png" = HTML("<div>
    <h2>Hypothesis 9: Network Structure Variability</h2>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the network centrality between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a significant difference in the network centrality between intensive and normal usage periods.</li>
    </ul>
    <h3>Network Analysis Results</h3>
    <p><strong>Density:</strong> Intensive usage network density: 0.7777778, Normal usage network density: 0.3973684. The higher density in intensive usage periods indicates more connections between nodes, suggesting a more tightly knit network with increased interactions among users.</p>
    <p><strong>Transitivity (Global Clustering Coefficient):</strong> Both networks’ transitivity: 0. The absence of closed triplets (transitivity = 0) in both network configurations suggests that, despite a denser network in intensive periods, the overall connectivity does not form tightly connected triads, possibly due to the larger size or complexity of the network.</p>
    <p><strong>Graph Distance:</strong> Calculated graph distance: 135. A graph distance of 135 points to considerable differences in the connections between the two networks, reflecting substantial changes in how users interact within these periods.</p>
    <h3>Interpretation and Justification</h3>
    <p>The marked difference in network density supports rejecting the null hypothesis based on network structural changes alone, suggesting significant alterations in user interactions across different usage intensities. However, the lack of statistical testing on network density and the zero transitivity highlight the need for caution in interpretation.</p>
    <h3>Final Verdict on User Pattern</h3>
    <p>While the dense network during intensive periods suggests more user interaction, the absence of formal statistical significance testing for graph distance means we should interpret the findings cautiously. Further statistical analysis using network comparison techniques like Quadratic Assignment Procedure (QAP) or network permutation tests could provide more definitive insights.</p>
</div>
"),
               "10.png" = HTML("<div>
    <h2>Hypothesis 10: Response Time Analysis</h2>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no difference in the average response times of the user as both a sender and receiver during intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a difference in the average response times of the user as both a sender and receiver during intensive and normal usage periods.</li>
    </ul>
    <p><strong>Results:</strong> Response times were calculated separately for messages sent and received during both intensive and normal usage periods, assessing how quickly the user responds in different scenarios.</p>
    <h3>Statistical Analysis</h3>
    <p>Mann-Whitney U tests were conducted to compare the response times between intensive and normal periods for sending and receiving messages. This non-parametric test was chosen because it is suitable for comparing differences between two independent sample sets that may not follow a normal distribution.</p>
    <h3>Interpretation</h3>
    <p>The tests did not show significant differences in response times between intensive and normal usage periods (p-values > 0.05). This suggests that the responsiveness of the user is consistent across different usage intensities.</p>
    <h3>Final Verdict</h3>
    <p>The consistency in response times irrespective of the usage intensity indicates that the user’s responsiveness is stable, suggesting that external factors related to the intensity of usage periods do not significantly impact how quickly the user engages with messages.</p>
</div>
"),
               "11.png" = HTML("<div>
    <h2>Hypothesis 11: Message Count Variability by Day of the Week</h2>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no difference in the distribution of message counts per day of the week between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a difference in the distribution of message counts per day of the week between intensive and normal usage periods.</li>
    </ul>
    <p><strong>Results:</strong> Message counts were aggregated by day for both intensive and normal usage periods, and the distribution was analyzed to identify patterns or significant discrepancies.</p>
    <h3>Statistical Analysis</h3>
    <p>A Chi-squared test for independence was performed to determine if there’s a significant association between the day of the week and message count variability between the two usage types. This statistical approach helps identify whether the observed frequencies across different days deviate from what would be expected under the null hypothesis.</p>
    <h3>Interpretation</h3>
    <p>The Chi-squared test resulted in a significant value (p-value < 0.05), indicating a strong association between the day of the week and message count variability. So, we can say that usage intensity influences the user’s messaging behavior, with certain days showing more activity, potentially due to external factors such as work or social events.</p>
    <h3>Final Verdict</h3>
    <p>Significant variability in message counts across different days suggests adaptive user behavior that varies with the intensity of usage periods. This variability implies that the user might be more active on certain days during intensive periods compared to normal periods, likely influenced by external schedules or commitments.</p>
</div>
"),
               "12.png" = HTML("<div>
    <h2>Hypothesis 11: Message Count Variability by Day of the Week</h2>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no difference in the distribution of message counts per day of the week between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a difference in the distribution of message counts per day of the week between intensive and normal usage periods.</li>
    </ul>
    <p><strong>Results:</strong> Message counts were aggregated by day for both intensive and normal usage periods, and the distribution was analyzed to identify patterns or significant discrepancies.</p>
    <h3>Statistical Analysis</h3>
    <p>A Chi-squared test for independence was performed to determine if there’s a significant association between the day of the week and message count variability between the two usage types. This statistical approach helps identify whether the observed frequencies across different days deviate from what would be expected under the null hypothesis.</p>
    <h3>Interpretation</h3>
    <p>The Chi-squared test resulted in a significant value (p-value < 0.05), indicating a strong association between the day of the week and message count variability. So, we can say that usage intensity influences the user’s messaging behavior, with certain days showing more activity, potentially due to external factors such as work or social events.</p>
    <h3>Final Verdict</h3>
    <p>Significant variability in message counts across different days suggests adaptive user behavior that varies with the intensity of usage periods. This variability implies that the user might be more active on certain days during intensive periods compared to normal periods, likely influenced by external schedules or commitments.</p>
</div>
"),
               
        )
    })
    
    # Android graph rendering
    output$androidGraph <- renderImage({
        path <- normalizePath(file.path("C:/Users/abral/Desktop/Thesis/Data Analysis & Machine Learning/ThesisDaML/Data_Analysis_phone/www/Graph/android", input$androidGraphSelect), mustWork = TRUE)
        list(src = path, contentType = 'image/png', width = 600, height = 400, alt = "This image cannot be displayed")
    }, deleteFile = FALSE)
    
    output$androidGraphTitle <- renderText({
        switch(input$androidGraphSelect,
               "a1.png" = "Daily message volume comparison between intensive and normal usage periods",
               "a2.png" = "Comparison of daily photo counts between intensive and normal usage periods",
               "a3.png" = "Sentiment scores over time comparing intensive and normal usage periods",
               "a4.png" = "Moving average of sentiment scores over time comparing intensive and normal usage periods",
               "a5.png" = "Distribution of messages by sender comparing intensive and normal usage periods",
               "a6.png" = "Distribution of messages across days of the week comparing intensive and normal usage periods",
               "a7.png" = "Variability of daily message counts in intensive and normal usage periods",
              
        )
    })
    
    output$androidHypothesesOutput <- renderUI({
        switch(input$androidGraphSelect,
               
               "a1.png" = HTML("<div>
    <h2>Hypothesis 1: Message Volume Analysis</h2>
    <p><strong>Objective:</strong> To determine if the number of messages sent per day differs between intensive and normal usage periods.</p>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> No significant difference in the number of messages sent per day between intensive and normal usage periods exists.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a significant difference in the number of messages sent per day between intensive and normal usage periods.</li>
    </ul>
    <h3>Results</h3>
    <ul>
        <li><strong>Mann-Whitney U Test:</strong> Resulted in a p-value of 0.9657, suggesting no significant difference in message volume.</li>
        <li><strong>Welch Two Sample t-Test:</strong> Resulted in a p-value of 0.9396, similarly indicating no significant difference.</li>
        <li><strong>Shapiro-Wilk Normality Test:</strong> Showed p-values of 0.06032 for intensive usage and 0.01625 for normal usage, indicating a normal distribution for intensive usage but not for normal usage.</li>
    </ul>
    <h3>Interpretation</h3>
    <p>Given the non-normal distribution in normal usage periods, the Mann-Whitney U test is the appropriate analysis tool. Both it and the Welch t-test indicate consistent messaging habits across usage intensities.</p>
    <h3>Conclusion</h3>
    <p>The data does not support a significant difference in daily message volumes between intensive and normal periods. The user’s messaging behavior remains consistent, suggesting that usage intensity does not influence the number of messages sent.</p>
</div>
"),
               "a2.png" = HTML("<div>
    <h2>Hypothesis 2: Photo Frequency Analysis</h2>
    <p><strong>Objective:</strong> To examine photo frequency differences between intensive and normal usage periods.</p>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no difference in the average daily number of photos taken during intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a difference in the average daily number of photos taken during intensive and normal usage periods.</li>
    </ul>
    <h3>Statistical Tests</h3>
    <p>The Welch Two Sample t-test and Wilcoxon rank sum test were performed, yielding p-values of 0.6195 and 0.5037, respectively, suggesting no significant differences in photo frequency.</p>
    <h3>Conclusion</h3>
    <p>Statistical evidence does not indicate a change in the user’s photo taking behavior between usage periods, implying stability in how often photos are taken, regardless of usage intensity.</p>
    <h3>Further Analysis</h3>
    <p>Additional analyses could involve a deeper look into the context and content of messages or photos to better understand user behavior beyond just counting interactions. Qualitative data might reveal more about user engagement and preferences.</p>
</div>
"),
               "a3.png" = HTML("<div>
    <h2>Hypothesis 3: Sentiment Analysis Over Time</h2>
    <p><strong>Objective:</strong> To evaluate if there is a significant difference in sentiment scores between intensive and normal usage periods.</p>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the sentiment scores on average between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a significant difference in the sentiment scores on average between intensive and normal usage periods.</li>
    </ul>
    <h3>Results</h3>
    <p><strong>Mann-Whitney U Test:</strong> p-value = 0.8426, indicating no significant difference in the distributions of sentiment scores.</p>
    <p><strong>Welch Two Sample t-Test:</strong> p-value = 0.7727, confirming no significant difference in the means of sentiment scores over time.</p>
    <h3>Interpretation</h3>
    <p>The analysis suggests that the user’s messaging sentiment does not fluctuate with changes in usage intensity, implying that the factors influencing sentiment are independent of usage frequency or volume.</p>
    <h3>Conclusion</h3>
    <p>There is no significant shift in sentiment expression during different usage intensities, indicating stable emotional expression through text across varying messaging activities.</p>
</div>
"),
               "a4.png" = HTML("<div>
    <h2>Hypothesis 4: Sentiment Trends with Moving Averages</h2>
    <p><strong>Objective:</strong> To assess if there is a significant difference in sentiment score trends, as indicated by moving averages, between intensive and normal usage periods.</p>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the sentiment score trends, as indicated by the moving average, between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a significant difference in the sentiment score trends, as indicated by the moving average, between intensive and normal usage periods.</li>
    </ul>
    <h3>Results</h3>
    <p>The Welch Two Sample t-test for moving averages produces a p-value of 0.7727, showing no significant difference in the means of sentiment scores over time between the two periods.</p>
    <h3>Interpretation</h3>
    <p>The consistency in sentiment trends, as evidenced by the similar moving averages, points to a user whose emotional expression in messaging does not oscillate with changes in their messaging behavior classified as intensive or normal.</p>
    <h3>Conclusion</h3>
    <p>The sentiment analysis with moving averages confirms that the sentiment trends do not significantly change between different usage intensities. This stability suggests that the user’s emotional expression through messages remains consistent, irrespective of the intensity of usage.</p>
</div>
"),
               "a5.png" = HTML("<div>
    <h2>Hypothesis 5: Messaging Patterns by Sender</h2>
    <p><strong>Objective:</strong> To determine if there is a significant difference in the distribution of messages by sender between intensive and normal usage periods.</p>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the distribution of messages by sender between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a significant difference in the distribution of messages by sender between intensive and normal usage periods.</li>
    </ul>
    <h3>Results</h3>
    <p>Chi-Square Test: Chi-squared value = 7.3728, degrees of freedom = 4, p-value = 0.1175.</p>
    <h3>Interpretation</h3>
    <p>The chi-square test suggests that there is no statistically significant difference in the distribution of messages by sender between the two usage periods.</p>
    <h3>Conclusion</h3>
    <p>The analysis indicates that the sender’s messaging behavior remains consistent across different usage intensities, with no significant shifts in messaging patterns attributable to the sender during intensive versus normal periods.</p>
</div>
"),
               "a6.png" = HTML("<div>
    <h2>Hypothesis 6: Message Count per Day of the Week</h2>
    <p><strong>Objective:</strong> To examine if there is a significant difference in the distribution of messages across the days of the week between intensive and normal usage periods.</p>
    <ul>
        <li><strong>Null Hypothesis (H0):</strong> There is no significant difference in the distribution of messages across the days of the week between intensive and normal usage periods.</li>
        <li><strong>Alternative Hypothesis (H1):</strong> There is a significant difference in the distribution of messages across the days of the week between intensive and normal usage periods.</li>
    </ul>
    <h3>Results</h3>
    <p>Chi-Square Test: Chi-squared value = 21.067, degrees of freedom = 6, p-value = 0.001785.</p>
    <h3>Interpretation</h3>
    <p>The chi-squared test indicates a significant difference in the distribution of messages across the days of the week, suggesting variability in messaging frequency depending on the day.</p>
    <h3>Conclusion</h3>
    <p>There is a significant variation in how messages are distributed across different days of the week during intensive and normal usage periods, possibly reflecting changes in the user’s daily routines, commitments, or interactions that influence messaging behavior.</p>
</div>
"),
               "a7.png" = HTML(""),
        )
    })
}

# Run the application
shinyApp(ui = ui, server = server)
