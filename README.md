# Water Bucket Challenge

This project is a flutter application that solves the water bucket problem.  The app uses Breadth-First Search (BFS) algorithm to explore all possible states from the initial state (both buckets empty) until goal state is reached (one of the buckets contains Z gallons of water). Each state represents the amount of water in both buckets at any step, and the transition happens according to allowed steps.

The algortihm uses these optimization technigues:
- Queue: Use a queue data structure to keep track of the states to explore.
- BFS: Start from the initial state and perform a breadth-first search, exploring states level by level until reaching the goal state. This guarantees finding the shortest path to the goal state.
- Optimization: Implements memoization to avoid revisiting already explored states.

## Supported Platforms

The app suppords iOS, Android, Web, macOS, Windows, and Linux.  In iOS and Android, the app supports both portrait and landscape modes.

## Usage

Please follow these commands to run the app.

### Get Depndencies

To get dependencies, use the following command:

```bash
flutter pub get
```

### Run Tests

To run both unit and widget tests, use the following command:

```bash
flutter test
```

### Run The App

To run the app on your selected device, use the following command:

```bash
flutter run
```

### Constraints

The app only accepts integers for Bucket X, Bucket Y, and Target Amount.  If a non-integer is entered in one of the fields OR a field is left blank, the app will prompt to correct the input.  




