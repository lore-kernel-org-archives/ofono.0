Content-Type: multipart/mixed; boundary="===============7446177226618907968=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= DALLEAU <frederic.dalleau@linux.intel.com>
Subject: Re: [PATCH v5 1/7] handsfree-audio: Initial DBUS code
Date: Fri, 30 Aug 2013 12:20:54 +0200
Message-ID: <52207206.40608@linux.intel.com>
In-Reply-To: <521F8163.3050604@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7446177226618907968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> +    /* Ask main loop to join */
>> +    g_idle_add(thread_cleanup, userdata);
>
> This part makes no sense to me.  We have two broad cases being covered:
> 1. Cleaning up the threads on exit, in which case this g_idle_add is
> pointless since there is no more main loop to run
> 2. Cleaning up the thread when an exceptional condition occurs, e.g.
> socket is closed.

There would be a race condition if the thread had to remove itself from =

the threads list while, at same time, the main loop would parse the =

threads list. This is possible if exit and socket close occurs =

simultaneously.
Thus the threads list is handled from main thread only. This way, =

hfp_thread structure is guaranted to be accessible during thread's life.

> You might want to separate the logic for each appropriately.
>
> A more broad question is, why are you using threads in the first place?
>   Can't we interact with ALSA via regular FD polling?

In theory, snd_pcm_poll_descriptors can be used for that.
But this depends on ALSA driver implementation and I got some weird =

behavior.
The sound was choppy using glib polling, so I used threads.

Regards,
Fred



--===============7446177226618907968==--

