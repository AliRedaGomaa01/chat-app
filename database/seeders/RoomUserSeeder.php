<?php

namespace Database\Seeders;

use App\Models\RoomUser;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class RoomUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $roomUsers = [];

        for ($i = 1; $i <= 2; $i++) {
            for ($j = 1; $j <= 4; $j++) {
                $roomUsers[] = [
                    'room_id' => $i,
                    'user_id' => $j,
                ];
            }
        }

        $roomUsers[] = [
            'room_id' => 3,
            'user_id' => 3,
        ];

        $roomUsers[] = [
            'room_id' => 4,
            'user_id' => 4,
        ];

        RoomUser::insert($roomUsers);
    }
}
