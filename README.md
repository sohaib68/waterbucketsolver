# Water Bucket Challenge

This project is a flutter application that solves the water bucket problem.  The app uses Breadth-First Search (BFS) algorithm to explore all possible states from the initial state (both buckets empty) until goal state is reached (one of the buckets contains Z gallons of water). Each state represents the amount of water in both buckets at any step, and the transition happens according to allowed steps.

The algortihm uses these optimization technigues:

- Queue: Use a queue data structure to keep track of the states to explore.

- BFS: Start from the initial state and perform a breadth-first search, exploring states level by level until reaching the goal state. This guarantees finding the shortest path to the goal state.

- Optimization: Implements memoization to avoid revisiting already explored states.


## Usage

### Run the Server

To run the server, use the following command:

```bash
make run
```

The server will start on `http://localhost:8090`.

### Build the server

To build the server binary, use the following command:

```bash
make build
```

### Test the server

To run tests, use the following command:

```bash
make test
```

### Delete the binary

To delete the server binary, use the following command:

```bash
make clean
```

## API Endpoints

The API has different versions and serves adaptive cards based on their versions and IDs.

- `http://localhost:8090/api/other/{adaptivecardid}`
- `http://localhost:8090/api/v1.5_public/{adaptivecardid}`

Replace `{adaptivecardid}` with the desired adaptive card sample json filename without json extension.

For example: `http://localhost:8090/api/v1.5/inputform` will serve up contents of InputForm.json file.





