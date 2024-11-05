# Social Wallet

## Introduction

This is a mobile app which has 3 main functionalities. The aim is that you, developers, build anything you want but focus on mobile devices using this repository as a base project.
The app is fetching data from [Vottun API's](https://docs.vottun.io/) including available networks. Also we use [Binance API](https://www.binance.com/es/binance-api) to get token rate to calculate fiat value of tokens in the wallet.
Another point to mention is that the tokens that are currently available are the network's native token and the Vottun Token ERC20.

## Smart Contracts

To manage **Shared Payments** we have create a smart contract that will manage approvals and payments when it comes to **Shared Payments**.
Contract supports **ERC20** and **native** tokens. You can find an example of the whole process in this [link](https://www.oklink.com/es-la/amoy/address/0xc44f5508861726198f3fea9aae78462c5d0423c6) 

## Wallet Overview

This wallet project aims to create a versatile social wallet that allows users to manage payments and shared transactions across multiple blockchain networks. The primary goal is to offer a smooth user experience for direct and shared payments, with features such as contact management, network selection, and wallet creation integrated into a cohesive mobile application.

## How does it work

The wallet enables users to create and manage their crypto wallets through Vottun’s API and interact with different blockchain networks for direct and shared payments. Users can log in, manage contacts, and perform payments while having access to payment history and configuration options for different networks. [Watch how the Vottun Social Wallet works](https://drive.google.com/file/d/1ofkR0mURowy2ocTogmz_qTUdBD4M3kO7/view)

## User Interface (Frontend):

Users interact with the Vottun platform through an interface that allows them to connect their wallet using a simple login or sign-up flow via an identity server. Once connected, users can see their available tokens, select a network, and perform payments (both direct and shared) by following intuitive steps.

## Wallet Creation:

When a user signs up or logs in, the system automatically creates a wallet using the Vottun API. A hash is generated and passed to Vottun’s Web-based Wallet Creation URL to establish the wallet, allowing immediate use for transactions.

## Contacts Management:

Users can add or remove contacts linked to their account for easy and quick payments. All contact information is securely stored and managed in the backend.

## Direct and Shared Payments:

Direct Payments allow users to send ERC and native tokens to their contacts using an OTP code for security. Shared Payments allow multiple users to contribute to a single transaction. This is managed by a smart contract on Vottun’s platform, where each user pays their share, and once all participants have paid, the funds are distributed to the recipient.

## Backend Operations:

The backend is responsible for handling all wallet interactions, including communication with smart contracts, contact management, and transaction history. Payments are processed and validated through the API and written into the SQLite database for future reference.
---
# What are we looking for?

## Objectives

The main objective of this Open Projects project is to enhance the existing social wallet by focusing on the following new features: 
**Which new features we would like to be added:**

1. **Payment with Other Tokens (USDT):** In this phase, the wallet will allow payments not only in the native network token but also with USDT, providing users with more flexibility in their transactions. This involves integrating the option to select USDT in the direct and shared payments processes in the different chains that the applications work on.
2. **Transaction History:** A new section will be added to the wallet where users can view a detailed history of all transactions, including both direct and shared payments. This will allow users to track their payments easily and have a clear record of past transactions.
3. **Stellar Network Integration (Lumens):** The wallet will integrate the Stellar network, enabling users to make payments using Lumens (XLM). This will expand the wallet’s functionality by allowing cross-network payments and further enhancing the wallet's versatility.
4. **Recurring or Scheduled Payments:** A new feature that will allow users to schedule payments at pre-set intervals (e.g., daily, weekly, monthly) or on specific dates. This is useful for automating regular payments such as subscriptions or repetitive transfers.

## Scope of Work

**Frontend Development:**

- **USDT Payments:** Build a user-friendly interface that enables users to select USDT as a payment option, along with the existing native tokens.
- **Transaction History:** Create a section that displays a clear and concise history of all user transactions, including amounts, timestamps, and token types.
- **Stellar Integration:** Add Stellar (XLM) support to the network selector, allowing users to toggle between native tokens, ERC20 tokens, and Stellar Lumens.
- **Recurring Payments:** Develop an interface for users to schedule recurring payments, providing options for frequency (daily, weekly, etc.), token selection, and payment amounts.
  
**Backend Development:**
- **Token Payments & USDT Support:** Implement backend functionality to handle token selection and enable payments in USDT, ensuring smooth transaction flow and validation.
- **Transaction History Tracking:** Implement a backend system for logging and retrieving transaction records. Ensure accurate data storage using SQLite or another database solution.
- **Stellar Payments:** Enable communication with the Stellar network for sending and receiving Lumens. Ensure compatibility with the wallet's payment processes.
- **Recurring Payments Logic:** Set up backend logic to support the automation of recurring payments, including tracking schedules and processing transactions at defined intervals.

**Smart Contract Development & Integration:**
- **USDT Payments:** Update the existing smart contracts to handle payments in USDT, ensuring proper integration with the wallet’s payment flows.
- **Stellar Compatibility:** Ensure smart contracts are compatible with Stellar’s Lumens for payment transactions.
- **Recurring Payments:** Update the smart contracts to handle recurring payments, ensuring that funds are deducted automatically based on the user-defined schedule.

## Deliverables:
The development of the following new features is expected:
1. **USDT Payments Functionality:**
   - A fully functional wallet interface and backend that allows users to make payments using USDT alongside native tokens.
2. **Transaction History Feature:**
   - A front-end interface displaying a transaction history.
   - Backend support for storing and retrieving transaction data accurately.
3. **Stellar Network Integration:**
   - Front-end and back-end integration of Stellar, enabling payments using Lumens (XLM).
   - User interface updates to support network selection for Stellar and other supported tokens.
4. **Recurring Payments Feature:**
   - A front-end interface for users to schedule and manage recurring payments.
   - Backend support for tracking payment schedules and processing payments automatically.
   - Smart contract integration to handle the automation of recurring payments.

## How to Participate in the Vottun Social Wallet Project

To start contributing to the Vottun Social Wallet project, follow these steps:

1. **Fork the repository:** Create a personal copy of the project repo to work on.
2. **Work on one or more deliverables:** Focus on developing the defined features or improvements.
3. **Submit a pull request (PR):** Once your development is complete, submit a PR for evaluation.
4. **Cooperate!:** You may need to collaborate with other contributors for different parts of the project.
5. **Approval process:** If approved, your code will be merged into the main project repository.
6. **Receive rewards:** Based on the established conditions and milestones, you will receive the agreed rewards upon successful contribution.

## SQLite

The app uses an on-device database like SQLite to store information (It has been used to build this proof of concept without backend). It must be changed and use a database in the backend to store all the information. 
You can keep some info in SQLite like access token or any information that you consider important while user is logged. 
You can find database models under `lib/models/db/`.

We use [database_helper.dart](lib/services/local_db/database_helper.dart) to insert some mock users. Also we fetch [custodied wallets list](https://docs.vottun.io/api/custodied-wallets#get-customer-custodied-wallets) to check if user has already created a wallet under our **Vottun API Key**.
If user has already created a wallet, we insert to our databases needed information like wallet address and strategy chosen by the user or any other info you want.
In this file you will find methods that read and write data from SQLite database. This can be on the backend, but for a Proof of Concept is the perfect solution.
This is our approach, feel free to configure other external database, registration and login flow or creation wallet flow.

## ConfigProps

This file [config_props.dart](lib/utils/config/config_props_example.dart) (just remove **_example** from file name to make it work), 
contains all needed environment variables to make API calls to **Vottun API's**. 
Also contains **contractSpecsId** which refers to the **id** linked to the smart contract that you previously uploaded to **Vottun Platform**

## Flutter Bloc

Code architecture uses [Flutter Bloc](https://bloclibrary.dev/) to separate data presentation from business logic to make code fast, easy to test and reusable.
We use [Cubit](https://bloclibrary.dev/bloc-concepts/#cubit) approach instead Bloc. You will find `cubit` folders under `lib/views/...` where we store cubit classes. Name definition is: `file_name_cubit.dart` and `file_name_state.dart`.
The `..._cubit.dart` does api calls through repository classes and also emits responses to the UI class file where we have a [BlocBuilder](https://bloclibrary.dev/flutter-bloc-concepts/#blocbuilder) to listen this changes.
The `..._state.dart` stores definition of the properties that we want to have available when listen responses from the UI class file.

## GetIt (Dependency Injection)

We use [GetIt](https://pub.dev/packages/get_it) to have any utility class or bloc/cubit component accessible from anywhere in the app. You can compare it with dependency injection.
To see examples how to use GetIt go to [injector.dart](lib/di/injector.dart)

## Shared Preferences

To store data in the device, we use [shared preferences](https://pub.dev/packages/shared_preferences) plugin for flutter. 
We have a [base class](lib/services/local_storage/key_value_storage_base.dart) where we initialize shared preferences and define some methods to have a better interaction with this library.
Then we have the [service class](lib/services/local_storage/key_value_storage_service.dart) where we will define get and set methods to fetch and save the data that we want to keep at device level.
Then we initialize base class in the [main class](lib/main.dart) and service class in the [injector.dart](lib/di/injector.dart) file.

## Endpoints

Definition of endpoints can be found at [api_endpoint.dart](lib/services/network/api_endpoint.dart).

## App Language and Translate

To keep literals shown in the app well organized, we use [intl](https://pub.dev/packages/intl) and [intl_translation](https://pub.dev/packages/intl_translation). This two plugins allow us to have translations.
Furthermore, we use [GetIt](https://pub.dev/packages/get_it) to simplify access to the literals that we define at [app_localization.dart](lib/utils/locale/app_localization.dart). At the top of the file you fill the commands needed to generate translations.


## Login and Sign Up

Sign Up is a custom registration that has to be done by developer. Login has to be done against the identity server that developer configured previously.
When it comes to create a wallet we do it using [Vottun API](https://docs.vottun.io/api/custodied-wallets#abstract) **get new hash** endpoint to create a hash that will allow us to create a new wallet using **Vottun Web-based Wallet Creation**, 
this is the url to be passed along with previously created has and user email => [https://wallet.vottun.io/?hash={received-hash}&username={user-email}](https://wallet.vottun.io/?hash={received-hash}&username={user-email}).
Feel free to configure a registration and login flow as well as a creation wallet flow. You can create the wallet when user register on your identity server or show a button that opens **Web-based Wallet Creation** when user has no wallet linked to his account.
Currently sign up neither login has **not** configured an identity server.

## Network Selector

Reusable [component](lib/views/widget/network_selector.dart) to select available networks and also has an option to show available tokens depending on the selected network.

## Contacts

Contacts are mainly Vottun users that are registered on the same customer account (wallets created under the same API key and app_id).
You can add and delete contacts. This info is also saved in SQLite and should be in the backend.

## Direct Payments

**Direct Payments** are as simple as the name. You can transfer ERC and Native tokens to other contacts using an OTP code.

## Shared Payments

**Shared Payments** uses a Smart Contract previously uploaded to Vottun platform. We read and write to the SC using Vottun API's.

### Shared Payment creation workflow:

1. Define recipient of the **remove unused import Shared Payment**, could be who create the **Shared Payment** or a contact that the **Shared Payment** creator decide.
2. Choose token which users will have to use to complete the **Shared Payment**. Final payment will be received also in the token defined.
3. Define total amount of the **Shared Payment**.
4. Choose users among your contacts and the amount to pay.
5. Create **Shared Payment** using OTP code. Data will be written in the Smart Contract.

### Shared Payment process from participant view:

1. Approve payment assigned to user using OTP code.
2. Do payment using OTP code.

Once all the participants of the **Shared Payment** has done the payment (this is checked within smart contract), 
the recipient of the shared payment will be able to execute a function that will transfer tokens from the smart contract to recipient wallet.

## Payment History

Every **Direct** and **Shared Payment** are saved when are completed. They are stored in SQLite database and should be saved in the backend.

## Configuration

From Configuration you can toggle networks between Mainnet and Testnet.


