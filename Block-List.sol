// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Tracklist {

    // Structure for each task
    struct Task {
        string description;
        bool completed;
        uint256 timestamp;
    }

    Task[] public tasks;   // dynamic list of tasks
    address public owner;  // contract owner

    constructor() {
        owner = msg.sender;  // whoever deploys the contract becomes the owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    /// Add a new task to the daily checklist
    function addTask(string memory _description) external onlyOwner {
        tasks.push(
            Task({
                description: _description,
                completed: false,
                timestamp: block.timestamp
            })
        );
    }

    /// Mark a task as completed (but never delete or modify it)
    function markCompleted(uint256 _taskIndex) external onlyOwner {
        require(_taskIndex < tasks.length, "Invalid task index");
        tasks[_taskIndex].completed = true;
    }

    /// Get total number of tasks added
    function getTaskCount() external view returns (uint256) {
        return tasks.length;
    }
}
