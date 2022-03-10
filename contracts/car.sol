//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Auto{

    struct autoTemplate{
        address owner;
        string brand;
        uint256 year;
        string color;
        bool status;
        bool validKey;
    }

    mapping(string => autoTemplate) public autosCollection;

    
    function createCar(string memory _plate, string memory _brand, uint256 _year, string memory _color)public{
        require(!autosCollection[_plate].validKey, "Car already exits");
        autosCollection[_plate] = autoTemplate(msg.sender, _brand, _year, _color, true, true);
    }

    function updateCar(string memory _plate, string memory _color)public{
        require(autosCollection[_plate].status, "Car is not in circulation state");
        require(autosCollection[_plate].validKey, "Car do not exits");
        autosCollection[_plate].color = _color;
    }
    
    function removeCirculation(string memory _plate)public{
        require(autosCollection[_plate].status, "Car is not in circulation state");
        autosCollection[_plate].status = false;
    }

    function transferCar(string memory _plate, address to)public{
        require(msg.sender == autosCollection[_plate].owner);
        autosCollection[_plate].owner = to;

    }

}

