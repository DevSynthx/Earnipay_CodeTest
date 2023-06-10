# Earnipay Code Test


# Application's performance:
 
To improve the application performance, SliverChildBuilderDelegate which is a delegate used with SliverList and SliverGrid was used The purpose is it loads images only when they are needed instead of loading all the images at once. As the user scrolls, additional items are built dynamically. This minimizes the initial loading time and optimizes the memory usage

Caching helps reduce the number of network requests needed to fetch data from remote servers. I used Hive to store the response loccally whenever a get request is successful. When the users device is not connected to the internet, cached data is retrieved and displayed until when there is an active connection or a successful get request.
Note: The data is stored for about an 1 hour locally and is cleared. 



# How to run the code using Visual Studio Code or Android Studio: 
- Open either of the IDE's mentioned above and open the project.
- Click on the play button in the IDE's toolbar. You can select a target device or emulator to run the app.

# To execute tests:
- locate the test in the project's test directory and click on either of the folders
- Right-click on the test file and select "Run" or "Run Test" from the context menu. 
