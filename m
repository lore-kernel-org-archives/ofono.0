Content-Type: multipart/mixed; boundary="===============8339067183203455516=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 11:57:59 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157B51C@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <4D49AF0C.4030809@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8339067183203455516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> -----Original Message-----
> From: ext Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Wednesday, February 02, 2011 9:23 PM
> To: ofono(a)ofono.org
> Cc: Zabaluev Mikhail (Nokia-MS/Helsinki)
> Subject: Re: [RFC 2/2] doc: Add description for history agent interface
> =

> This has been discussed to death a bazillion times.  So lets recap very
> quickly:
> =

> AT modems have two ways of delivering SMS messages:
> - CMTI
> - CMT
> =

> CMTI delivery means the message goes to the SIM / ME store first, and
> then signaled up.  The modem takes care of automatically acking the
> message in this case.  CMT delivery gives the message straight to the
> sms driver and expects messages to be acked.
> =

> Here's the problem, half the modems in this world don't support CMTI
> delivery, the other half does not support CMT delivery.  oFono core
> does
> not know or care what mechanism is used.  It is the driver's
> responsibility to ack the received pdu.

Sorry, I'm quite new to oFono.
My gut instinct tells me that oFono should be able to hide the difference b=
y providing CMTI-like spool semantics to the client in all cases. But I mig=
ht be missing quite a lot of background here.

> If CMTI delivery is used, then the core has to care about SIM / ME
> storage, reading of the SMS store and managing free space -> disaster
> area.  Been there, got the t-shirt.

So, it's less disastrous if you implement some file-backed spool for both m=
odels.

> If CMT delivery is used, you have to ack the message in a 'reasonable'
> period of time.  If you do not, then the modem silently (e.g. it does
> not tell you) turns off SMS delivery.  Of course you can send a
> negative
> ack, however, there is no mechanism that I'm aware of to tell the
> network you can receive SMS messages again -> disaster area.
> =

> Another fun fact about CMT delivery is that if you do not ack in a
> 'reasonable' amount of time, the modem _silently_ turns off SMS
> delivery.  So putting acks over D-Bus is simply a bad idea.
> =

> So oFono:
>  1. Parses the SMS
>  2. If the SMS is a multi-fragment SMS, it is written to store
> 2a. If the SMS is the last missing fragment goes to step 2b, otherwise
> goes to step 5
> 2b. re-assembles the sms and removes intermediate store
>  3. Signals the SMS over D-Bus / history
>  4. Returns control to the driver which is responsible for acking the
> SMS if needed.

But this means that you do put a D-Bus roundtrip (step 3) in the loop for a=
cks --> bad idea?
Also, the first fragment may not be acked until you got the whole message A=
ND confirmed to have stored it? Can it even work reliably in all networks?

> > 1. The history service may be activated on demand by a well-known
> name.
> =

> D-Bus service activation on system bus is not available, please stop
> bringing this up.

Really? OK, scratch that.

> > 2. You don't want multiple entities to observe events pertaining to
> oFono communication history and be able to control spooling while not
> being regulated by oFono.
> > If this is a concern, I think it's outweighed by greater simplicity
> and flexibility, and the idea that access policy should be defined
> outside of the implementation.
> >
> > 3. For call history, you need reliable storage of call events before
> you can proceed handling the call with the interactive client
> signaling.
> > I thought this is entirely up to the application and as such does not
> have to be in scope for oFono. Correct me if I'm wrong.
> >
> =

> Sorry but I do not understand the above two points.  Can you clarify
> what exactly you mean here?  The actual history storage is indeed not
> in
> scope of oFono.  That is up to the system integrator to figure out.

True. My point is, there is no real need for a dedicated "history storage" =
service on the oFono level.

Best regards,
  Mikhail

--===============8339067183203455516==--

