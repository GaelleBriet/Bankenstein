<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use App\Models\Account;
use App\Models\Recipient;
use App\Models\Transaction;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        // get page number
        $page = request()->query('page', 1);

        // get all with pagination
        $users = User::paginate(10, ['*'], 'page', $page);

        return view('dashboard.users.index', compact('users'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('dashboard.users.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'email' => 'required',
            'password' => 'required',
        ]);

        $user = new User([
            'name' => $request->get('name'),
            'email' => $request->get('email'),
            'password' => $request->get('password'),
        ]);

        $user->password = Hash::make($user->password);
        $user->save();
        return redirect('/dashboard/users')->with('success', 'User saved!');   
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function show(User $user)
    {
        return view('dashboard.users.show', compact('user'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function edit(User $user)
    {
        return view('dashboard.users.edit', compact('user'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, User $user)
    {
        $request->validate([
            'name' => 'required',
            'email' => 'required',
            'password_confirmation' => 'same:password'
        ]);

        $user->name = $request->get('name');
        $user->email = $request->get('email');
        $user->password = Hash::make($request->get('password'));
        $user->save();

        // redirect to this user edit page
        return redirect('/dashboard/users/' . $user->id . '/edit')->with('success', 'User updated!');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function destroy(User $user)
    {
        $user->delete();

        return redirect('/dashboard/users')->with('success', 'User deleted!');
    }

    // get recipients
    public function userRecipients(User $user)
    {
        $recipients = $user->recipients()
            ->orderBy('name', 'asc')
            ->paginate(10);

        return view('dashboard.users.recipients', compact('recipients', 'user'));
    }

    public function userRecipientsCreate(User $user)
    {
        $accounts = Account::all();
        $alreadyRecipients = $user->recipients()->pluck('account_id')->toArray();

        $accounts = $accounts->filter(function ($account) use ($alreadyRecipients) {
            return !in_array($account->id, $alreadyRecipients);
        });
        
        return view('dashboard.users.recipients-create', compact('user', 'accounts', 'alreadyRecipients'));
    }

    public function userRecipientsStore(User $user, Request $request)
    {
        $request->validate([
            'name' => 'required',
            'account_id' => 'required',
        ]);

        $recipient = new Recipient([
            'name' => $request->get('name'),
            'account_id' => $request->get('account_id'),
            'user_id' => $user->id,
        ]);

        $recipient->save();
        return redirect('/dashboard/users/' . $user->id . '/recipients')->with('success', 'Recipient saved!');
    }

    public function userRecipientsDestroy(User $user, Recipient $recipient)
    {
        $recipient->delete();

        return redirect('/dashboard/users/' . $user->id . '/recipients')->with('success', 'Recipient deleted!');
    }

    // same for accounts
    public function userAccounts(User $user)
    {
        $accounts = $user->accounts()
            ->orderBy('name', 'asc')
            ->paginate(10);

        return view('dashboard.users.accounts', compact('accounts', 'user'));
    }

    public function userAccountsCreate(User $user)
    {   
        return view('dashboard.users.accounts-create', compact('user'));
    }

    public function userAccountsStore(User $user, Request $request)
    {
        $request->validate([
            'name' => 'required',
        ]);

        $randomIban = 'FR76' . rand(1000, 9999) . rand(1000, 9999) . rand(1000, 9999) . rand(1000, 9999) . rand(100, 999);

        $account = new Account([
          'name' => $request->get('name'),
          'balance' => $request->get('balance'),
          'iban' => $randomIban, 
          'user_id' => $user->id,
        ]);

        $account->save();
        return redirect('/dashboard/users/' . $user->id . '/accounts')->with('success', 'Account saved!');
    }

    public function userAccountsDestroy(User $user, Account $account)
    {
        $account->delete();

        return redirect('/dashboard/users/' . $user->id . '/accounts')->with('success', 'Account deleted!');
    }

    // use account transactions
    public function userAccountTransactions(User $user, Account $account)
    {
        $transactions = $account->transactions()
            ->orderBy('date', 'desc')
            ->paginate(30);

        return view('dashboard.users.account-transactions', compact('transactions', 'user', 'account'));
    }

    // create transaction
    public function userAccountTransactionsCreate(User $user, Account $account)
    {
        $accounts = $user->accounts()->get();
        $recipients = $user->recipients()->get();

        return view('dashboard.users.account-transactions-create', compact('user', 'account', 'accounts', 'recipients'));
    }

    public function userAccountTransactionsStore(User $user, Account $account, Request $request)
    {
        $request->validate([
            'amount' => 'required',
            'account_id' => 'required',
            'recipient_id' => 'required',
        ]);

        $transaction = new Transaction([
            'amount' => $request->get('amount'),
            'account_id' => $request->get('account_id'),
            'recipient_id' => $request->get('recipient_id'),
        ]);

        $transaction->save();
        return redirect('/dashboard/users/' . $user->id . '/accounts/' . $account->id . '/transactions')->with('success', 'Transaction saved!');
    }
}
