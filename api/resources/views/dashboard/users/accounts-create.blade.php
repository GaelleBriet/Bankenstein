<x-app-layout>
  <x-slot name="header">
    <h2 class="font-semibold text-xl text-gray-800 leading-tight" style="display: inline-block">
      {{ __('Create account') }} for {{ $user->name }}
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

          <form action="{{ route('users.accounts.store', $user) }}" method="POST">
            @csrf
            <div class="mb-4">
              <label for="name" class="sr-only">Name</label>
              <input type="text" name="name" id="name" placeholder="Name" class="bg-gray-100 border-2 w-full p-4 rounded-lg @error('name') border-red-500 @enderror" value="{{ old('name') }}">
              @error('name')
              <div class="text-red-500 mt-2 text-sm">
                {{ $message }}
              </div>
              @enderror
            </div>
            <div class="mb-4">
              <label for="balance" class="sr-only">Balance</label>
              <input type="number" name="balance" id="balance" placeholder="Balance" class="bg-gray-100 border-2 w-full p-4 rounded-lg @error('balance') border-red-500 @enderror" value="{{ old('balance') }}">
              @error('balance')
              <div class="text-red-500 mt-2 text-sm">
                {{ $message }}
              </div>
              @enderror
            </div>
            <div>
              <button type="submit" class="bg-blue-500 text-white px-4 py-3 rounded font-medium w-full">Create</button>
            </div>
        </div>
      </div>
    </div>
  </div>
</x-app-layout>
