Content-Type: multipart/mixed; boundary="===============0313845150056343308=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 1/7] handsfree-audio: Initial DBUS code
Date: Mon, 02 Sep 2013 11:41:43 -0500
Message-ID: <5224BFC7.2000409@gmail.com>
In-Reply-To: <52207206.40608@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0313845150056343308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 08/30/2013 05:20 AM, Fr=C3=A9d=C3=A9ric DALLEAU wrote:
> Hi Denis,
>
>>> +    /* Ask main loop to join */
>>> +    g_idle_add(thread_cleanup, userdata);
>>
>> This part makes no sense to me.  We have two broad cases being covered:
>> 1. Cleaning up the threads on exit, in which case this g_idle_add is
>> pointless since there is no more main loop to run
>> 2. Cleaning up the thread when an exceptional condition occurs, e.g.
>> socket is closed.
>
> There would be a race condition if the thread had to remove itself from
> the threads list while, at same time, the main loop would parse the
> threads list. This is possible if exit and socket close occurs
> simultaneously.
> Thus the threads list is handled from main thread only. This way,
> hfp_thread structure is guaranted to be accessible during thread's life.
>

Of course there would be a race condition if you do not lock the list =

and try to modify it from multiple threads.  What I'm saying is trigger =

the appropriate handler code for the appropriate condition in the main =

thread.

Right now you are always calling g_idle_add when the main loop has =

exited and being cleaned up.  g_idle_add triggers at least two mutex =

locks / unlocks and adding an event to the main loop queue that will =

never be called.  It also makes the code way less readable or =

understandable.

In fact it might be easier to simply use a lock around the thread list =

instead of trying to play main event tricks.  You're not gaining much by =

doing that in the first place.

>> You might want to separate the logic for each appropriately.
>>
>> A more broad question is, why are you using threads in the first place?
>>   Can't we interact with ALSA via regular FD polling?
>
> In theory, snd_pcm_poll_descriptors can be used for that.
> But this depends on ALSA driver implementation and I got some weird
> behavior.
> The sound was choppy using glib polling, so I used threads.

Are you sure this has anything to do with the driver implementation? =

Quickly browsing the ALSA documentation tells me that you're using basic =

read/write operations on an fd, so there should be nothing preventing =

you from using poll/select here.  There are no warnings about driver =

support, only about properly using the revents structure:

"...do not use only returned file descriptors, but handle events member =

as well - see snd_pcm_poll_descriptors function description for more =

details and snd_pcm_poll_descriptors_revents for events demangling)."

Regards,
-Denis

--===============0313845150056343308==--

