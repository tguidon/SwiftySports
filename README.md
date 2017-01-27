# SwiftySports
### ⚽️🏀🏈⚾️🎾🏒
A collection of scalable UIViews displaying top down drawings of various fields/arenas/courts.

*Slowly adding in some of the most popular sports before putting together into a framework.*

### 🤔 Goals/Thoughts
- Learn more about drawing views.
- Make something scalable
- Sports are fun to code
- Create something for CocoaPods

Inspired by [HockeyView](https://github.com/tguidon/HockeyView)

### 🔨 Installation Instructions
🚨Work in progress til done.🚨

1. Make UIView any width and set ratio based on table below. ratio of 40:17
2. Make class your desired SwiftySport view.
3. Drag outlet from Storyboard into your ViewController.
4. Add `SwiftySport.dataSource = self` and `SwiftySport.drawToScale()` to your `viewDidLoad()`.
3. Set width in dataSource method

SwiftySport view's themes can be changed as vars of the view. See tables below for more info.

**Ratios**

I need to rework this to be more sectional. Each rink/court/field should have its own section to discuss theming, modifications, and unique featuers.

| Type             | Ratio     |
| ---------------- |:---------:|
| Hockey rink      | 40:17     |
| Tennis Court     | 13:6      |
| Soccer Field     | 105:68    |


**Themes**

| IceRinkView    | TennisCourtView | SoccerFieldView  |
| -------------- | --------------- | ---------------- |
| iceColor       | courtColor      | fieldColor       |
| redLineColor   | lineColor       | lineColor        |
| blueLineColor  |                 |                  |
| boardColor     |                 |                  |
| creaseColor    |                 |                  |


### 📜 Todos
##### Major
- [ ] Make into Framework
- [ ] Set up CocoaPods

##### Main
- [X] Add tennis court
- [X] Add soccer field
- [ ] Add football field
- [X] Add basketball court
- [ ] Add baseball field...
