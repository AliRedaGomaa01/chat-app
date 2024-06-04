<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    use HasFactory;
    protected $guarded = ['id'];

    protected $with = ['sender' , 'seenBy'];


    # relations 
    public function sender()
    {
        return $this->belongsTo(User::class , 'sender_id' , 'id');
    }

    public function readers()
    {
        return $this->belongsToMany(User::class , 'message_users' , 'message_id' , 'user_id')->withTimestamps()->withPivot('is_read');
    }

    public function seenBy()
    {
        return $this->readers()->wherePivot('is_read' , 1)->select('name');
    }

    public function room()
    {
        return $this->belongsTo(Room::class , 'room_id' , 'id');
    }
}
