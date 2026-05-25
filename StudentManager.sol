// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentManager {

    // 1. Define the Student struct
    struct Student {
        uint256 id;
        string name;
        uint256 age;
        string department;
        bool exists; // Helper flag to check if the student exists
    }

    // Mapping from Student ID to Student details
    mapping(uint256 => Student) private students;

    // Events to log changes on the blockchain (great for debugging and UI)
    event StudentAdded(uint256 indexed id, string name, uint256 age, string department);
    event StudentUpdated(uint256 indexed id, string name, uint256 age, string department);

    // 2. Function to add a new student's data
    function addStudent(
        uint256 _id, 
        string memory _name, 
        uint256 _age, 
        string memory _department
    ) public {
        // Ensure the student ID is not already taken
        require(!students[_id].exists, "Student with this ID already exists.");
        // Ensure name and department aren't empty strings
        require(bytes(_name).length > 0, "Name cannot be empty.");
        require(bytes(_department).length > 0, "Department cannot be empty.");

        // Store the student data
        students[_id] = Student(_id, _name, _age, _department, true);

        emit StudentAdded(_id, _name, _age, _department);
    }

    // 3. Function to update an existing student's data
    function updateStudent(
        uint256 _id, 
        string memory _name, 
        uint256 _age, 
        string memory _department
    ) public {
        // Requirement: Ensure data is only updated if the student exists
        require(students[_id].exists, "Student does not exist.");
        require(bytes(_name).length > 0, "Name cannot be empty.");
        require(bytes(_department).length > 0, "Department cannot be empty.");

        // Update the student data
        students[_id].name = _name;
        students[_id].age = _age;
        students[_id].department = _department;

        emit StudentUpdated(_id, _name, _age, _department);
    }

    // 4. Function to retrieve a student's data (Needed for your Remix testing/screenshots!)
    function getStudent(uint256 _id) public view returns (
        uint256 id, 
        string memory name, 
        uint256 age, 
        string memory department
    ) {
        // Requirement: Ensure data is only accessed if the student exists
        require(students[_id].exists, "Student does not exist.");
        
        Student memory s = students[_id];
        return (s.id, s.name, s.age, s.department);
    }
}
