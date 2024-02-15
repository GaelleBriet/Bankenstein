<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{

    const USERS = [
        [
            'name' => 'RODRIGUES Pierre',
            'email' => 'pierre.rodrigues@oclock.school'
        ],
        [
            'name' => 'DAGUIER Théo',
            'email' => 'theo.daguier@oclock.school'
        ],
        [
            'name' => 'NAHON David',
            'email' => 'david.nahon@oclock.school'
        ],
        [
            'name' => 'ROUGIÉ Sylvain',
            'email' => 'sylvain.rougie@oclock.school'
        ],
        [
            'name' => 'ALLAIN Florence',
            'email' => 'florence.allain@oclock.school'
        ],
        [
            'name' => 'JOGUET-RECCORDON Arnaud',
            'email' => 'arnaud.joguet-reccordon@oclock.school'
        ],
        [
            'name' => 'MOM Bonna',
            'email' => 'bonna.mom@oclock.school'
        ],
        [
            'name' => 'GUIOU FREDERIC',
            'email' => 'frederic.guiou@oclock.school'
        ],
        [
            'name' => 'URIOSTEGUI Samantha',
            'email' => 'samantha.uriostegui@oclock.school'
        ],
        [
            'name' => 'PEREZ Matthieu',
            'email' => 'matthieu.perez@oclock.school'
        ],
        [
            'name' => 'HOUNSOU-GUéDé Charlène',
            'email' => 'charlene.hounsou-guede@oclock.school'
        ],
        [
            'name' => 'BRIET Gaëlle',
            'email' => 'gaelle.briet@oclock.school'
        ],
        [
            'name' => 'PICHON Théo',
            'email' => 'theo.pichon@oclock.school'
        ],
        [
            'name' => 'REVEL Jean-Baptiste',
            'email' => 'jean-baptiste.revel@oclock.school'
        ],
        [
            'name' => 'HAMACEK Marc',
            'email' => 'marc.hamacek@oclock.school'
        ],
        [
            'name' => 'BINOT Paul',
            'email' => 'paul.binot@oclock.school'
        ],
        [
            'name' => 'EL MHAMEDI Sami',
            'email' => 'sami.el-mhamedi@oclock.school'
        ],
        [
            'name' => 'BERLANAS Matteo',
            'email' => 'matteo.berlanas@oclock.school'
        ],
        [
            'name' => 'VONGSAVAN Steven',
            'email' => 'steven.vongsavan@oclock.school'
        ],
        [
            'name' => 'PREVOT Pablo',
            'email' => 'pablo.prevot@oclock.school'
        ],
        [
            'name' => 'GODET Gurvan',
            'email' => 'gurvan.godet@ockock.school'
        ],
        [
            'name' => 'CLECH Bertrand',
            'email' => 'bertrand.clech@oclock.school'
        ],
    ];
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Create 10 random users
        foreach (self::USERS as $user) {
            // Create a user
            $user = \App\Models\User::factory()->create($user);

            // Create an account
            $account = \App\Models\Account::factory()->create([
                'user_id' => $user->id,
                'name' => 'Personal account'
            ]);

            // Maybe create a second account
            $account_2 = null;
            if (rand(0, 1) === 1) {
                $account_2 =  \App\Models\Account::factory()->create([
                    'user_id' => $user->id,
                    'name' => 'Joint account'
                ]);
            }
        }

        $users = \App\Models\User::all();
        $accounts = \App\Models\Account::all();

        foreach ($users as $user) {
            for ($i = 0; $i < rand(2, 5); $i++) {
                // get a random account
                $account = $accounts->random();

                if ($user->id !== $account->user_id) {
                    \App\Models\Recipient::factory()->create([
                        'user_id' => $user->id,
                        'account_id' => $account->id,
                        'name' => $account->user->name
                    ]);
                }
            }
        }

        // Create transactions
        foreach($accounts as $account) {
            for($i = 0; $i < rand(3, 8); $i++) {
                $selectedAccount = $accounts->random();

                if($account->id !== $selectedAccount->id) {
                    \App\Models\Transaction::factory()->create([
                        'from_account_id' => $account->id,
                        'to_account_id' => $selectedAccount->id,
                        'date' => now()->subDays(rand(1, 30)),
                        'amount' => rand(1000, 100000)
                    ]);
                }
            }
        }
    }
}
