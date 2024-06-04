<?php

namespace Database\Seeders;

use App\Models\MessageUser;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class MessageUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $messageUsers = [];

        foreach (range(1, 8) as $key => $messageId)
        {
            foreach (range(1, 4) as $key2 => $userId)
            {
                // the user who created the message will not be in the readers 
                if ( $messageId % 4 == $userId ) continue; 
                if ( $messageId % 4 == 0 && $userId == 4 ) continue; 

                $messageUsers[] = [
                    'message_id' => $messageId,
                    'user_id' => $userId,
                    'created_at' => now(),
                    'updated_at' => now()
                ];
            }
        }

        MessageUser::insert($messageUsers);
    }
}
