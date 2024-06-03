<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    use HasFactory;
    protected $guarded = ['id'];


    # relations 
    public function sender()
    {
        return $this->belongsTo(User::class , 'sender_id' , 'id');
    }

    public function users()
    {
        return $this->belongsToMany(User::class , 'message_users' , 'message_id' , 'user_id');
    }

    public function room()
    {
        return $this->belongsTo(Room::class , 'room_id' , 'id');
    }
}
