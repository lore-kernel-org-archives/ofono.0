Content-Type: multipart/mixed; boundary="===============2217681729490948964=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Wed, 02 Feb 2011 22:56:00 +0000
Message-ID: <E9010BA84901F04DBE0FC93A424E0E4501097604@008-AM1MPN1-035.mgdnok.nokia.com>
In-Reply-To: <4D49AF0C.4030809@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2217681729490948964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02 Feb 2011, Denis Kenzior wrote:
> Another fun fact about CMT delivery is that if you do not ack in a
> 'reasonable' amount of time, the modem _silently_ turns off SMS
> delivery.  So putting acks over D-Bus is simply a bad idea.

ack, very much agreed. And now that I realized RX fragment spooling
is in fact already done (sorry for the hassle), all is good =

then for this part.

> So oFono:
>  1. Parses the SMS
>  2. If the SMS is a multi-fragment SMS, it is written to store
> 2a. If the SMS is the last missing fragment goes to step 2b, otherwise
> goes to step 5
> 2b. re-assembles the sms and removes intermediate store
>  3. Signals the SMS over D-Bus / history
>  4. Returns control to the driver which is responsible for acking the
> SMS if needed.

So as long as the history plugin spools the message before
returning back in (4), the whole path is safe.

One corner case missing is:

> not tell you) turns off SMS delivery.  Of course you can send a negative
> ack, however, there is no mechanism that I'm aware of to tell the
> network you can receive SMS messages again -> disaster area.

So as ofono_sms_deliver_notify() never returns an error,
we can't handle the case where e.g. device has run out =

of storage, or other severe malfunction (some system component
crashed). I guess the main worry is to stop messages going
to /dev/null, and less about how to recover. I think these cases
are of such severity that the user must anyways at least reboot =

the device, or even have to take it to customer care (or something =

in between). Just with normal device usage (e.g. by trying to
fill device with user content), this should never happen, so =

the reason must be something more fatal.

So handling this might still be useful even if reliable re-enabling =

of messages would not work reliably (assumption being that recycling and
reregistering will reliably reenable message delivery). Or do you have =

practical experience of cases where even a power cycle won't help...
(e.g. 23.040 specificly handles this scenario so modems should
handle this correctly)?

Oh well, I have to ask around about this as well... perhaps something
we could ignore.

> So yes, there might be conditions where you crash before fsync really
> completes and you lose the SMS.  However, there's nothing in the world
> you can do about this case anyway, since both the write and the fsync
> succeeded.

I think this is perfectly reasonable. Even if some storage system =

had some internal caches outside the kernel sync's reach, I'd imagine
flushing these would be a prime candidate for last-minute actions done
before battery dies (or some sensor detecting the device is about to
hit a brick wall in about a few milliseconds ;)). =

And in general, fsync should just be enough:
http://thunk.org/tytso/blog/2009/03/15/dont-fear-the-fsync/


--===============2217681729490948964==--

