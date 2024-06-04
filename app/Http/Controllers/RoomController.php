<?php

namespace App\Http\Controllers;

use App\Models\Room;
use App\Services\UserService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RoomController extends Controller
{
    public function __construct(public UserService $userService)
    {

    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $rooms = Room::whereRelation('users', 'users.id', auth()->user()->id)->get();
        return inertia('Rooms/Index', compact('rooms'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $users = $this->userService->getAllUsers();
        return inertia('Rooms/Create' , compact('users'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'userIds' => 'required|array|min:1',
        ]);
        
        DB::transaction(function () use ($request) {
            $room = new Room();
            $room->name = $request->name;
            $room->created_by = auth()->user()->id;
            $room->save();
            $room->users()->attach(auth()->user()->id);

            $room->users()->attach( $request->userIds );
        });

        return redirect()->route('rooms.index')->with('success', 'Created Successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Room $room)
    {
        // make all the messages in this room seen by the auth user 
        $room->load(['messages']);

        $room?->messages?->each(function ($message) {
            $message?->readers()?->updateExistingPivot( auth()->user() , ['is_read' => 1]);
        });

        return inertia('Rooms/Show', compact('room'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Room $room)
    {
        return inertia('Rooms/Edit', compact('room'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Room $room)
    {
        $room->name = $request->name;
        $room->save();

        return redirect()->route('rooms.index')->with('success', 'Updated Successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Room $room)
    {
        $room->delete();
        return redirect()->route('rooms.index')->with('success', 'Deleted Successfully.');
    }
}
