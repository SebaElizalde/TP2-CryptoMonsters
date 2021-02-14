// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract MonsterFactory is Ownable {
    
    uint16 dnaModulus = 65535;
    uint createFee = 0.001 ether;
    uint randNonce = 0;
    
    event NewMonster(uint monsterId, uint16 dna);

    struct Monster {
        uint price;
        bool sellable;
        uint16 dna;
    }
    
    Monster[] public monsters;
    
    mapping (uint => address) public monsterToOwner;
    mapping (address => uint) internal ownerMonsterCount;
    
    modifier onlyOwnerOf(uint _monsterId) {
        require(msg.sender == monsterToOwner[_monsterId]);
        _;
    }
    
    modifier tokenExists(uint tokenId) {
        require(tokenId >= 0 && tokenId <= monsters.length);
        _;
    }

    function _createMonster(uint16 _dna) private {
        uint price = _dna * 100000000000000 + 1000000000000000;
        monsters.push(Monster(price, false, _dna));
        uint id = monsters.length - 1;
        monsterToOwner[id] = msg.sender;
        ownerMonsterCount[msg.sender]++;
        emit NewMonster(id, _dna);
    }
    
    function _generateDna(address _sender) private returns(uint16){
        randNonce++;
        uint rand = uint(keccak256(abi.encodePacked(_sender, randNonce)));
        return uint16(rand % dnaModulus);
    }
    
    function createMonster() external payable {
        require(msg.value >= createFee && ownerMonsterCount[msg.sender] == 0);
        _createMonster(_generateDna(msg.sender));
    }
    
    function setCreateFee(uint _fee) external onlyOwner {
        createFee = _fee;
    }
    
    function getCreateFee() external view returns(uint) {
        return createFee;
    }
    
    function makeMonsterSellableForPrice(uint _price, uint _id) external onlyOwnerOf(_id){
        monsters[_id].price = _price;
        monsters[_id].sellable = true;
    }
    
    function makeMonsterSellable(uint _id) external onlyOwnerOf(_id){
        monsters[_id].sellable = true;
    }
    
    function getMonstersByOwner(address _owner) public view returns(uint[] memory) {
        uint monsterCount = ownerMonsterCount[_owner];
        uint[] memory result = new uint[](monsterCount);
        if (monsterCount == 0) {
            return result;
        }
        uint counter = 0;
        for (uint i = 0; i < monsters.length; i++) {
          if (monsterToOwner[i] == _owner) {
            result[counter] = i;
            counter++;
          }
        }
        return result;
    }
    
    function dnaToId(uint16 _dna) public view returns(uint) {
        for (uint i = 0; i < monsters.length; i++) {
          if (monsters[i].dna == _dna) {
            return i;
          }
        }
        return 65535;
    }
    
    function getMonsterCount() public view returns(uint) {
        return monsters.length;
    }

}