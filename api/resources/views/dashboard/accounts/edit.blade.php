<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Accounts') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                  <form action="{{ route('accounts.update', $account->id) }}" method="POST">
                    @csrf
                    @method('PUT')
                    <div class="mb-4">
                      <label for="name" class="">Name</label>
                      <input type="text" name="name" id="name" placeholder="Name" class="bg-gray-100 border-2 w-full p-4 rounded-lg @error('name') border-red-500 @enderror" value="{{ $account->name }}">
                      @error('name')
                        <div class="text-red-500 mt-2 text-sm">
                          {{ $message }}
                        </div>
                      @enderror
                    </div>
                    <div class="mb-4">
                      <label for="balance" class="">Balance</label>
                      <input type="text" name="balance" id="balance" placeholder="Balance" class="bg-gray-100 border-2 w-full p-4 rounded-lg @error('balance') border-red-500 @enderror" value="{{ $account->balance }}">
                      @error('balance')
                        <div class="text-red-500 mt-2 text-sm">
                          {{ $message }}
                        </div>
                      @enderror
                    </div>
                    <div class="mb-4">
                      <label for="user_id" class="">User</label>
                      <select name="user_id" id="user_id" class="bg-gray-100 border-2 w-full p-4 rounded-lg @error('user_id') border-red-500 @enderror">
                        @foreach ($users as $user)
                          <option value="{{ $user->id }}" {{ $account->user_id == $user->id ? 'selected' : '' }}>{{ $user->name }}</option>
                        @endforeach
                      </select>
                      @error('user_id')
                        <div class="text-red-500 mt-2 text-sm">
                          {{ $message }}
                        </div>
                      @enderror
                    </div>
                    <div>
                      <button type="submit" class="bg-blue-500 text-white px-4 py-3 rounded font-medium w-full">Update</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
