<script setup>
    import { router, useForm, usePage } from "@inertiajs/vue3";
import { onMounted } from "vue";

    let props = defineProps(['room']);

    let form = useForm({
      'text' : '',
      'room_id' : props.room.id,
    })


    const submit = () => {
      form.post(`/rooms/${props.room.id}/messages` , {
        onSuccess : () => form.reset()
      });
    }

    onMounted(() => {
      $('#last-message')[0].scrollIntoView(false);
    })


    Echo.private(`rooms.${props.room.id}`)
        .listen('NewMessageSent', (e) => {
          if(e.message.sender_id != usePage().props.auth.user.id){
            router.reload({
                preserveScroll: true,
                preserveState: true,
                replace: true
            })
          }
        });

</script>

<template>
  <Head :title="room.name" />

  <AuthenticatedLayout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight"> {{ room.name  }}</h2>
    </template>

    <div class="relative overflow-x-auto shadow-lg sm:rounded-lg w-[90vw] lg:w-[60vw] bg-white p-5 ">
      <div class=" overflow-y-scroll h-[70vh] grid grid-cols-1">

      <template v-for="message in room.messages" :key="message.id">
          <div class="float-start text-red-600 justify-self-start bg-slate-100 rounded-lg p-3 my-2" v-if=" message.sender.id == $page.props.auth.user.id">

            <p class="text-black"> You </p>
            <p> {{ message.text }}</p>
            <p class="text-blue-600">Seen By : 
              <span v-for="( user , index ) in message.seen_by" :key="index">{{ user.name }} , </span>
              <span v-if="message.seen_by.length == 0"> none </span>
            </p>

          </div>
          <div :class="'float-end text-red-600 justify-self-end bg-red-50 rounded-lg p-3 my-2'" v-else>

            <p class="text-black"> {{ message.sender.name }} ( {{ message.sender.email }} )</p>
            <p> {{ message.text }}</p>

          </div>

        </template>
        <div id="last-message"></div>
      </div>

        <form @submit.prevent="submit" class="grid grid-cols-5 gap-5 place-items-center border-t-2 pt-5 mt-5 ">
          <textarea class="col-span-4 w-full" v-model="form.text" >
          </textarea>
          <button type="submit" class="primary-btn col-span-1 align-self-start text-center">Send</button>
        </form>
    </div>
  </AuthenticatedLayout>
</template>
