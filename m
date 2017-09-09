Content-Type: multipart/mixed; boundary="===============1053215478451793143=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] netmon: modified api.txt for network monitor agent
Date: Sat, 09 Sep 2017 11:11:21 -0500
Message-ID: <c16f733e-1b4b-7f4e-00be-fbe867330ecd@gmail.com>
In-Reply-To: <d788f3ec-c02d-1237-c3ae-2e6a1d3270b4@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1053215478451793143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 09/09/2017 04:30 AM, Slava Monich wrote:
> Hi Denis,
> =

>> Hi Slava,
>>>
>>> In the Sailfish OS case, one is the positioning helper, and there's =

>>> the factory test app. That makes it at least two. The factory test =

>>> app often plays the role of the second client since it's touching =

>>> pretty much all the important interfaces in the system. And there are =

>>> 3rd party apps which we don't control.
>>
>> See? This wasn't that hard ;)
>>
>> How does the factory test app use this info?  Does it need actual =

>> periodic updates or can it simply obtain this via the method call?
>>
> =

> Our RIL plugin decides on the update rate internally, based on the =

> device state (limiting the rate when the screen turns off).

And hopefully you understand why hard-coding the behavior in a plugin is =

not a solution for upstream?  Our solution must be generic enough where =

any behavior can be implemented, perhaps with a bit more pain on the =

integrator side.  But the advantage is that it works for every piece of =

hardware that has support for a particular feature.

You have the advantage that you have control or can assume how stuff =

works on your platform.  Hence you can implement such simplistic =

behavior of turning serving cell updates to every minute with screen off =

/ every 1 second with screen on.  Unfortunately upstream cannot make =

such assumptions, cannot rely on hacks and has to implement proper =

solutions.

> =

> Different clients have different needs - some need updates only when the =

> screen is on (if they are just displaying something on the screen) and =

> some may always need updates (a background task collecting some data or =

> whatever). The optimal solution may be quite specific to the environment =

> where ofono is used.

Agreed.  Upstream will try to provide APIs to enable you to do that.  If =

some API doesn't cover your needs, then feel free to contribute and make =

things better.  Complaining and then taking your ball and going home is =

not conducive to upstream paying attention to your needs.  Only through =

active contribution can you influence things.  Just saying...

> =

>> I'm open to the idea of supporting multiple agents.  We do have to =

>> figure out who dictates the periodic update interval.  One approach =

>> might be to have a single master agent and multiple observer agents. =

>> Feel free to propose something.
> =

> You (correctly) said that the agent approach saves some system resources =

> by not sending unnecessary signals if no one is interested in this =

> information. However, in all other cases the agent (method call) =

> approach is less efficient than signals.
> =

> ofono calls dbus-daemon, the daemon calls the agent, each call has a =

> reply, so the total number of D-Bus packets per notification comes to =

> 4*n where n is the number of agents (or 2*n if the caller sets =

> NO_REPLY_EXPECTED flag).
> =


Which we do by the way.  The ServingCellInformationChanged method call =

is already sent as noreply.  It was not marked thus in the =

documentation.  It was an oversight that has been now fixed.

> If you are using signals, the number of packets involved is n+1 (one =

> packet from ofono to the daemon and then one to each interested client). =

> Obviously, (n+1) > 2*n (let alone 4*n) if and only if n =3D 0. Not to =

> mention that signals are significantly easier to use than (especially, =

> multiple) agents.

I don't know what you're arguing here.  Yes in an idealized world having =

n agents is less efficient than having a signal with n observers. =

Multicast is more efficient.  No ****.

But do realize things are never so simple.  You do have to pay a cost =

for this, through complex signal matching data structures, having to set =

up proper Match rules with dbus-daemon, and unsubscribing from such =

signals is sometimes not possible.  Some clients simply don't do this =

properly, and a signal ends up being blasted out to way more clients =

than your idealized model.  But I digress as this isn't what was being =

argued.

Jonas wanted all these to be actual properties.  So a PropertyChanged =

signal would be emitted for each and every one.  Given that we have 20 =

odd properties defined, sending a signal for each one vs a single method =

call out to the agent is more efficient.  Yes we can perform comparisons =

and only emit properties that changed.  But most of these are signal =

related, and so are extremely variable.  The chance that they don't =

change between updates is tiny.

Which by the way is what your vaunted 'own' implementation does.  So its =

not sending 1 signal per update either, is it?  You might want to fix =

that as it doesn't fit your ideal world view ;)

So regardless of how you look at it, the agent approach is more =

efficient than having everything as a property.  That was my original point.

And by the way, the agent approach lets us figure out when a client has =

died and updates are no longer needed.  So we can intelligently turn off =

communication with the modem and not waste resources.  We can also more =

easily control access permissions (as in which application can enable =

updates in the first place) via the security framework.  Those are huge =

design advantages in our view.

> =

> That said, this NetworkMonitor thing is what it is and you decide how it =

> works. If it doesn't suit our needs (and it doesn't) I just implement my =

> own (and I did). I'm not in the mood to argue whose implementation is =

> better. Everything can be done in so many different ways, so let a =

> hundred flowers bloom.

And again I see you taking your ball and going home ;)

Regards,
-Denis

--===============1053215478451793143==--

