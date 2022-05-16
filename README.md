# find_home

This project is built with Flutter 2.10.3 using Provider Approach as a state management with design MVVM pattern.
The App starts with a splash screen that shows the logo, then onboarding screens that appears only at the first time of opening the app (after installing the app to the first time). The app contains 3 main screens, the first one shows the homes and their details in a list that is retrieved from Firebase firestore. This screen enables the user to filter the homes list based on the home Type (for rent, for sale), or based on the city the home is located in, or both together (filter options by city are saved locally). The second Screen is the Map, in this screen the current location of the user is viewed on Map (the red location pin), in addition to the homes, and the homes' locations are defined by retreiving the predefined Latitude and Longitude values for each home in the firebase (the green location pins).
The Last screen shows the Favourites homes ads that the user added in the homes List screen.

I used the that orange color (#FF9900) inspired by " Alt Shift Creative " Logo color, and used with it the light grey color based on Material Design Colors Palette, and the simple easy to use design inspired from the PDF file you provided in the task email.
I used the MVVM design patterns duo to it's clear architecture that makes the code readable, testable, and easy to understand, with the provider appraoch as a state management, instead of using stateful widget that consumes memory and time in rebuilding the whole widget when the state changes by calling setState, so instead of that random rebuilding issue, using provider approach and consumers let us to controlling the exact section that needs to be rebuilt. Another reason to use Provider is that stateful widget consumes memory and time in forwarding arguments between widgets when navigating, in sometime the widget itself doesn't depend on that data, it's only used as a path to pass these arguments through!

Eng.Rahaf Malas
Computer Engineer
malasrahaf1@gmail.com
0787823447

16/5/2022