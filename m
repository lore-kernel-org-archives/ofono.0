Content-Type: multipart/mixed; boundary="===============8489863329384433454=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 01:13:00 -0600
Message-ID: <4D4A557C.1070302@gmail.com>
In-Reply-To: <E9010BA84901F04DBE0FC93A424E0E4501097604@008-AM1MPN1-035.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8489863329384433454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

> So handling this might still be useful even if reliable re-enabling =

> of messages would not work reliably (assumption being that recycling and
> reregistering will reliably reenable message delivery). Or do you have =

> practical experience of cases where even a power cycle won't help...
> (e.g. 23.040 specificly handles this scenario so modems should
> handle this correctly)?

Last I checked 27.005 mentions nothing on the behavior of sms store full
conditions or naking.  So all of this would be highly entertaining for
someone to discover ;)

The number of AT modems that utterly mess up SMS is amazing.  Have a
look at drivers/atmodem/sms.c sometime, particularly grep for VENDOR.
And that driver is sane compared to things I've seen elsewhere.

There is still the practical considerations of when / if to start naking
messages. Remember you can have multiple history plugins, so what if the
first one succeeds but the second one fails?  What if this was just a
transient error and you are now silently blocking the user from
receiving SMSes?  Is it better to drop a single SMS or lots of them?
How do you notify the user something is wrong?

Catastrophic conditions really need to be taken care of by self test /
device health management.  If a hardware fault is detected, then panic
and shutting down as many devices (including the modem) is probably wise.

In the end the ack feature was meant for SIM/ME store and out of memory
conditions for the very limited storage those devices had.  Since the
user was managing the SMS store, it made sense to have this capability.
 Modern systems are a totally different animal.

>> So yes, there might be conditions where you crash before fsync really
>> completes and you lose the SMS.  However, there's nothing in the world
>> you can do about this case anyway, since both the write and the fsync
>> succeeded.
> =

> I think this is perfectly reasonable. Even if some storage system =

> had some internal caches outside the kernel sync's reach, I'd imagine
> flushing these would be a prime candidate for last-minute actions done
> before battery dies (or some sensor detecting the device is about to
> hit a brick wall in about a few milliseconds ;)). =

> And in general, fsync should just be enough:
> http://thunk.org/tytso/blog/2009/03/15/dont-fear-the-fsync/

Of course, fsync is the best you can do.  I'm just pointing out that
even with fsync you're not guaranteed to 'safely' receive the SMS.  You
can still get astronomically unlucky: fsync, ack the message but still
crash before it has a chance to appear on the physical media or corrupt
the filesystem some other way.

Regards,
-Denis

--===============8489863329384433454==--

