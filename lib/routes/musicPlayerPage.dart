// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({
    super.key,
    required this.musicData,
    required this.player,
    required this.currentIndex,
    required this.playPause,
    required this.next,
    required this.previous,
  });

  final Map musicData;
  final AssetsAudioPlayer player;
  final int currentIndex;
  final Function playPause;
  final Function next;
  final Function previous;

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  Color primaryYellow = Color(0xfff1d80b);
  bool isPlaying = true;
  late int currentIndex;
  List albumSongs = [
    {
      "icon": Icons.sailing_outlined, //Ionicons.boat_outline,
      "title": "Boat",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Came in for the embers
Stayed out for the breeze
I need to feel elements to remind me
There's beauty when it's bleak

Stuck out long before lights down
Why do I breathe?

Oh, I know

The more that I love the less that I feel
The times that I jumped never were real
They say that all scars will heal but I know
Maybe I won't

But the waves won't break my boat
But the waves won't break my boat

Stones crash on the boardwalk
The wind rush through the trees
I keep my eyes peeled
The memories always fall short
Of what we could have been

Left out long before last call
What do I need?

Oh, I know

The more that I love the less that I feel
The times that I jumped never were real
They say that all scars will heal but I know
Maybe I won't

But the waves won't break my boat
But the waves won't break my boat
But the waves won't break my boat
The waves won't break my boat

The more that I love the less that I feel
The times that I jumped never were real
They say that all scars will heal but I know
Maybe I won't

And the waves won't break my boat""",
    },
    {
      "icon": EvaIcons.eyeOff2Outline,
      "title": "Eyes Closed",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """I know it's a bad idea
But how can I help myself?
Been inside for most this year
And I thought a few drinks, they might help

It's been a while, my dear
Dealing with the cards life dealt
I'm still holding back these tears
While my friends are somewhere else

I pictured this year a little bit different
When it hit February
I step in the bar, it hit me so hard
Oh, how can it be this heavy?
Every song reminds me you're gone
And I feel the lump form in my throat
'Cause I'm here alone

Just dancing with my eyes closed
'Cause everywhere I look I still see you
And time is moving so slow
And I don't know what else that I can do
So I'll keep dancing with my

Eye-eye-eye-eyes
Eye-eye-eye-eyes closed
Eye-eye-eye-eyes
So I'll keep dancing with my

Delusion is here again
And I think you'll come home soon
A word brings me right back in
Then it's only me that's in this room

I guess I could just pretend
The colours are more than blue
But I lost more than my friend
I can't help but missing you

I pictured this month a little bit different
No one is ever ready
And when it unfolds, you get in a hole
Oh, how can it be this heavy?
Everything changes, nothing's the same
Except the truth is now you're gone
And life just goes on

So I'm dancing with my eyes closed
'Cause everywhere I look I still see you
And time is moving so slow
And I don't know what else that I can do
So I'll keep dancing with my

Eye-eye-eye-eyes
Eye-eye-eye-eyes closed
Eye-eye-eye-eyes
So I'll keep dancing with my

Eye-eye-eye-eyes
Eye-eye-eye-eyes closed
Eye-eye-eye-eyes
Oh, I keep dancing with my

They're shutting the bar
They're cleaning the floor
And everyone is already home
But I'm on my own

Still dancing with my eyes closed
'Cause everywhere I look I still see you
Time is moving so slow
And I don't know what else that I can do
So I'll keep dancing with my

Eye-eye-eye-eyes
Eye-eye-eye-eyes closed
Eye-eye-eye-eyes
Oh, I keep dancing with my

Eye-eye-eye-eyes
Eye-eye-eye-eyes closed
Eye-eye-eye-eyes
Oh, I keep dancing with my""",
    },
    {
      "icon": Ionicons.water_outline,
      "title": "Salt Water",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """There's still so far to go
And I can't feel my toes
When the rain soaks through the heels
And slips to the sole
Yeah, the blades are two feet tall
I wade in green
I'm moving forward, to where?
God only knows

Feel the wind's harsh refrain
Like the clouds gripped my face
Saying it's alright to run
From all this pain
Oh and when it's time to go
With one last breath that's in my lungs
I'll scream, it's all for love
I'll scream, it's all for love

Come and kiss me, salt water
Oh finally, I feel, at three or four degrees
I'm free in salt water
Embrace the deep and leave everything
It was just a dream

I can see it up ahead
Where the sky meets the ground
And after that there's only moving grey
I am filled up with regret
With things I did or never said
Just leave that well alone

And come kiss me, salt water
Oh finally, I feel, at three or four degrees
I'm free in salt water
Embrace the deep and leave everything

It was just a dream
It was just a dream
It was just a dream
It was just a dream
Was it just a dream?

Now I'm standing on the edge
Gazing into hell
Or is it something else?
I just can't tell
When there's nothing left
I close my eyes and take one step
And say, well here it goes
And say, well here it goes

Come and kiss me, salt water
Oh finally, I feel, at three or four degrees
I'm free in salt water
Embrace the deep and leave everything

It was just a dream""",
    },
    {
      "icon": Ionicons.infinite_outline,
      "title": "Life Goes On",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """It hit like a train
I ran out of words
I got nothing to say
Everything hurts
And I know love leads to pain
But memories serve our sweetest refrain

The waves came tumbling down
As you float away, I'm reaching for ya'

To tell me how
How my life goes on with you gone?
I suppose I'll sink like a stone
If you leave me now
Oh, the storms will roll
Easy come, hard go
Then life goes on

Would I miss the flames?
The heated reserve
Oh, I'd remember the way
That you put me first
What a heart-wrenching shame
That you'll never know, just like tears in the rain
Mm hmm, mm

A constant grey in the clouds
When I hear your name
I think of love

So tell me how
How my life goes on with you gone?
I suppose I'll sink like a stone
If you leave me now
Oh, the storms will roll
Easy come, hard go
Then life goes on
Ah-yeah, life goes on
Ah-yeah

I watched the sun setting down
I am so afraid
I need you now

To tell me how
How my life goes on with you gone?
I suppose I'll sink like a stone
If you leave me now
Oh, the storms will roll
Easy come, hard go
Then life goes on
Easy come, hard go
Then life goes on""",
    },
    {
      "icon": Icons.bubble_chart_outlined,
      "title": "Dusty",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """I heard you calling, now my eyes are open
The day is breaking into powder blue
Sunlight is framing our every moment
What a way to start off the day with you

Flick a finger
Start a discussion to pick a singer
This one you'll love it
I had to bring her
Just let the speakers take you away

Drop the needle on Dusty
Frost on the leaves like a lake
The moment came out of nothing
A beautiful smile on your face
Yesterday was a long night
But I got a feeling that the future is so bright
All of the pressure washed away in the low tide
But we got to wait 'til our clothes are bone dry
So I'll drop the needle on Dusty

We were lost within a stormy ocean
Nobody knew what we were going through
We talk about it as we dip our toes in
Take a breath and brace for the waves with you

Flick a finger
Wait for the magic to do its thing, yeah
There's more than sadness we got within us
Let's put some colour into the grey

And drop the needle on Dusty
Frost on the leaves like a lake
The moment came out of nothing
A beautiful smile on your face
Yesterday was a long night
But I got a feeling that the future is so bright
All of the pressure washed away in the low tide
We got to wait 'til our clothes are bone dry
So I'll drop the needle on Dusty

Nothing but static on the stereo before today
Both on the edge to throw it all away
I used to think that every situation stayed the same
But I can see it start to change, okay

Drop the needle on Dusty
Frost on the leaves like a lake
The moment came out of nothing
A beautiful smile on your face
Yesterday was a long night
I got a feeling that the future is so bright
All of the pressure washed away in the low tide
We got to wait 'til our clothes are bone dry
So I'll drop the needle on Dusty
Drop the needle on Dusty
Drop the needle on Dusty""",
    },
    {
      "icon": Ionicons.time_outline,
      "title": "End Of Youth",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """I've been depressed since you left
Tried to fill the hole with wine
Stopped the drugs when she came
Cleaned my act up overnight

If you reach with no reply
I'll see you when I see you, man
You can't talk me through the fall
If we don't know if I can land

Tried to grow, but the past
It tears me down to size
Tell the world how to process
But don't take the same advice

Half remember what I say
Then the morning's filled with fear
Can't get a handle on my grief
When every memory turns to tears

It's been a long year and we're not even halfway there

Is this the ending of our youth when pain starts taking over?
I just don't know if I can ever just let it go
Everything's falling apart
When love is real, there's never closure
I guess it's all part of life
But I can't help but feel low
We spend our youth with arms and hearts wide open
And then the dark gets in and that's the end of youth

I've been lost since the teens but pretend it's all alright
All my ups led to falls that led to trying to end my life
Just a boy at the start, they lent on like a man
You were meant to be my friend and not to take all that you can

Disengaged to create, try to re-invent the wheel
No one knows what they want, so I just give you what I feel
If I slip and get high I know the low is always near
When I'm down I never see you, when I'm up you all appear

It's been a long year and we're not even halfway there

Is this the ending of our youth when pain starts taking over?
I just don't know if I can ever just let it go
Everything's falling apart
When love is real, there's never closure
I guess it's all part of life
But I can't help but feel low
We spend our youth with arms and hearts wide open
And then the dark gets in and that's the end of youth

It's been a long year and we're not even halfway there

Is this the ending of our youth when pain starts taking over?
I just don't know if I can ever just let it go
Everything's falling apart
When love is real, there's never closure
I guess it's all part of life
But I can't help but feel low
We spend our youth with arms and hearts wide open
And then the dark gets in and that's the end of youth
We spend our youth with arms and hearts wide open
And then the dark gets in and that's the end of youth""",
    },
    {
      "icon": EvaIcons.colorPaletteOutline,
      "title": "Colourblind",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Kaleidoscope love
Yeah, that is you and me
Forever changing
We make life interesting
Some days we're red and some days we both think green
But I like the nights when we leave the canvas free

Grab a brush and see where the feeling may lead
Nothing is out of our reach
Our words are mixing the pigment we need
Can we get started?

I keep falling deeper in dark blue
Brighter than white
Rainbows exploding
But I can't see nothing
Except you and your eyes
Maybe we'll just paint the night colourblind

In every spectrum we find the millionth piece
Connect the dots and everything in between
Mm, dull in the moment, you'll turn it golden leaf
You take the dark away and that's no easy feat

Pick an orange, watch the shade change in the heat
From yellow, purple, and green
Your words are mixing each pigment we need
Can we get started?

I keep falling deeper in dark blue
Brighter than white
Rainbows exploding
But I can't see nothing
Except you and your eyes
Maybe we'll just paint the night colourblind, mm
Maybe we'll just paint the night colourblind""",
    },
    {
      "icon": Icons.wb_sunny_outlined, //LineIcons.windows,
      "title": "Curtains",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Can you pull the curtains?
Let me see the sunshine
I think I'm done with my hiding place
And you found me anyway
It's been forever, but I'm feeling alright
Tears dry and will leave no trace
And tomorrow's another day

Hide and seek
I am somewhere, closed away
You won't believe
How long it's been, since I started the game
I can't be seen
And you won't find me today
I've not been this low but I'll be okay

Are you alright? Maybe, don't ask
'Cause you know I never like to talk about that
Keep it inside, yeah, you say I always hold back
And I always wear long sleeves
Is it in your childhood? Something happen in your past?
Well, the sadness, yeah, I promise that it won't last
And if I could, I would try to take it all back
There's still more underneath
And it's when you say to me

Can you pull the curtains?
Let me see the sunshine
I think I'm done with my hiding place
And you found me anyway
It's been forever, but I'm feeling alright
Tears dry and will leave no trace
And tomorrow's another day

Let me see the sun shine, shine, shine
Let me see the sun shine, shine, shine
Let me see the sun shine, shine, shine
Let me see the sun shine

Hide and seek
Count to ten and close your eyes
Try to breathe
See a message and don't reply
Nice to meet, but in reality, say goodbye
Life can be so beautiful, if you try

Are you okay? Yeah, I guess so
But on some days, I feel like I'm trapped in a hole
But I keep quiet, so the ones around me don't know
That the mountain feels so steep
And I'll say that I'm here to help to carry the load
And the outside rays, they are good for the soul
So let's step out of the dark, 'cause in here, it's so cold
The day's not out of reach
And it's when you say to me

Can you pull the curtains?
Let me see the sunshine
I think I'm done with my hiding place
And you found me anyway
It's been forever, but I'm feeling alright
Tears dry and will leave no trace
And tomorrow's another day

Let me see the sun shine, shine, shine
Let me see the sun shine, shine, shine
Let me see the sun shine, shine, shine
Let me see the sun shine""",
    },
    {
      "icon": LineIcons.circle,
      "title": "Borderline",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Sadness always finds an in
Sneaks its way past, infecting everything
And every chapter has an end
But this is one momentous sequel, don't you think?

And the blackbirds, they fly
Like a frown on the skyline

Right now, I feel I'm running from the light
Engulfed in darkness
Shielded from my eyes
One foot in, one out
I'm stuck on the borderline
Which way will I?

Guess I should take this on the chin
But I don't even know how all of this began
We are made to mould and bend
How can I wish for nothing when it's still a sin?

Right now, I feel I'm running from the light
Engulfed in darkness
Shielded from my eyes
One foot in, one out
I'm stuck on the borderline
Which way will I?

Tears never arrive
These ducts are dry
We are so blind
Waiting on the borderline
Waiting on the borderline

So, I will pour another drink
And try to drown the pain with salt along the rim
And I'll shut off the things I think
'Cause nothing good will ever come from worrying

Right now, I feel I'm running from the light
Engulfed in darkness
Shielded from my eyes
One foot in, one out
I'm stuck on the borderline
Which way will I?

Tears never arrive
These ducts are dry
We are so blind""",
    },
    {
      "icon": Ionicons.flash_outline,
      "title": "Spark",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """We've been lost for a long time
In a rut, no escape signs
And for love, we were so blind
Oh, I hate to see you cry
There've been times where the truth lied
Now it's clear as a blue sky

Like a Band-Aid over deeper cuts, we tried
But couldn't stop the fate descending on the night

We'll build a fire and torch our old lives
And hope the spark survives
Use words as kindling
Light up the night sky
Let the memories take flight
And hope the spark survives
Yeah, we hope the spark survives

Oh, I wonder will we pull through?
All we ever do is argue
With not a lot, but we make do
How I wish you wouldn't say that
There are things you can't take back
When you leave, I always face facts

Like a hand that's trying to hold the water back
Couldn't stop the ocean leaking in the cracks

We'll build a fire and torch our old lives
And hope the spark survives
Use words as kindling
Light up the night sky
Let the memories take flight
And hope the spark survives
Yeah, we hope the spark survives

We've taken roads (We've taken roads)
That led to confusion
But right now that don't matter at all (Nah, nah)
We'll bring it back (We'll bring it back)
Our love's no illusion
The higher we go, the harder we fall and now

We'll build a fire and torch our old lives
And hope the spark survives
Use words as kindling
Light up the night sky
Let the memories take flight
And hope the spark survives
Yeah, we hope the spark survives
And we hope the spark survives""",
    },
    {
      "icon": Icons.star_border, //grass_outlined,
      "title": "Vega",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Rain keeps beating on the rooftop
Muddying the glass but
God, I love the sound of heaven
Sat cross-legged on the carpet, listening to vinyl
Trying to ignore the weather

This week was heavy, I buckled under all the weight
What can you do but pray?
And count your blessings, it wasn't any other way
Don't leave it up to fate

Fighting the tide but the waves, they will part
Light up the night, we were made to be stars
But it burns like hell to be Vega

Clouds keep forming over this house
Blocking out the sun
I'm trying to keep it all together
One door closes then one opens
Gotta keep the focus
If we'll believe then she'll get better

The days are long but they pass within an instant, babe
It is the strangest thing
I'll count my blessings the day I see you smile again
This war we've got to win

Keep it inside, don't let no one see your heart
No one can judge, we're the same in the dark
Fighting the tide, but the waves, they will part
Light up the night, we were made to be stars
But it burns like hell to be Vega

Same problems, different options
Pain comes at a cost, but we've got this
Need respite, bleed time dry
She'll be fine, she'll be fine

Same problems, different options
Pain comes at a cost, but we've got this
Need respite, bleed time dry
She'll be fine, she'll be fine

Rain keeps beating on the rooftop
Worrying to death but
I guess this is human nature
We are meant to shine like stars but
That don't mean it don't burn like hell to be Vega """,
    },
    {
      "icon": Icons.eco_outlined,
      "title": "Sycamore",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Sycamore in the summer bearing leaves
Swing, you're pushing our daughter underneath
Flowers bloom in the garden, sway in breeze
Just imagine a world where we could be

Right now in the waiting room, emotions running wild
Worried 'bout my lover and I'm worried 'bout our child
And part of me was always in denial
It's gonna take a little while

We're in our story, love in, love out
And we are glorious
We're in our story, love in, love out
And we are glorious

Sycamore bringing shade from beating sun
Nothing more than a word, a smoking gun
What a puzzle is this to be in love
To be planting your roots then dig them up

Waiting on professionals to tell you how it is
What's he gonna say after 'I think you better sit'?
Brace yourself, something's about to hit
It's gonna take a little while

We're in our story, love in, love out
And we are glorious
We're in our story, love in, love out
And we are glorious

We're in our story, love in, love out
And we are glorious
We're in our story, love in, love out
And we are glorious

Sycamore in the field, a lonely tree
Darling, what will become of you and me? """,
    },
    {
      "icon": LineIcons.guitar,
      "title": "No Strings",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """If we make it through this year
Then nothing can break us
Trouble leaves then reappears
We've shown we can take it

We tear our hair out and overthink it
Work and get burnt out

But this is no strings, you are who I love
And that won't change when we're falling apart
Yeah, this is no strings, you are who I love
It's just growing pains

If we make it through this year
We should celebrate it
Rarefied atmosphere
'Til now we evaded

We tore the walls down to build them up
Never was in doubt

'Cause this is no strings, you are who I love
And that won't change when we're falling apart
Yeah, this is no strings, you are who I love
It's just growing pains

And we did not fight for love
Just to let it be defeated
What we're going through is common, but
It doesn't mean we don't feel it
It would be easy just to give it up
Guess we've got enough reasons
But every time that we have come undone

I'll say it's no strings, you are who I love
And that won't change when we're falling apart
Yeah, this is no strings, you are who I love
It's just growing pains """,
    },
    {
      "icon": LineIcons.mountain,
      "title": "The Hills of Aberfeldy",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Oh, leaves are covered in snow
And the water's frozen
Oh, I long for you to be the one that I'm holding
And warm me down to my bones
As you lay beside me, hold me close

Oh, leaves are starting to fall
And the sun grows cold
And my heart might break from the weight of it all
For all that I know, you could be holding somebody else as close

When I'm home, I'll hold you like I'm supposed to
Yet I know that I have never told you
Darling, we could fall in love
'Neath the hills of Aberfeldy

Oh, the ground is slowly melting
And the sun beats strong
And I feel like my feet may have wandered too long
And I will remain here alone
'Cause I fear that you may have found someone

When I'm home, I'll hold you like I'm supposed to
Yet I know that I have never told you
Darling, we could fall in love
'Neath the hills of Aberfeldy
Darling, we could fall in love
'Neath the hills of Aberfeldy

Wherever I go, I will always find
Another stranger to share in the weight of my crimes
And I know you will never find
Another heart that wants you more than mine """,
    },
    // Bonus
    {
      "icon": Icons.local_florist,
      "title": "Wild Flowers (Bonus Track)",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Ivy vines that clothe the tree
Daisies look and take a peek
Sun takes colours from the green
And bleaches

December white, a cotton dress
Open lawn to make a nest
Trying to think what I love best
In your features

You were born to run and run
'Til you find your fire
I saw what you'd become
I know, I know
Blossoming among the wildflowers, flowers

Daggers white, they cut through skin
A new addition to your grin
To reach the end we must begin
To feel it

Lie and trace you on the grass
Hair that makes a question mark
You'll always be in my heart
I mean it

You were born to run and run
'Til you find your fire
I saw what you'd become
I know, I know
Blossoming among the wildflowers, flowers

You were born to run and run
'Til you find your fire
I saw what you'd become
I know, I know
Blossoming among the wildflowers, flowers """,
    },
    {
      "icon": Icons.smoking_rooms_outlined,
      "title": "Stoned (Bonus Track)",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """I wasn't looking for a hideaway
I need the heat of a thousand bodies
Crowds will devour, I don't need breathing space
Consumed by hopelessness and all my worries

Save me, colours erase, nothing will fill up the space
I'm drowning under the waves and so out of place
I'm feeling a way, maybe this life was a waste
Should I just throw it away?

All my friends have settled and grown
And then there's me here dancing alone
Fuelled by heartbreak mixed with the chemicals
They are sleeping and I am stoned

All my friends have settled and grown
And then there's me here dancing alone
Am I breathing into my detriment?
I'll keep bleeding and I'll be stoned

I don't want to have to cry again
Or say to them "Goodbye and I'm so sorry"
This pain crescendos right until the end
Keep telling myself that it's them and not me

Save me, colours erase, nothing will fill up the space
Drowning under the waves and so out of place
I'm feeling a way, maybe this life was a waste
Should I just throw it away?

All my friends have settled and grown
And then there's me here dancing alone
Fuelled by heartbreak mixed with the chemicals
They are sleeping and I am stoned

All my friends have settled and grown
And then there's me here dancing alone
Am I breathing into my detriment?
I'll keep bleeding and I'll be stoned

All my friends have settled and grown
And then there's me here dancing alone
Fuelled by heartbreak mixed with the chemicals
They are sleeping and I am stoned

All my friends have settled and grown
And then there's me here dancing alone
Am I breathing into my detriment?
I'll keep bleeding and I'll be stoned """,
    },
    {
      "icon": Ionicons.fitness_outline,
      "title": "Toughest (Bonus Track)",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """I don't know what to think
The word cut through the day
The doctor said it's cancer
And the baby's on the way
Life changes in a blink
Decisions to be made
They say radio's the answer
And that both lives can be saved

Points for timing, it could not get worse
What the hell are we going to do?
But you're the type to defeat the hardest obstacles
Put in front of you

You are the toughest in the room
And I know that love will get us through
And life will overcome the pain that grows in you
'Cause you are the toughest in the room
You showed me strength I never knew
When love is on our side
There's just no way to lose
But I still can't help but break down

Still waiting on a call
Then an action plan is made
In the middle of a court case
Shows what really matters, babe
The specialists in North
En route we'll chose our child's name
'Cause we've had enough surprises
For a lifetime, wouldn't you say?

The word he said, it had the upmost power to
Change the world to blue
But you're the type to defeat the hardest obstacles
Put in front of you

You are the toughest in the room
And I know that love will get us through
And life will overcome the pain that grows in you
'Cause you are the toughest in the room
You showed me strength I never knew
When love is on our side
There's just no way to lose
But I still can't help but break down

All night long
Tossing and turning and begging
Please hold on

'Cause you are the toughest in the room
I know that love will get us through
And life will overcome the pain that grows in you
'Cause you are the toughest in the room
You showed me strength I never knew
When love is on our side
There's just no way to lose
But I still can't help but break down """,
    },
    {
      "icon": Icons.directions_run,
      "title": "Moving (Bonus Track)",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """This is the last song I'm writing 'bout you
Up to now, well I'd never tried to
You don't feel any kind of pain like I do
So let's forget it even happened, babe

You're all I thought about whenever I woke
And all I talked about whenever I spoke
All I'd sing when I would hit the high notes
And now it doesn't even matter

If you come back, it's like we never even had that
Every moment when you took my joy away
All the memories mean nothing from today
Up to now I'd never hold back
True emotions make me feel sad
But I never wanna hear your name again
And go back to how it was before you came

Start moving on, moving on
I've been on a roll since you've been gone
Start moving on, moving on
Out of my life, life
Where you belong

This is the last time I'm thinking 'bout you
I used to cry but then was it a crime to?
I spent a lifetime trying to make the right moves
And got myself caught in a pattern, babe

You take a smile and then you turn it to dust
You take what's gold and then you somehow make rust
Every lie, it made it harder to trust
But now it doesn't even matter

If you come back, it's like we never even had that
Every moment when you took my joy away
All the memories mean nothing from today
Up to now I'd never hold back
True emotions make me feel sad
But I never wanna hear your name again
And go back to how it was before you came

Start moving on, moving on
I feel on a roll since you've been gone
Start moving on, moving on
Out of my life, life
Where you belong

Start moving on, moving on
I feel on a roll since you've been gone
Start moving on, moving on
Out of my life, life
Where you belong """,
    },
    // Deluxe
    {
      "icon": Icons.balance_outlined,
      "title": "Balance (Deluxe Track)",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Perfect time to be trying
But we need to wait and read between the lines
Stay inside, windows dying
I don't want to see the sadness in your eyes
You could say we got a long way to go
I won't
'Cause when tomorrow comes you'll never know
And you know

And even though we're waiting on a miracle
Well I believe in us
Just be here with me and turn the world off
And that will be enough

We could take a day, imagine it
Make paper planes and fly
Stare off into space
Go to a place that all the hurt will die
Balance, all in everything
Balance, see what the dawn brings

Stage fright, need direction
Every second wasted is a little lie
Your mood is my reflection
And though I get it wrong you know I really try
Everyone around us seems to know
What we don't
Maybe in a week it'll be exposed
Let's hope

Up until now I was never spiritual
But I believe in love
Just be here with me and lay within my arms
And that will be enough

We could take a day, imagine it
Make paper planes and fly
Stare off into space
Go to a place that all the hurt will die
Balance, all in everything
Balance, see what the dawn brings

Balance, all in everything
Balance, see what the dawn brings

Perfect time to be trying
But we need to wait and read between the lines
Stay inside, windows dying
Windows dying
Windows dying""",
    },
    {
      "icon": LineIcons.spider,
      "title": "Fear (Deluxe Track)",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Is this a jock that no one's laughing at?
Throwing good energy after bad
Take the credit and then fade to black
I guess this time it's going outside
You take the beating they give
But you didn't do anything criminal
They live in a bubble that nothing can penetrate
Never allowing to slip at all
You're only human, they bleed just like you do
And you're not immune to their ridicule
If they have a thought don't mean that it's right
Because they said out loud, now

Fear is a joy killer
So fuck what they say
No winner, lost spirit
From words on our page
They only say you can't do
When they can't do it
Don't let it get to you babe
Fear is a joy killer
So fuck what they say

Don't let the dark around us get to you
You were born incredible and free
A wise one can argue or respect a fool
From far away it's difficult who you see
You keep your mouth shut
Head down trying to deal with all the subliminals
Avoid any trouble
Don't giving in to the hate
You cannot play but their hidden rules
You're only human, they bleed just like you do
And you're not immune to their ridicule
If they have a thought don't mean that it's right
Because they said out loud, now

Fear is a joy killer
So fuck what they say
No winner, lost spirit
From words on our page
They only say you can't do
When they can't do it
Don't let it get to you babe
Fear is a joy killer
So fuck what they say

Woo-oo-oo-oo-oo
So fuck what they say
Woo-oo-oo-oo-oo

Fear is a joy killer
So fuck what they say
No winner, lost spirit
From words on our page
They only say you can't do
When they can't do it
Don't let it get to you babe
Fear is a joy killer
So fuck what they say

Woo-oo-oo-oo-oo
So fuck what they say
Woo-oo-oo-oo-oo

Woo-oo-oo-oo-oo
So fuck what they say
Woo-oo-oo-oo-oo""",
    },
    {
      "icon": Icons.check,
      "title": "Get Over It (Deluxe Track)",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """Started off with one kiss
Standing in a red dress
Silhouette the sunset
Ripple in the breeze
Finished with a book and
Saying better off friends
Even though you weren't friends
Before you'd ever meet

Lovers to strangers
Watch how it changes
It's such a shame
To end like this
To end like this
Get over it

I know we failed, at least we tried
Oh I, I know we did
Yeah your words will bruise my pride
Tonight it stings a bit
In a losing state of mind
I cry "Is that all there is?"
And it hurts to say goodbye
But I'll get over it

Shouting from a sentence
But it's not the way you meant it
Should have given more attention
In to the little red lights
I no longer know you
I used to love the old you
But I guess I should have told you
Way before tonight

Lovers to strangers
Watch how it changes
It's such a shame
To end like this
To end like this
Get over it

I know we failed, at least we tried
Oh I, I know we did
Yeah your words will bruise my pride
Tonight it stings a bit
In a losing state of mind
I cry "Is that all there is?"
And it hurts to say goodbye
But I'll get over it

One day there will be someone else
In your life
And I know my love it can't be helped
Tonight
I knew you better than I know myself
But it's time
Yeah, it's time
To get over it

I know we failed, at least we tried
Oh I, I know we did
Yeah your words will bruise my pride
Tonight it stings a bit
In a losing state of mind
I cry "Is that all there is?"
And it hurts to say goodbye
But I'll get over it """
    },
    {
      "icon": Ionicons.calendar_outline,
      "title": "Ours (Deluxe Track)",
      "artist": "Ed Sheeran",
      "liked": true,
      "lyrics": """
One, two, one, two

Good news, in a month, we'll know more
The due date's the same and the MRI can wait
The drive there was long, but the drive back relief flooded over us
And we will pay the cost

Oh, I love you, I will not stop saying that
Moments we can't take back forward from this hour, minute, second
What would I do if you don't guide the way home?
I know I should stay strong if only for now

Living like life is fleeting
In a blink, it all could change
So just grab all you can take
Feeling like time is speeding
All I know is that tomorrow is not promised
But today, today is ours
Today is ours

It's soon, but better to be certain
It drives us insane, all the plates that we spin
Perspective's a bitch
Never again complain about the smallest things
We won't let them in

Oh, I love you, I will not stop saying that
Moments we can't take back forward from this hour, minute, second
What would I do if you don't guide the way home?
I know I should stay strong if only for now

Living like life is fleeting
In a blink, it all could change
So just grab all you can take
Feeling like time is speeding
All I know is that tomorrow is not promised
But today, today is ours
Today is ours

And I want to see the sun rise and set
Count the stars, today is ours
What if right now is all that we get
The end and start

Living like life is fleeting
In a blink, it all could change
So just grab all you can take
Feeling like time is speeding
All I know is that tomorrow is not promised
But today

Living like life is fleeting
In a blink, it all could change
So just grab all you can take
Feeling like time is speeding
All I know is that tomorrow is not promised
But today, today is ours
Today is ours """
    },
  ];

  bool isFav = true;

  void findIndex() async {
    for (var i = 0; i < albumSongs.length; i++) {
      if (albumSongs[i]["title"] == widget.musicData["title"]) {
        currentIndex = i;
      }
    }
  }

  void playPause() async {
    await widget.player.playOrPause();
    isPlaying = !isPlaying;
    setState(() {});
  }

  void previous() async {
    currentIndex--;
    if (currentIndex < 0) {
      currentIndex = albumSongs.length - 1;
    }
    await widget.previous();
    setState(() {});
    // widget.player.playlistPlayAtIndex(currentIndex);
  }

  void next() async {
    currentIndex++;
    if (currentIndex >= albumSongs.length) {
      currentIndex = 0;
    }
    await widget.next();
    setState(() {});
    // widget.player.playlistPlayAtIndex(currentIndex);
  }

  int repeatMode = 0;
  List loopModes = [LoopMode.none, LoopMode.playlist, LoopMode.single];
  void repeat() async {
    repeatMode++;
    if (repeatMode > 2) {
      repeatMode = 0;
    }
    await widget.player.setLoopMode(loopModes[repeatMode]);
    setState(() {});
  }

  bool isShuffling = false;
  void shuffle() async {
    widget.player.toggleShuffle();
    isShuffling = !isShuffling;
    setState(() {});
  }

  bool isDarkMode = false;
  void darkMode() {
    isDarkMode = !isDarkMode;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findIndex();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: isDarkMode == true ? Colors.black : Color(0xfff1d80b),
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    // );
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff101010) : primaryYellow,
      appBar: AppBar(
        backgroundColor: isDarkMode == true ? Color(0xff101010) : primaryYellow,
        elevation: 0.0,
        foregroundColor: isDarkMode == true ? primaryYellow : Colors.black,
        title: Text(
          "Subtract",
          style: GoogleFonts.nunito(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            // color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              darkMode();
            },
            icon: Icon(
              Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Album Art
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              isDarkMode == false
                  ? Hero(
                      tag: "albumArt",
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.48,
                        // color: Color(0xff101010),
                        child: Image.asset(
                          "assets/images/edsheeran.webp",
                          // "assets/images/subtract-ed-sheeran.gif",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.48,
                      color: Color(0xff101010),
                      child: Image.asset(
                        // "assets/images/edsheeran.webp",
                        "assets/images/subtract-ed-sheeran.gif",
                        fit: BoxFit.cover,
                      ),
                    ),
              Container(
                height: 30.0,
                child: WaveWidget(
                  config: CustomConfig(
                    colors: isDarkMode == true
                        ? [
                            Colors.brown,
                            Colors.orange,
                            Colors.orangeAccent,
                            Colors.yellow,
                          ]
                        : [
                            Colors.orange,
                            Colors.grey[900]!,
                            Colors.yellowAccent,
                            Colors.yellow,
                          ],
                    durations: [
                      4000,
                      5000,
                      6000,
                      7000,
                    ],
                    heightPercentages: [
                      0.5,
                      0.6,
                      0.7,
                      0.8,
                    ],
                  ),
                  // backgroundColor: Color(0xFFF15BB5),
                  size: Size(double.infinity, double.infinity),
                  waveAmplitude: 0,
                ),
              ),
            ],
          ),

          Container(
            color: isDarkMode == true ? Color(0xff101010) : primaryYellow,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              children: [
                SizedBox(height: 60.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                albumSongs[currentIndex]["title"],
                                style: GoogleFonts.nunito(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode == true
                                      ? primaryYellow
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                albumSongs[currentIndex]["artist"],
                                style: GoogleFonts.nunito(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode == true
                                      ? primaryYellow.withOpacity(0.5)
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      isFav == true
                          ? IconButton(
                              onPressed: () {
                                isFav = !isFav;
                                setState(() {});
                              },
                              icon: Icon(
                                Ionicons.heart,
                                size: 25.0,
                                color: isDarkMode == true
                                    ? primaryYellow
                                    : Colors.black,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                isFav = !isFav;
                                setState(() {});
                              },
                              icon: Icon(
                                Ionicons.heart_outline,
                                size: 25.0,
                                color: isDarkMode == true
                                    ? primaryYellow
                                    : Colors.black,
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                // Seeker
                widget.player.builderCurrentPosition(
                  builder: (context, duration) => Container(
                    width: double.infinity,
                    height: 32.0,
                    child: Slider(
                      value: widget.player.currentPosition.value.inSeconds
                          .toDouble(),
                      min: 0,
                      max: widget.player.current.valueOrNull == null
                          ? 100.0
                          : widget
                              .player.current.value!.audio.duration.inSeconds
                              .toDouble(),
                      activeColor: isDarkMode == true
                          ? primaryYellow
                          : Color(0xff101010),
                      inactiveColor: isDarkMode == true
                          ? primaryYellow.withOpacity(0.2)
                          : Color(0x44101010),
                      onChanged: (change) => {
                        widget.player.seek(
                          Duration(seconds: change.toInt()),
                        ),
                      },
                    ),
                  ),
                ),
                // Current Postion and Duration
                widget.player.builderCurrentPosition(
                  builder: (context, duration) => Container(
                    width: double.infinity,
                    height: 20.0,
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (duration.inSeconds ~/ 60)
                                  .toString()
                                  .padLeft(2, '0') +
                              ":" +
                              ((duration.inSeconds % 60).toInt())
                                  .toString()
                                  .padLeft(2, "0"),
                          style: TextStyle(
                            fontSize: 11.0,
                            color: isDarkMode == true
                                ? primaryYellow
                                : Colors.black,
                          ),
                        ),
                        Text(
                          widget.player.current.valueOrNull == null
                              ? "00:00"
                              : (widget.player.current.value!.audio.duration
                                              .inSeconds ~/
                                          60)
                                      .toString()
                                      .padLeft(2, '0') +
                                  ":" +
                                  ((widget.player.current.value!.audio.duration
                                                  .inSeconds %
                                              60)
                                          .toInt())
                                      .toString()
                                      .padLeft(2, "0"),
                          style: TextStyle(
                            fontSize: 11.0,
                            color: isDarkMode == true
                                ? primaryYellow
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                // Controlls
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          shuffle();
                        },
                        child: Icon(
                          Ionicons.shuffle_outline,
                          size: 30.0,
                          color: isShuffling == true
                              ? Colors.green
                              : (isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              previous();
                            },
                            child: Icon(
                              Icons.skip_previous_rounded,
                              size: 60.0,
                              color: isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              playPause();
                            },
                            child: Icon(
                              isPlaying == true
                                  ? Icons.pause_circle_filled_outlined
                                  : Icons.play_circle_fill_outlined,
                              size: 70.0,
                              color: isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              next();
                            },
                            child: Icon(
                              Icons.skip_next_rounded,
                              size: 60.0,
                              color: isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          repeat();
                        },
                        child: Icon(
                          repeatMode == 0
                              ? Ionicons.repeat_outline
                              : repeatMode == 1
                                  ? Ionicons.repeat_outline
                                  : Icons.repeat_one,
                          size: 30.0,
                          color: repeatMode == 0
                              ? (isDarkMode == true
                                  ? primaryYellow
                                  : Colors.black)
                              : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 17.0),
            padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 17.0),
            decoration: BoxDecoration(
              color: isDarkMode == true
                  ? Colors.yellowAccent.withOpacity(0.05)
                  : Color(0xff101010),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lyrics",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Divider(color: primaryYellow.withOpacity(0.2)),
                SizedBox(height: 10.0),
                Text(
                  albumSongs[currentIndex]["lyrics"],
                  style: TextStyle(
                    color: isDarkMode == true ? primaryYellow : primaryYellow,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 200.0),
        ],
      ),
    );
  }
}
