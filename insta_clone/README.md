# InstaClone

Clone of instagram stories.
Developed with Flutter and using the Bloc Pattern.

## Project Structure

### Screens Directory

Contains screens.

### Models Directory

Contains models (User and Story) that are used to parse data coming from `data.json`.

### Services Directory

Here are some functions for fetching and streaming data

### Widgets Directory

Here are some widgets used on the screens

### Bloc Directory

Story's bloc structure, event and state

#### Events and States

* `NextStoryEvent`
* `PrevStoryEvent`
* `NextUserEvent`
* `PrevUserEvent`
* `WatchStoryEvent`
* `PauseStoryEvent`
* `ResumeStoryEvent`  
* `NoNextStoryState`
* `NoPrevStoryState` 
* `NoNextUserState`
* `NoPrevUserState`
* `AllStoriesWatchedState`
