from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from .web3_client import get_all_accounts_with_balances,transfer_amount
from web3 import Web3



class AccountsView(APIView):
    def get(self, request):
        try:
            accounts_with_balances = get_all_accounts_with_balances()
            return Response({"accounts_with_balances": accounts_with_balances}, status=200)
        except Exception as e:
            return Response({"error": str(e)}, status=500)
        



        
class TransferView(APIView):
    def post(self, request):
        try:
            sender = request.data.get('sender')
            recipient = request.data.get('recipient')
            amount = int(request.data.get('amount'))  # Amount to transfer
            
            # Ensure the amount is positive and non-zero
            if amount <= 0:
                return Response({"error": "Amount must be greater than 0"}, status=400)

            tx_hash = transfer_amount(sender, recipient, amount)
            return Response({"tx_hash": Web3.toHex(tx_hash)}, status=200)
        
        except Exception as e:
            return Response({"error": str(e)}, status=500)        