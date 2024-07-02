# Social Wallet by Vottun S.L




## Warning


## Introduction

This is a mobile app which has 3 main functionalities. The aim is that you, developers, build anything you want but focus on mobile devices using this repository as a base project.
The app is fetching data from [Vottun API's](https://docs.vottun.io/) including available networks. Also we use [Binance API](https://www.binance.com/es/binance-api) to get token rate to calculate fiat value of tokens in the wallet.
Another point to mention is that the tokens that are currently available are the network's native token and the Vottun Token ERC20.

## Smart Contracts

To manage **Shared Payments** we have create a smart contract that will manage approvals and payments when it comes to **Shared Payments**.
Contract supports **ERC20** and **native** tokens. You can find an example of the whole process in this [link](https://www.oklink.com/es-la/amoy/address/0xc44f5508861726198f3fea9aae78462c5d0423c6) 

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


