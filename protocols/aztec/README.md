# Aztec

Aztec is a privacy-first zero-knowledge rollup on Ethereum: the only L2 built from the ground up to be fully privacy preserving.

They're using an encrypted UTXO based model. Changing ownership between parties of [insert digital asset], without needing to update the parties account balances.

To protect mutual privacy, Alice publishes the tx with a lock that she knows only Bob can unlock with his private key.

How do we know two parties won't collude to abuse the system? I guess the answer is to rub a _zero-knowledge proof_ on it. (I do not claim to know the math behind it, but ZKPs are supposed to allow Alice to prove to Bob that a given statement is true without conveying any additional information).

These notes that are issued to Aztec users are stored in a Merkle Tree. State updates are settled on Ethereum's main chain and the txs are deemed recorded.

The public can see deposits and withdraws, but the protocol keeps the rest private. Pretty cool.
