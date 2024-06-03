<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $users = [];
        foreach ( [ 'a' , 'b' , 'c' , 'd'] as $key => $value ) {
            $users[] = [
                "name" => "$value",
                "email" => "$value@$value.$value",
                "password" => bcrypt("$value"),
                "created_at" => now(),
                "updated_at" => now(),
            ];
        }


        User::insert( $users );
    }
}
