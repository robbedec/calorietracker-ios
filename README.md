# Calorie tracker for IOS
## Getting started

These instruction will allow you to run a copy of the project on your local machine for development and testing

### Prerequisits

```
Xcode 10
Swift 4.2
```

### Installing

Clone the repository

```
git clone git@github.com:robbedec/calorietracker-ios.git
```

Open the **.xcworkspace** file in Xcode and build

### Dependencies

I have chosen to include the source code from the dependecies in this repository. There are some changes made to improve layout and accessibility in these files. **There is no further configuration necessary to manage the dependecies after cloning the repository.**

If for some reason you actually have to reinstall the dependencies, run this command: 

```
pod install
```

and update the source files manually using the commit history of this repository.

## Built with

* [CocoaPods](https://cocoapods.org/) - Dependency manager
* [Realm](https://realm.io/) - Persistence library for onboard database
* [Nutritionix](https://www.nutritionix.com/) - Public API and food database
* [UICircularProgressRing](https://github.com/luispadron/UICircularProgressRing) - Circular progress bar component for Swift

## Authors

* **Robbe Decorte**

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details
