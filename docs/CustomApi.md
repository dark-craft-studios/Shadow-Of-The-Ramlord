# Shadow of The Ramlord - API

This document contains all function definitions and descriptions of all 
functions available in the Ramlord API.

## How to use these abstractions?

In order for an `.shps` file to use our custom API, it must include it at the
top of its source file.

```cpp
#include "Ramlord.ihps";
```

## Loading Screen

The loading screen system in Amnesia requires three parameters:

1. Image to display (with an extension, eg. `something.jpg`
2. Extra English Category of the text that should appear on screen during loading
3. Extra English Entry of the text that should appear on screen during loading

In order to keep SOTR's source code as simple as possible, we always assume the
same pattern of these parameters. The only difference being a map ID.

The assumed pattern for images is `SOTR_loading_[ID].jpg` where `[ID]`
represents a unique string literal. In SOTR this string is `00`, `01`, etc...

The assumed Category is `LoadingMessages`.

The assumed Entry is `[ID]`.

In order to not worry about how the loading screen system works, we setup an
AUTORUN that will automatically register a loading screen for a given map.
This AUTORUN, however, requires the `const string MapId` to be defined in the
map script.

## Map DisplayName

When Amnesia creates an AutoSave either by itself or called from a script, it
has to figure out what to put as the save file name.

It always uses `Levels` as an Extra English Category, and whatever we set in
the `SetDisplayName("someEntry");` call as an Extra English Entry.

We have an AUTORUN function that triggers every time a map is entered and uses
the `const string MapId` to lookup the right Extra English Entry to use.

## Level's Ambience

`Ramlord.ihps` has an ambience abstraction that allows for less .snt file
references and more consistency.

Ambience is automatically stopped when the Player leaves a map and so you do
not have to call `StopAmbience()` yourself.

In order to play a certain ambience file you simply call the
```cpp
StartAmbience("some_ambience_file.snt");
```
Ideally, you would call this in one of the starting functions such as `OnStart`
or `OnEnter`.

## Playing Voice lines

SOTR uses two types of voice line playback:

* Slowdown
* Non-Slowdown

The Slowdown variance will slow the player down until the voice over ends and
will return their speed back to normal afterwards.

```cpp
// Plays voice on the Player
PlayVoiceOnPlayerAndSlowdown("JohanTalk_33.ogg");

// Plays voice coming from an Entity
PlayVoiceOnEntityAndSlowdown("EmiliaTalk_33.ogg", "Emilia");
```

It is possible to essentially tell the system: "Please don't bother with trying
to reset the player to normal after this point.". This can be useful in cases
where you perhaps handle that fact explicitly.

```cpp
SetEffectVoiceOverCallback("");
```

At any point while the Slowdown voice is playing will result in the system not
attempting to reset the player's speed when the voice is done playing.

```cpp
// Plays voice on the Player
PlayVoice("JohanTalk_33.ogg");

// Plays voice coming from an Entity
PlayVoice("EmiliaTalk_33.ogg", "Emilia");
```


