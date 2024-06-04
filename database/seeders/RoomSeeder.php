<?php

namespace Database\Seeders;

use App\Models\Room;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class RoomSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $rooms = [];

        foreach (range(1, 4) as $key => $value) 
        {
            $rooms[] = [
                'name' => 'chat room '. $value,
                'created_by' => $value,
                'created_at' => now(),
                'updated_at' => now(),
            ];
        }

        Room::insert($rooms);

    }
}
