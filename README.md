# Mame Coin (MAME) ERC-20 Token

This repository features **Mame Coin (MAME)**, a standard **ERC-20 fungible token** implemented in Solidity. Developed as a foundational project, it showcases core concepts of decentralized digital asset creation and management.

## Project Overview

This project serves as a hands-on learning experience in Solidity smart contract development, covering the essential functionalities required for an ERC-20 token.

## Key Features

* **Total Supply Management:** Defines a fixed total supply of MAME tokens ($1,000,000$ MAME with 18 decimal places).
* **Balance Tracking:** Securely records and retrieves token balances for individual Ethereum addresses (`balanceOf`).
* **Direct Transfers:** Enables users to send MAME tokens directly from their wallet to another (`transferCoin`).
* **Allowance Mechanism:** Allows token holders to authorize third-party addresses (spenders) to transfer a specified amount of their tokens (`izinTransfer` / `approve`).
* **Delegated Transfers:** Facilitates transfers of tokens from an owner's balance by an approved spender (`transferDari` / `transferFrom`).
* **Allowance Inquiry:** Provides a public function (`allowance`) to check the remaining authorized amount a spender can transfer.
* **Event Emission:** Emits `Transfer` and `Approval` events for transparent and verifiable transaction logging on the blockchain.

## Technical Stack

* **Solidity Version:** `^0.8.30`
* **Development Environment:** Remix IDE
* **Deployment Network:** Sepolia Test Network

## Deployed Contract

The Mame Coin (MAME) contract has been successfully deployed and verified on the Sepolia Test Network. You can inspect its code and transaction history directly on Etherscan:

**Contract Address:** `[PASTE ALAMAT KONTRAK ASLI ANDA DI SINI]`
[Link Etherscan Sepolia untuk kontrak Anda] (Contoh: `https://sepolia.etherscan.io/address/0x9f660a169a54967bfd0eca77c8e1c1ce5284315a`)

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---
