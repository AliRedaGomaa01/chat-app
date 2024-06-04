<script setup>
defineProps({
  rooms: Array,
});
</script>

<template>
  <Head title="Rooms" />

  <AuthenticatedLayout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">Rooms</h2>
    </template>

    <Link
      :href="route('rooms.create')"
      as="button"
      class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded my-3"
      >Create new room</Link
    >

    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
      <table
        class="w-full text-sm rtl:text-right text-gray-500 dark:text-gray-400 text-center"
      >
        <thead class="text-xs text-gray-700 uppercase dark:text-gray-400">
          <tr>
            <th scope="col" class="px-6 py-3 bg-gray-50 dark:bg-gray-800">#</th>
            <th scope="col" class="px-6 py-3">Name</th>
            <th scope="col" class="px-6 py-3 bg-gray-50 dark:bg-gray-800">
              Created By
            </th>
            <th scope="col" class="px-6 py-3">Created At</th>
            <th scope="col" class="px-6 py-3 bg-gray-50 dark:bg-gray-800">
              Actions
            </th>
          </tr>
        </thead>
        <tbody>
          <template v-for="(room, index) in rooms" :key="room.id">
            <tr class="border-b border-gray-200 dark:border-gray-700">
              <th
                scope="row"
                class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap bg-gray-50 dark:text-white dark:bg-gray-800"
              >
                {{ index }}
              </th>
              <td class="px-6 py-4">{{ room.name }}</td>
              <td class="px-6 py-4 bg-gray-50 dark:bg-gray-800">
                {{ room.created_by.name }}
              </td>
              <td class="px-6 py-4">{{ room.created_at }}</td>
              <td
                class="px-6 py-4 bg-gray-50 dark:bg-gray-800 flex flex-row justify-center space-x-2"
              >
                <Link
                  :href="route('rooms.show', room.id)"
                  class="text-green-500"
                >
                  Show
                </Link>
                <template v-if="$page.props.auth.user.id === room.created_by.id">
                  <Link
                    :href="route('rooms.edit', room.id)"
                    class="text-blue-500"
                  >
                    Edit
                  </Link>
                  <Link
                    :href="route('rooms.destroy', room.id)"
                    method="DELETE"
                    class="text-red-500"
                  >
                    Delete
                  </Link>
                </template>
              </td>
            </tr>
          </template>
        </tbody>
      </table>
    </div>
  </AuthenticatedLayout>
</template>
