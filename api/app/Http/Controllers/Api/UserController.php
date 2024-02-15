<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use App\Models\Account;
use App\Models\Recipient;
use App\Models\Transaction;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{

  public function getUser() {
    $user = auth()->user();
    $user = User::where('id', $user->id)->with(['accounts', 'recipients'])->first();

    if(!$user) {
      return response()->json(['error' => 'User not found.'], 400);
    }

    return $user;
  }

  public function userAccounts()
  {
    $user = $this->getUser();

    $accounts = $user->accounts;

    return response()->json($accounts);
  }

  public function userAccount($id)
  {
    $user = $this->getUser();

    $account = $user->accounts()->where('id', $id)->first();

    if(!$account) {
      return response()->json(['error' => 'Account not found.'], 400);
    }

    return response()->json($account);
  }

  public function userRecipients() {
    $user = $this->getUser();

    $recipients = $user->recipients()->orderBy('name', 'asc')->get();

    foreach($recipients as $recipient) {
      $recipient->iban = $recipient->account->iban;
    }
   
    return response()->json($recipients);
  }
  
  public function userAccountTransactions($id) {
    $user = $this->getUser();

    $account = $user->accounts()->where('id', $id)->first();

    if(!$account) {
      return response()->json(['error' => 'Account not found.'], 400);
    }

    $transactions = $account->transactions()->with(['fromAccount', 'toAccount'])->orderBy('date', 'desc')->get();
    return response()->json($transactions);
  }

  public function userAddRecipient(Request $request) {
    $user = $this->getUser();

    $request->validate([
      'name' => 'required',
      'iban' => 'required',
    ]);

    $iban = str_replace(' ', '', $request->get('iban'));

    $account = Account::where('iban', $iban)->first();

    if(!$account) {
      return response()->json(['error' => 'Account not found with this IBAN'], 400);
    }

    if($user->recipients()->where('account_id', $account->id)->exists()) {
      return response()->json(['error' => 'Recipient already exists.'], 400);
    }

    $recipient = new Recipient([
      'name' => $request->get('name'),
      'account_id' => $account->id,
      'user_id' => $user->id,
    ]);

    $recipient->save();

    $recipient->iban = $recipient->account->iban;

    return response()->json($recipient);
  }

  public function userDeleteRecipient($recipient) {
    $user = $this->getUser();

    $recipient = $user->recipients()->where('id', $recipient)->first();

    if(!$recipient) {
      return response()->json(['error' => 'Recipient not found for this user. Can\t delete it'], 400);
    }

    $recipient->delete();

    return response()->json(['success' => 'Recipient deleted.']);
  }

  public function userAccountTransactionsCreate(Request $request) {
    $user = $this->getUser();

    if(!$user) {
      return response()->json(['error' => 'User not found.'], 400);
    }

    $request->validate([
      'from_account_id' => 'required',
      'to_account_id' => 'required',
      'amount' => 'required',
      'date' => 'required',
      'name' => 'required',
    ]);


    $fromAccountId = $request->get('from_account_id');
    $toAccountId = $request->get('to_account_id');

    if (!$user->accounts()->where('id', $fromAccountId)->exists()) {
      return response()->json(['error' => 'from_account_id is not possessed by the user'], 400);
    }

    $fromAccount = $user->accounts()->where('id', $fromAccountId)->first();
    
    $toAccount = Account::where('id', $toAccountId)->first();

    if(!$toAccount) {
      return response()->json(['error' => 'to_account_id does not exist'], 400);
    }


    $amount = $request->get('amount');

    if ($fromAccount->balance - $amount < 0) {
      return response()->json(['error' => 'from_account_id does not have enough money.'], 400);
    }

    $transaction = new Transaction([
      'from_account_id' => $fromAccountId,
      'to_account_id' => $request->get('to_account_id'),
      'amount' => $amount,
      'date' => $request->get('date'),
      'name' => $request->get('name'),
    ]);

    $transaction->save();
    
    $fromAccount->balance -= $amount;
    $fromAccount->save();

    $toAccount->balance += $amount;
    $toAccount->save();

    $transaction->load('fromAccount', 'toAccount');

    return response()->json($transaction);
  }
}
