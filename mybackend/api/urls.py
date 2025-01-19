from django.urls import path
from .views import AccountsView,TransferView

urlpatterns = [
    path('transfer/', TransferView.as_view(), name='transfer'),
    path('accounts/', AccountsView.as_view(), name='accounts'),

]
