# Solana Core Terminology

## Accounts

Accounts are a record in the Solana ledger that either holds data or is an executable program. They are addressable by a key.

The key may be:

- an ed25519 public key
- a program-derived account address (32byte value forced off the ed25519 curve)
- a hash of an ed25519 public key with a 32 character string

### Account Model

There are three kinds of accounts (I'm not 100% sure how they match up in the section above yet):

- Data accounts store data
- Program accounts store executable programs
- Native accounts that indicate native programs on Solana (such as System, Stake, and Vote)

Within data accounts there are two types:

- System owned accounts
- PDA (Program Derived Address) accounts

### Account field list

|  **Field** |                   Description                  |
|:----------:|:----------------------------------------------:|
| lamports   | The number of lamports owned by this account   |
| owner      | The program owner of this account              |
| executable | Whether this account can process instructions  |
| data       | The raw data byte array stored by this account |
| rent_epoch | The next epoch that this account will owe rent |

### Ownership rules

- Only a data account owner can modify its data and debit lamports
- Anyone is allowed to credit lamports to a data account
- The owner of an account may assign a new owner if the account's data is zeroed out

### Rent

Storing data on accounts costs SOL to maintain: rent must be paid. Maintaining a minimum balance of 2 years of rent payments in an account makes you exempt.

Rent is paid during:

1. When referenced by a transaction
2. Once an epoch

A percentage of rent collected by accounts is destroyed, while the rest is distributed to vote accounts at the end of every slot. 

**If the account does not have enough to pay rent, the account will be deallocated and the data removed.**

## Programs

Programs, smart contracts on other chains, power the application layer on top of Solana.

### Fact Sheet

- Programs process instructions from both end users and other programs
- They're stateless, data they interact with is stored in separate accounts
- Programs are stored in accounts marked as `executable`
- All programs are owned by the `BPF Loader` and executed by the `Solana Runtime`
- Developers usually write programs in Rust of C++, but can choose any language that targets the LLVM's BPF backend
- All programs have a single entry point where instruction processing takes place, parameters always include:
    - program_id : pubkey
    - accounts : array
    - instruction_data : byte array

***Code is seperate from data***

### Native Programs & The Solana Program Library (SPL)

Solana comes equipped with a number of programs that serve as core building blocks for on-chain interactions. They're divided into:

- Native Programs
- Solana Program Library (SPL) Programs

Notably, the `System Program` is responsible for administering new accounts and transferring SOL between two parties. There are other SPL Programs that support a number of on-chain activities.

Most Rust-based programs follow this architecture:

|      File      |                  Description                  |
|:--------------:|:---------------------------------------------:|
| lib.rs         | Registering modules                           |
| entrypoint.rs  | Entrypoint to the program                     |
| instruction.rs | Program API, (de)serializing instruction data |
| processor.rs   | Program logic                                 |
| state.rs       | Program objects, (de)serializing state        |
| error.rs       | Program-specific errors                       |



### Writing Programs



## Transactions

## Program Derived Addresses (PDAs)

## Sources

[1][Solana Docs | Terminology]([2][Cooking with Solana](https://solanacookbook.com/#contributing))
[2][Solana Cookbook](https://solanacookbook.com/core-concepts/accounts.html#facts)