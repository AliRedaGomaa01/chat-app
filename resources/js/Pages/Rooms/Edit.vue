<script setup >

    import { useForm, usePage } from "@inertiajs/vue3";

    let props = defineProps({
      room: Object,
    })

    let form = useForm({
      name : props.room.name,
    });

    let submit = () => {
      form.patch(route('rooms.update', props.room.id) , {
        onSuccess : () => form.reset()
      });
    }

</script>

<template>
  <Head>
    <title>Room - Edit</title>
  </Head>

  <AuthenticatedLayout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        Room Edit
      </h2>
    </template>

    <form @submit.prevent="submit">

      <div class="grid grid-cols-1 gap-5">
        <div class="grid grid-cols-5 gap-5">
          <label class="col-span-1" for="">Room Name</label>
          <input class="col-span-4" type="text" placeholder="room name"  v-model="form.name" required/>
        </div>
      
        <div class="grid grid-cols-1 gap-1 justify-items-end ">
          <div class="space-x-5">
            <button type="submit" class="primary-btn">Edit</button>
            <button type="button" @click='form.reset()' class="secondary-btn">Reset</button>
          </div>
        </div>
      </div>

    </form>
  </AuthenticatedLayout>
</template>
