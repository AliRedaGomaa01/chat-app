<?php

namespace Database\Seeders;

use App\Models\Message;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class MessageSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $messages = [];

        $index = 1;

        foreach (range(1,4) as $key => $sender_id) 
        {
            foreach (range(1,2) as $key2 => $room_id) 
            {
                
            $messages[] = [
                'sender_id' => $sender_id,
                'room_id' => $room_id,
                'text' => 'test message ' . $index,
                'created_at' => now(),
                'updated_at' => now()
            ];

            $index++;

            }
        }

        Message::insert($messages);

    }
}
