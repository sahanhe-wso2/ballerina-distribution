import ballerina/io;

final int[] & readonly intArr = [4, 2, 10, 8, 6];

isolated function f1(int[] arr) returns int[] {
    return arr.sort();
}

function f2(int[] arr) returns int[] {
    return arr.sort();
}

isolated function f3() {
    // An isolated start action is allowed in an isolated function
    // Here, the strand created by the start action will run in a separate thread
    future<int[]> _ = start f1([4, 2, 8, 6]);
}

isolated function f4() {
    // named worker is allowed in an isolated function
    // Here, the strand created by a named worker can run on a separate thread
    worker A {
        int[] _ = f1(intArr);
    }
}

function f5() {
    future<int[]> _ = start f1([4, 2, 8, 6]);
}

function f6() {
    worker A {
        int[] _ = f2(intArr);
    }
}

public function main() {
    // f3 is inferred to be isolated
    io:println(f2 is isolated function (int[]) returns int[]);
    // f5 is inferred to be isolated
    io:println(f5 is isolated function ());
    // f6 is inferred to be isolated
    io:println(f6 is isolated function ());
}
