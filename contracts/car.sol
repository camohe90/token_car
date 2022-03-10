//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Auto{

    struct autoTemplate{
        address owner;
        string [] checkEngine;
        string brand;
        uint256 year;
        string color;
        bool status;
        bool validKey;
        
    }

    mapping(string => autoTemplate) public autosCollection;

    
    function createCar(string memory _plate,string memory _date, string memory _brand, uint256 _year, string memory _color)public{
        require(!autosCollection[_plate].validKey, "Car already exits");
        //autosCollection[_plate] = autoTemplate(msg.sender,_brand, _year, _color, true, true);
        autosCollection[_plate].owner = msg.sender;
        autosCollection[_plate].checkEngine.push(_date); 
        autosCollection[_plate].brand = _brand;
        autosCollection[_plate].year = _year;
        autosCollection[_plate].color = _color;
        autosCollection[_plate].status = true;
        autosCollection[_plate].validKey = true;

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

    function addcheckEngineHistory(string memory _plate, string memory _date)public {
        require(autosCollection[_plate].status, "Car is not in circulation state");
        require(autosCollection[_plate].validKey, "Car do not exits");
        autosCollection[_plate].checkEngine.push(_date);

    }
        
    function checkEngineHistory(string memory _plate)public view returns(string[] memory){
        require(autosCollection[_plate].status, "Car is not in circulation state");
        require(autosCollection[_plate].validKey, "Car do not exits");
        return autosCollection[_plate].checkEngine;
        
    }

}

