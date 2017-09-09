Content-Type: multipart/mixed; boundary="===============8287542417507003059=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 1/7] netmon: modified api.txt for network monitor agent
Date: Sat, 09 Sep 2017 12:30:42 +0300
Message-ID: <d788f3ec-c02d-1237-c3ae-2e6a1d3270b4@jolla.com>
In-Reply-To: <da52a7d8-959d-483b-f309-be71a3e34ef2@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8287542417507003059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Hi Slava,
>>
>> In the Sailfish OS case, one is the positioning helper, and there's =

>> the factory test app. That makes it at least two. The factory test =

>> app often plays the role of the second client since it's touching =

>> pretty much all the important interfaces in the system. And there are =

>> 3rd party apps which we don't control.
>
> See? This wasn't that hard ;)
>
> How does the factory test app use this info?  Does it need actual =

> periodic updates or can it simply obtain this via the method call?
>

Our RIL plugin decides on the update rate internally, based on the =

device state (limiting the rate when the screen turns off).

Different clients have different needs - some need updates only when the =

screen is on (if they are just displaying something on the screen) and =

some may always need updates (a background task collecting some data or =

whatever). The optimal solution may be quite specific to the environment =

where ofono is used.

> I'm open to the idea of supporting multiple agents.  We do have to =

> figure out who dictates the periodic update interval.  One approach =

> might be to have a single master agent and multiple observer agents. =

> Feel free to propose something.

You (correctly) said that the agent approach saves some system resources =

by not sending unnecessary signals if no one is interested in this =

information. However, in all other cases the agent (method call) =

approach is less efficient than signals.

ofono calls dbus-daemon, the daemon calls the agent, each call has a =

reply, so the total number of D-Bus packets per notification comes to =

4*n where n is the number of agents (or 2*n if the caller sets =

NO_REPLY_EXPECTED flag).

If you are using signals, the number of packets involved is n+1 (one =

packet from ofono to the daemon and then one to each interested client). =

Obviously, (n+1) > 2*n (let alone 4*n) if and only if n =3D 0. Not to =

mention that signals are significantly easier to use than (especially, =

multiple) agents.

That said, this NetworkMonitor thing is what it is and you decide how it =

works. If it doesn't suit our needs (and it doesn't) I just implement my =

own (and I did). I'm not in the mood to argue whose implementation is =

better. Everything can be done in so many different ways, so let a =

hundred flowers bloom.

Cheers,
-Slava

>
> Regards,
> -Denis
>


--===============8287542417507003059==--

