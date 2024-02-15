<?php

use App\Http\Controllers\Api\LoginController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('/login', [LoginController::class, 'login']);


Route::middleware('auth:sanctum')->group(function () {
    Route::get('/me', function (Request $request) {
        return $request->user();
    });
    Route::get('/me/recipients', [UserController::class, 'userRecipients']);
    Route::get('/me/accounts', [UserController::class, 'userAccounts']);
    Route::get('/me/accounts/{account}', [UserController::class, 'userAccount']);
    Route::get('/me/accounts/{account}/transactions', [UserController::class, 'userAccountTransactions']);

    Route::post('/me/recipients/add', [UserController::class, 'userAddRecipient']);
    Route::get('/me/recipients/{recipient}/delete', [UserController::class, 'userDeleteRecipient']);
    Route::post('/me/transactions/create', [UserController::class, 'userAccountTransactionsCreate']);
});