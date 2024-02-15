<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProfileUpdateRequest;
use App\Models\Account;
use App\Models\Transaction;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;

// this class is used to add bank account route
// it is linked to the model Account
class AccountController extends Controller
{
  public function index()
  {

    // get page number
    $page = request()->query('page', 1);

    // get all with pagination
    $accounts = Account::paginate(10, ['*'], 'page', $page);
    
    return view('dashboard.accounts.index', compact('accounts'));
  }

  public function create()
  {
    $users = User::all();
    return view('dashboard.accounts.create', compact('users'));
  }

  public function store(Request $request)
  {
    $request->validate([
      'name' => 'required',
      'user_id' => 'required',
      'balance' => 'required',
    ]);

    $randomIban = 'FR76' . rand(1000, 9999) . rand(1000, 9999) . rand(1000, 9999) . rand(1000, 9999) . rand(100, 999);

    $account = new Account([
      'name' => $request->get('name'),
      'balance' => $request->get('balance'),
      'iban' => $randomIban, 
      'user_id' => $request->get('user_id'),
    ]);

    $account->save();
    return redirect('/dashboard/accounts')->with('success', 'Account saved!');
  }

  public function show(Account $account)
  {
    return view('dashboard.accounts.show', compact('account'));
  }

  public function edit(Account $account)
  {
    $users = User::all();
    return view('dashboard.accounts.edit', compact('account', 'users'));
  }

  public function update(Request $request, Account $account)
  {
    $request->validate([
      'name' => 'required',
      'balance' => 'required',
      'user_id' => 'required'
    ]);

    $account->name = $request->get('name');
    $account->balance = $request->get('balance');
    $account->user_id = $request->get('user_id');
    $account->save();

    return redirect('/dashboard/accounts')->with('success', 'Account updated!');
  }

  public function destroy(Account $account)
  {
    $account->delete();

    return redirect('/dashboard/accounts')->with('success', 'Account deleted!');
  }

  public function accountTransactions(Account $account)
  {
    $transactions = $account->transactions()
    ->orderBy('date', 'DESC')
    ->paginate(10);

    return view('dashboard.accounts.transactions', compact('account', 'transactions'));
  }
}
