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
        $users = [
            [
                'name' => 'a',
                'email' => 'a@a.a',
                'password' => 'a',
            ],
            [
                'name' => 'b',
                'email' => 'b@b.b',
                'password' => 'b',
            ],
            [
                'name' => 'c',
                'email' => 'c@c.c',
                'password' => 'c',
            ],
            [
                'name' => 'd',
                'email' => 'd@d.d',
                'password' => 'd',
            ],
        ];

        foreach ( $users as $key => $user ) {
            User::create( $user );
        }
    }
}
