<?php

namespace Database\Factories;

use App\Models\Account;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class TransactionFactory extends Factory {

    const NAMES = [
        'Salary',
        'Bonus',
        'Gift',
        'Loan',
        'Rent',
        'Food',
        'Clothes',
        'Transport',
        'Entertainment',
        'Other',
    ];

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition() {
        return [
            'from_account_id' => Account::factory(),
            'to_account_id' => Account::factory(),
            'amount' => fake()->randomDigitNotNull(0, 6000),
            'date' => fake()->date(),
            'name' => self::NAMES[fake()->numberBetween(0, count(self::NAMES) - 1)],
        ];
    }
}
