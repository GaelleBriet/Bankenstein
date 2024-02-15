<x-app-layout>
  <x-slot name="header">
    <h2 class="font-semibold text-xl text-gray-800 leading-tight" style="display: inline-block">
      {{ __('Recipients') }} for {{ $user->name }}
      <a href="{{ route('users.recipients.create',  ['user' => $user->id]) }}" class="ml-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Add recipient</a>
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
                <th class="px-4 py-2">Name</th>
                <th class="px-4 py-2">Account Name</th>
                <th class="px-4 py-2">Actions</th>
              </tr>
            </thead>
            <tbody>
              @foreach ($recipients as $recipient)
              <tr>
                <td class="border px-4 py-2">{{ $recipient->name }}</td>
                <td class="border px-4 py-2">{{ $recipient->account->name}} (id: {{ $recipient->account_id }})</td>
                <td class="border px-4 py-2">
                  {{-- <a href="{{ route('dashboard.users.recipients.edit', $recipient->id) }}" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Edit</a>
                  --}}
                  <form action="{{ route('users.recipients.destroy', [$user->id, $recipient->id]) }}" method="POST" style="display: inline-block">
                    @csrf
                    @method('DELETE')
                    <button type="submit" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">Delete</button>
                  </form>
                </td>
              @endforeach
            </tbody>


          <div class="mt-4">
            {{ $recipients->links() }}
          </div>
        </div>
      </div>
    </div>
  </div>
</x-app-layout>
