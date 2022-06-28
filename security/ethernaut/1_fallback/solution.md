# Solution

## Problem 

To complete this level you must:

1. you claim ownership of the contract
2. you reduce its balance to 0

## Solution

**Step 0:** Create an instance of the contract.

There are two places in the code where you can become the owner. One requiring over 1000ETH and the other being in the `fallback` function (the title of the level).

So we need to figure out how to call the `fallback` function, but first we need to fullfil the require statement's conditions:

```
require(msg.value > 0 && contributions[msg.sender] > 0);
```

So we need to send some amount of ETH greater than zero and we need to have already contributed to the contract. Let's fulfil these parameters.

**Step 1:** Contribute to the contract, but remember the contribute function requires contributions to be less than 0.001ETH.

```
contract.contribute(toWei("0.0008"))
```

Now we've fulfilled one of the `fallback` functions conditions. Next up, is to call the `fallback` function with the other condition met (sending a value of ETH greater than 0).

**Step 2:** Call the `fallback` function. This is how we can send ether to the contract (I bet there are other ways as well).

```
contract.sendTransaction({
    from: player,   
    to: contract, 
    value: toWei("0.1")
})
```

*note:* player, contract, and toWei are all available in the console.

**Step 3:** Withdraw the ether from the contract. When the fallback function is successfully called, the player address (yours) becomes the owner. As the owner you have the priviledge of calling the `withdraw` function.

```
contract.withdraw()
```

**Step 4:** Submit the instance.