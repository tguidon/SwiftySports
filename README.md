# SwiftySports
### ⚽️🏀🏈⚾️🎾🏒
A collection of scalable UIViews displaying top down drawings of various fields/arenas/courts.

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

| Type            | Ratio      |
| --------------- |:----------:|
| Hockey rink     | 40:17      |
| Hockey rink     | 40:17      |
| Hockey rink     | 40:17      |
| Hockey rink     | 40:17      |
| Hockey rink     | 40:17      |

**Themes**

IceRinkView

| var            | Ratio      |
| --------------- |:----------:|
| iceColor     | 40:17      |
| rinkRed     | 40:17      |
| rinkBlue     | 40:17      |
| boardColor     | 40:17      |


### 📜 Todos
##### Major
- [ ] Make into Framework
- [ ] Set up CocoaPods

##### Main
- [ ] Add tennis court
- [ ] Add soccer field
- [ ] Add football field
- [ ] Add basketball court
- [ ] Add baseball field...
