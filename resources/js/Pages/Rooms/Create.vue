<script setup >

    import { useForm, usePage } from "@inertiajs/vue3";

    let props = defineProps({
      users: Array,
    })

    let form = useForm({
      name : '',
      userIds : [ ], 
    });

    let submit = () => {
      form.post(route('rooms.store') , {
        onSuccess : () => form.reset()
      });
    }

</script>

<template>
  <Head>
    <title>Room - Create</title>
  </Head>

  <AuthenticatedLayout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        Room Create
      </h2>
    </template>

    <form @submit.prevent="submit">
      <div class="grid grid-cols-1 gap-5">
        <div class="grid grid-cols-5 gap-5">
          <label class="col-span-1" for="">Room Name</label>
          <input class="col-span-4" type="text" placeholder="room name"  v-model="form.name" required/>
        </div>
        <div class="grid grid-cols-5 gap-5">
          <label class="col-span-1" for="">Select User</label>
          <select name="" id="" class="col-span-4" v-model="form.userIds" multiple required style="height: 70px !important">
            <template v-for="user in users" :key="user.id" >
              <option :value="user.id" v-if="user.id != $page.props.auth.user.id"> name : {{  user.name }} , email: {{  user.email  }}</option>
            </template>
          </select>
        </div>
      
        <div class="grid grid-cols-1 gap-1 justify-items-end ">
          <div class="space-x-5">
            <button type="submit" class="primary-btn">Create</button>
            <button type="button" @click='form.reset()' class="secondary-btn">Reset</button>
          </div>
        </div>
      </div>

    </form>
  </AuthenticatedLayout>
</template>
