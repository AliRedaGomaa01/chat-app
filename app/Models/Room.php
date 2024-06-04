<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    protected $with= ['createdBy'];


    # accessors

    public function createdAt() :Attribute
    {
        return Attribute::make(
            get: fn ($value) =>  Carbon::parse($value)->format('Y-m-d h:i A'),
        );
    }

    # relations 


    public function messages()
    {
        return $this->hasMany(Message::class);
    }

    public function users()
    {
        return $this->belongsToMany(User::class , 'room_users' , 'room_id' , 'user_id');
    }

    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by' , 'id');
    }
    
}
