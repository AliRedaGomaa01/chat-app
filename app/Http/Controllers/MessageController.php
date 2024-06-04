<?php

namespace App\Http\Controllers;

use App\Events\NewMessageSent;
use App\Models\Room;
use App\Models\Message;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MessageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'text' => 'required|min:1', 
            'room_id' => 'required|exists:rooms,id',
        ]);

        $readerIds = Room::where('id' , $request->room_id)->first()->users()->whereNot('users.id' , $request->user()->id)->pluck('users.id')->toArray();

        DB::transaction(function () use ($request, $validated , $readerIds) {
            $message = new Message();
            $message->sender_id = $request->user()->id;
            $message->room_id = $request->room_id;
            $message->text = $validated['text'];
            $message->save();

            $message->readers()->attach($readerIds);

            NewMessageSent::dispatch($message);
        });


        return redirect()->back();
    }

    /**
     * Display the specified resource.
     */
    public function show(Message $message)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Message $message)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Message $message)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Message $message)
    {
        //
    }
}
