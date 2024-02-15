<x-app-layout>
  <x-slot name="header">
    <h2 class="font-semibold text-xl text-gray-800 leading-tight" style="display: inline-block">
      {{ __('Create recipient') }} for {{ $user->name }}
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

          {{-- Add recipient form --}}
          <form action="{{ route('users.recipients.store', $user->id) }}" method="POST">
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
            {{-- Select from all accounts  --}}
            <div class="mb-4">
              <label for="account_id" class="sr-only">Account</label>
              <select name="account_id" id="account_id" class="bg-gray-100 border-2 w-full p-4 rounded-lg @error('account_id') border-red-500 @enderror">
                <option value="">Select account</option>
                @foreach ($accounts as $account)
                <option value="{{ $account->id }}">{{$account->user->name}} - {{ $account->name }}</option>
                @endforeach
              </select>
              @error('account_id')
              <div class="text-red-500 mt-2 text-sm">
                {{ $message }}
              </div>
              @enderror
            <div>
              <button type="submit" class="bg-blue-500 text-white px-4 py-3 mt-4 rounded font-medium w-full">Add recipient</button>
            </div>
          </form>

        </div>
      </div>
    </div>
  </div>
</x-app-layout>
