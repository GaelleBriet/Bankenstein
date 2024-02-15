<?php

namespace Database\Factories;

use App\Models\Account;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class AccountFactory extends Factory {
    private const NAMES = [
        'Personnal account',
        'Joint account',
        'Savings account',
        'Credit card',
        'Other',
    ];
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition() {
        $iban = fake()->iban('FR');

        // while iban is already used, generate a new one
        while (Account::where('iban', $iban)->exists()) {
            $iban = fake()->iban('FR');
        }

        return [
            'name' => self::NAMES[fake()->numberBetween(0, count(self::NAMES) - 1)],
            'balance' => fake()->randomNumber(6),
            'user_id' => User::factory(),
            'iban' => $iban
        ];
    }
}