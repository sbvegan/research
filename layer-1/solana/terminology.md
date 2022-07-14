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

### Writing Programs

Most programs are written with Rust or C++, but they can be developed with any language that targets the LLVM's BPF backend.

Most Rust-based programs follow this architecture:

|      File      |                  Description                  |
|:--------------:|:---------------------------------------------:|
| lib.rs         | Registering modules                           |
| entrypoint.rs  | Entrypoint to the program                     |
| instruction.rs | Program API, (de)serializing instruction data |
| processor.rs   | Program logic                                 |
| state.rs       | Program objects, (de)serializing state        |
| error.rs       | Program-specific errors                       |

**[Anchor](https://github.com/coral-xyz/anchor) has emerged as a popular framework for development.**

[Deploying Programs](https://docs.solana.com/cli/deploy-a-program)

## Transactions

Clients can invoke programs by submitting a transaction to a cluster. A single transaction can batch multiple instructions, each targeting its own program. Transaction instructions are processed by the Solana Runtime in order and atomically. Any part of an instruction failure will cause the entire tx to fail.

### Fact Sheet

- Instructions are the most basic operational unit on Solana
- Each instruction contains:
    - The `program_id` of the intended program
    - An array of all `accounts` it intends to read from or write to
    - An `instruction_data` byte array that is specific to the intended program
- Multiple instructions can be bundled into a single transaction
- Each transaction contains:
    - An array of all `accounts` it intends to read from or write to
    - One or more `instructions`
    - A recent `blockhash`
    - One or more `signatures`
- Instructions are processed in order and atomically
- Any part of an instruction failure, causes total failure
- Transactions are limited to 1232 bytes

### Deep Dive

- The Solana Runtime requires a specified list of all accounts the tx will interact with so it can parallelize execution across all txs
- It either returns success or failure which causes the tx to fail immediately
- Before submission, all txs must reference a recent blockhash to prevent duplication and eliminate stale transactions.

### Fees

The Solana collects two types of fees:

- Transaction fees (gas fees)
- Rent fees for storing data on-chain

Gas fees are deterministic (no fee market). At the moment the tx fees are determined only by the number of signatues required, not by the amount of resources used.

All transactions require at least one `writable` account to sign the transaction. This account is responsible for the cost of the tx.

Currently, 50% of tx fees are collected by the validator and the other 50% is burned.

## Program Derived Addresses (PDAs)

"Program Derived Addresses (PDAs) are home to accounts that are designed to be controlled by a specific program. With PDAs, programs can programmatically sign for certain addresses without needing a private key. PDAs serve as the foundation for Cross-Program Invocation, which allows Solana apps to be composable with one another."[2]

### Fact Sheet

- PDAs are 32 byte strings that look like public keys, but don’t have corresponding private keys
- `findProgramAddress` will deterministically derive a PDA from a programId and seeds (collection of bytes)
- A bump (one byte) is used to push a potential PDA off the ed25519 elliptic curve
- Programs can sign for their PDAs by providing the seeds and bump to invoke_signed
- A PDA can only be signed by the program from which it was derived
In addition to allowing for programs to sign for different instructions, PDAs also provide a hashmap-like interface for indexing accounts


## Sources

[1][Solana Docs | Terminology]([2][Cooking with Solana](https://solanacookbook.com/#contributing))
[2][Solana Cookbook](https://solanacookbook.com/core-concepts/accounts.html#facts)