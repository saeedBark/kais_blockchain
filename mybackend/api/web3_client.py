import json
from web3 import Web3
import os

# Connect to Ganache
ganache_url = "http://127.0.0.1:7545"  # Update if your Ganache URL differs
web3 = Web3(Web3.HTTPProvider(ganache_url))

# Check connection
if not web3.is_connected():  # Updated method name
    raise Exception("Unable to connect to Ganache")

# Load contract ABI and address
def load_contract():
    current_dir = os.path.dirname(__file__)  # Get the directory of the current file
    contract_path = os.path.abspath(os.path.join(current_dir, '../../mytruffle/build/contracts/ExpenseManagerContract.json'))
    print("Resolved Contract Path:", contract_path)  # Print the resolved path for debugging

    print('start load')
    with open(contract_path) as f:
        contract_data = json.load(f)
    abi = contract_data['abi']
    contract_address = '0xE4Ee669F0425ca1c942FD9D1ac86414c44fe926c'  # Replace with your actual contract address
    return web3.eth.contract(address=contract_address, abi=abi)

# Function to fetch all accounts with balances and claculate percentage from Ganache
def get_all_accounts_with_balances():
    """Fetch all accounts from Ganache."""
    
    accounts = web3.eth.accounts
    accounts_with_balance = []
    for account in accounts:
        balance_wei = web3.eth.get_balance(account)
        balance_eth = web3.from_wei(balance_wei, 'ether')
        usage_percentage = ((100 - balance_eth) / 100) * 100  # Calculate percentage

        accounts_with_balance.append({
            "address": account,
            "balance":balance_eth,
            "usage_percentage": usage_percentage
        })
    return accounts_with_balance



# Function to transfer funds between two accounts
def transfer_amount(sender, recipient, amount):
    """Transfer funds between two accounts."""
    sender_account = web3.to_checksum_address(sender)
    
    
    print('sender_account', sender_account)
    recipient_account = web3.to_checksum_address(recipient)
    print('recipient_account', recipient_account)
    
    # Replace with your private key for the sender account
    
    
    sender_balance = web3.eth.get_balance(sender_account)
    print("Sender Balance:", web3.from_wei(sender_balance, 'ether'), "ETH")
    
    # Fund the sender account from another account
    funding_amount = web3.to_wei(2, 'ether')  # Fund with 10 ETH
    
    print(funding_amount)
    
    private_key =  '0x8d1f2849197c6b3269893ce6d98b0a257f23134935be40f7d7d710fc3fdb2a36'
    print('private_key', private_key)

    
    # Prepare transaction
    transaction = {
        'from': sender_account,
        'to': recipient_account,
        'value': web3.to_wei(amount, 'ether'),
        'nonce': web3.eth.get_transaction_count(sender_account),
        'gas': 21000,
        'gasPrice': web3.to_wei('20', 'gwei'),  # Correct usage of toWei
    }
    
    print('transaction:', transaction)

    # Sign transaction
    signed = web3.eth.account.sign_transaction(transaction, private_key)
    print('signed_transaction', signed)

    # Send transaction
    tx_hash = web3.eth.send_raw_transaction(signed.raw_transaction)
    print('Transaction Hash:', web3.to_hex(tx_hash))

    # Wait for the transaction receipt
    tx_receipt = web3.eth.wait_for_transaction_receipt(tx_hash)
    print('Transaction Receipt:', tx_receipt)

    return tx_hash



