// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TodoList {
    
    struct TodoItem {
        string task;
        bool isCompleted;
    }

    mapping (uint256 => TodoItem) public list;
    uint256 public count = 0;
    address public owner;
    event TaskCompleted(uint256 indexed id);
      event TaskDeleted(uint256 indexed id);

    constructor () {
        owner = msg.sender;
    }


//add a task in list
    function addTask(string calldata task) public {
        require(owner == msg.sender, "Only owner can call this");
        TodoItem memory item = TodoItem({ task: task, isCompleted: false });
        list[count] = item;
        count++;
    }


   //setting and checking if task is completetd or not
    function completeTask(uint256 id) public {
        require(owner == msg.sender, "Only owner can call this");
        if (!list[id].isCompleted) {
            list[id].isCompleted = true;
            emit TaskCompleted(id);
        }else{
         revert('task alreday completed');
     }
    }

//delete a  task
 function deleteTask(uint256 id) public {
        require(owner == msg.sender, "Only owner can call this");
        require(id < count, "Invalid task ID");
        
        // Move the last task to the deleted task's position and decrement the count
        list[id] = list[count - 1];
        delete list[count - 1];
        count--;
        
        emit TaskDeleted(id);
    }

    // get all todos
    function getAllTodos() public view returns (TodoItem[] memory) {
    TodoItem[] memory todos = new TodoItem[](count);
    for (uint256 i = 0; i < count; i++) {
        todos[i] = list[i];
    }
    return todos;
   }

  
}