Content-Type: multipart/mixed; boundary="===============6860369687625502564=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/2] doc: Add description for history agent interface
Date: Wed, 02 Feb 2011 13:22:52 -0600
Message-ID: <4D49AF0C.4030809@gmail.com>
In-Reply-To: <A459777776EB4841B844E1134E7928740157A1C4@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6860369687625502564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

> =

> Am I right in assuming that the SMS history roundtrip is not performed be=
fore acking the constituent TPDUs to the network? If it is, we have problem=
s even regardless of D-Bus method call timeouts.
> =


This has been discussed to death a bazillion times.  So lets recap very
quickly:

AT modems have two ways of delivering SMS messages:
- CMTI
- CMT

CMTI delivery means the message goes to the SIM / ME store first, and
then signaled up.  The modem takes care of automatically acking the
message in this case.  CMT delivery gives the message straight to the
sms driver and expects messages to be acked.

Here's the problem, half the modems in this world don't support CMTI
delivery, the other half does not support CMT delivery.  oFono core does
not know or care what mechanism is used.  It is the driver's
responsibility to ack the received pdu.

If CMTI delivery is used, then the core has to care about SIM / ME
storage, reading of the SMS store and managing free space -> disaster
area.  Been there, got the t-shirt.

If CMT delivery is used, you have to ack the message in a 'reasonable'
period of time.  If you do not, then the modem silently (e.g. it does
not tell you) turns off SMS delivery.  Of course you can send a negative
ack, however, there is no mechanism that I'm aware of to tell the
network you can receive SMS messages again -> disaster area.

Another fun fact about CMT delivery is that if you do not ack in a
'reasonable' amount of time, the modem _silently_ turns off SMS
delivery.  So putting acks over D-Bus is simply a bad idea.

So oFono:
 1. Parses the SMS
 2. If the SMS is a multi-fragment SMS, it is written to store
2a. If the SMS is the last missing fragment goes to step 2b, otherwise
goes to step 5
2b. re-assembles the sms and removes intermediate store
 3. Signals the SMS over D-Bus / history
 4. Returns control to the driver which is responsible for acking the
SMS if needed.

All of this happens synchronously.  If oFono crashes in steps 1..3, the
message is never acked.  If your history plugin writes to its
intermediate store (which it has to anyway) and fsyncs, there are no issues.

So yes, there might be conditions where you crash before fsync really
completes and you lose the SMS.  However, there's nothing in the world
you can do about this case anyway, since both the write and the fsync
succeeded.

> 1. The history service may be activated on demand by a well-known name.

D-Bus service activation on system bus is not available, please stop
bringing this up.

> If this is in fact mandatory, we'll have problems in making telepathy-rin=
g serve as the history plugin. We want it in the storage path for architect=
ural simplicity: commhistory daemon is by design a Telepathy logger that wo=
rks basically the same way for all connection managers.
> =

> 2. You don't want multiple entities to observe events pertaining to oFono=
 communication history and be able to control spooling while not being regu=
lated by oFono.
> If this is a concern, I think it's outweighed by greater simplicity and f=
lexibility, and the idea that access policy should be defined outside of th=
e implementation.
> =

> 3. For call history, you need reliable storage of call events before you =
can proceed handling the call with the interactive client signaling.
> I thought this is entirely up to the application and as such does not hav=
e to be in scope for oFono. Correct me if I'm wrong.
> =


Sorry but I do not understand the above two points.  Can you clarify
what exactly you mean here?  The actual history storage is indeed not in
scope of oFono.  That is up to the system integrator to figure out.

Regards,
-Denis

--===============6860369687625502564==--

