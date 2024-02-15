<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Dashboard\AccountController;
use App\Http\Controllers\Dashboard\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

// Dashboard routes
Route::prefix('dashboard')->middleware(['auth', 'verified'])->group(function () {
    // Add a transaction endpoint to the account resource
    Route::get('/accounts/{account}/transactions', [AccountController::class, 'accountTransactions'])->name('accounts.transactions');
    Route::resource('accounts', AccountController::class);

    // Specific resources for user
    Route::get('/users/{user}/recipients', [UserController::class, 'userRecipients'])->name('users.recipients');
    Route::get('/users/{user}/recipients/create', [UserController::class, 'userRecipientsCreate'])->name('users.recipients.create');
    Route::post('/users/{user}/recipients', [UserController::class, 'userRecipientsStore'])->name('users.recipients.store');
    Route::delete('/users/{user}/recipients/{recipient}', [UserController::class, 'userRecipientsDestroy'])->name('users.recipients.destroy');

    // Specific resources for user
    Route::get('/users/{user}/accounts', [UserController::class, 'userAccounts'])->name('users.accounts');
    Route::get('/users/{user}/accounts/create', [UserController::class, 'userAccountsCreate'])->name('users.accounts.create');
    Route::post('/users/{user}/accounts', [UserController::class, 'userAccountsStore'])->name('users.accounts.store');
    Route::delete('/users/{user}/accounts/{account}', [UserController::class, 'userAccountsDestroy'])->name('users.accounts.destroy');

    // user account transactions
    Route::get('/users/{user}/accounts/{account}/transactions', [UserController::class, 'userAccountTransactions'])->name('users.accounts.transactions');
    Route::get('/users/{user}/accounts/{account}/transactions/create', [UserController::class, 'userAccountTransactionsCreate'])->name('users.accounts.transactions.create');
    Route::post('/users/{user}/accounts/{account}/transactions', [UserController::class, 'userAccountTransactionsStore'])->name('users.accounts.transactions.store');
    Route::delete('/users/{user}/accounts/{account}/transactions/{transaction}', [UserController::class, 'userAccountTransactionsDestroy'])->name('users.accounts.transactions.destroy');

    Route::resource('users', UserController::class);
});

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
