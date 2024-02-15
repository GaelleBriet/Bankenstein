<x-app-layout>
  <x-slot name="header">
    <h2 class="font-semibold text-xl text-gray-800 leading-tight" style="display: inline-block">
      {{ __('Transactions') }} for {{ $account->name }} of {{ $user->name }}
      <a href="{{ route('users.accounts.transactions.create', [$user, $account]) }}" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Create transaction
      </a>
    </h2>
  </x-slot>

  <div class="py-12">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
      <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
        <div class="p-6 text-gray-900">
          @if (session('success'))
          <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
            <strong class="font-bold">Success!</strong>
            <span class="block sm:inline">{{ session('success') }}</span>
          </div>
          @endif

          <table class="table-auto" style="width: 100%;">
            <thead>
              <tr>
                <th class="px-4 py-2">Label</th>
                <th class="px-4 py-2">Amount</th>
                <th class="px-4 py-2">From</th>
                <th class="px-4 py-2">To</th>
                <th class="px-4 py-2">Date</th>
              </tr>
            </thead>
            <tbody>
              @foreach ($transactions as $transaction)
              <tr class="{{ $account->user_id == $transaction->fromAccount->user_id ? 'bg-red-500' : 'bg-green-500' }}">
                <td class="border px-4 py-2">{{ $transaction->name }}</td>
                <td class="border px-4 py-2">{{ $transaction->amount / 100 }}€</td>
                <td class="border px-4 py-2">
                  {{ $transaction->fromAccount->user->name }}
                  <br>
                  <em>{{ $transaction->fromAccount->name }}</em>
                </td>
                <td class="border px-4 py-2">
                  {{ $transaction->toAccount->user->name }}
                  <br>
                  <em>{{ $transaction->toAccount->name }}</em>
                </td>
                <td class="border px-4 py-2">
                  {{ date('d-m-Y', strtotime($transaction->date)) }}
                </td>
              </tr>
              @endforeach
            </tbody>
          </table>

          <div class="mt-4">
            {{ $transactions->links() }}
          </div>
        </div>
      </div>
    </div>
  </div>
</x-app-layout>
