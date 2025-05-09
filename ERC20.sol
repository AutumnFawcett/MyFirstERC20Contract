//SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    string constant public name = "MyTokenName";
    string constant public symbol = "MTN";
    uint8 constant public decimals = 18;

    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;

    mapping (address => mapping(address => uint256)) public allowance;

    function transfer(address to, uint256 value) external returns (bool) {
        
        return _transfer(msg.sender, to, value);
    }

    function giveMeOneToken() external {
        balanceOf[msg.sender] += 1e18;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(allowance[from][msg.sender] >= value, "ERC20: Insufficient Allowance"); 
        
        allowance[from][msg.sender] -= value;
        
        emit Approval(from, msg.sender, allowance[from][msg.sender]);

        return _transfer(from, to, value);
    }

    function _transfer(address from, address to, uint256 value) private returns (bool) {
        require(balanceOf[from] >= value, "ERC20: Insufficient sender balance");

        emit Transfer(from, to, value);

        balanceOf[from] -= value;
        balanceOf[to] += value;

        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        allowance[msg.sender][spender] += value;

        emit Approval(msg.sender, spender, value);

        return true;
    }
}






