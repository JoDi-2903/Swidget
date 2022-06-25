# Swidget
Semester project for Swift lecture at DHBW in 2022.
<br/>
<h2>Short description</h2>
The app 'Swidget' was developed to present the WidgetKit and its functionalities as an example. The aim of the project is not to create an AppStore-ready application, but to present the framework in a demo. As content for the widgets and general theme movies were chosen, which are provided by the open 'The Movie Database' (TMDB) API. This app contains four pages and seven widgets, divided into three widget groups.

<h2>Feature overview</h2>
The app offers a selection of seven different widgets in total, in three thematic widget groups. The first group "Random Movie" displays randomly selected movies throughout the day and invites you to discover new movies. The widget is available in small and medium sizes and updates every hour. The second widget group is titled "Rewind Time" and offers a look back at movies that were released exactly on this day 3, 5, 7, 10, 12, 15, 20, 25 and 30 years ago. The date refers to the release in the USA. The movies change automatically throughout the day, starting with "3 years ago" in the morning and ending with "30 years ago" in the evening. This widget has the Reload policy .atEnd and is already scheduled at 0 o'clock of a day, for the whole day in a timeline ahead. The Rewind widget is available in three different sizes (small, medium and large) and offers more or less detailed information about the movie, depending on the available display space. The third widget group "Movie Overview" uses the dynamic IntentConfiguration and thus allows the user to configure the widget. Here, both the category (Top Rated, Popular, Now Playing, Upcoming) and the display language (English, German) of the title and cover image can be set from a predefined selection. This group includes medium and large sizes and updates its data once every hour. All widgets use DeepLinks to link directly from the widgets to the associated movie detail page in the app. For the "Movie Overview" group, it is also possible to select each movie in the list individually and be redirected to the correct detail page. With the widgets implemented in Swidget, all widget sizes available on the iPhone, static/dynamic configurations, various reload policies and deep links are exemplified.
<br/><br/>
Away from the widgets, there are four pages in the app. The home page includes a brief description about the project, as well as TMDB's identification as the source of the content. In addition, the home page contains a quick guide to adding widgets to the home screen. On the Movie-Overview page are four horizontal scrollviews containing the movie covers of the four categories (Top Rated, Popular, Now Playing, Upcoming). These ScrollView elements link directly to the details page of the corresponding movie. This page contains specific information about genre, length, content, rating, release, actors involved, producers, link to trailer, etc. The fourth page is the search function. Here you can search the entire TMDB movie database using a free text field and several search terms. The hits are displayed in a list and also link directly to the detail page.

<h2>Screenshots</h2>

![01_Overview_of_the_four_app_views](https://user-images.githubusercontent.com/88625959/175783758-01b9d7d3-d927-4121-b724-dedcdb741349.png)

<b>Figure 1:</b> <i>Overview of the four app views</i>
<br/><br/>

![02_Widget-Gruppen in der Widget Gallery](https://user-images.githubusercontent.com/88625959/175783568-ae1c9018-446a-48fc-8287-7a545e901d1b.png)

<b>Figure 2:</b> <i>Widget groups in Widget Gallery</i>
<br/><br/>

![03_Widgets verteilt auf dem Home Screen](https://user-images.githubusercontent.com/88625959/175783603-33c441f7-90bd-457c-8cf4-f3d413bc2766.png)

<b>Figure 3:</b> <i>Widgets on the Home Screen</i>
<br/><br/>

![06_Sample arrangement on iPad](https://user-images.githubusercontent.com/88625959/175783617-a86e4a54-38d3-406f-9394-1da21d7e549a.png)

<b>Figure 4:</b> <i>Sample arrangement on iPad</i>
