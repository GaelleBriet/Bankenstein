<x-app-layout>
  <x-slot name="header">
    <h2 class="font-semibold text-xl text-gray-800 leading-tight" style="display: inline-block">
      {{ __('Accounts') }}
    </h2>
    <a href="{{ route('accounts.create') }}" class="ml-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Add Account</a>
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
                <th class="px-4 py-2">Name</th>
                <th class="px-4 py-2">User</th>
                <th class="px-4 py-2">Balance</th>
                <th class="px-4 py-2">IBAN</th>
                <th class="px-4 py-2">Actions</th>
              </tr>
            </thead>
            <tbody>
              @foreach ($accounts as $account)
              <tr>
                <td class="border px-4 py-2">{{ $account->name }}</td>
                <td class="border px-4 py-2">{{ $account->user->name }}</td>
                <td class="border px-4 py-2">{{ $account->balance / 100 }}€</td>
                <td class="border px-4 py-2">
                  {{ substr($account->iban, 0, 4) }} {{ substr($account->iban, 4, 4) }} {{ substr($account->iban, 8, 4) }} {{ substr($account->iban, 12, 4) }} {{ substr($account->iban, 16, 4) }} {{ substr($account->iban, 20, 4) }} {{ substr($account->iban, 24, 4) }} {{ substr($account->iban, 28, 4) }}
                </td>
                <td class="border px-4 py-2">
                  <a href="{{ route('accounts.transactions', $account->id) }}" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Transactions</a>
                  {{-- use tailwindcss to style the buttons --}}
                  <a href="{{ route('accounts.edit', $account->id) }}" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">Edit</a>
                  <form action="{{ route('accounts.destroy', $account->id) }}" method="POST" class="inline">
                    @csrf
                    @method('DELETE')
                    <button type="submit" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">Delete</button>
                  </form>
              </tr>
              @endforeach
            </tbody>
          </table>

          <div class="mt-4">
            {{ $accounts->links() }}
          </div>
        </div>
      </div>
    </div>
  </div>
</x-app-layout>
