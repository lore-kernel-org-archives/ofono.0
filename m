Content-Type: multipart/mixed; boundary="===============2157376968325666641=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 10:11:33 +0000
Message-ID: <E9010BA84901F04DBE0FC93A424E0E4501097910@008-AM1MPN1-035.mgdnok.nokia.com>
In-Reply-To: <4D4A557C.1070302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2157376968325666641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 03 Feb 2011, Denis Kenzior wrote:
>> So handling this might still be useful even if reliable re-enabling
>> of messages would not work reliably (assumption being that recycling
>> and reregistering will reliably reenable message delivery). Or do you
>
> Last I checked 27.005 mentions nothing on the behavior of sms store
> full conditions or naking.  So all of this would be highly entertaining f=
or
> someone to discover ;)

yeah true. I don't think implementing this with AT modems makes
much sense. I was more thinking whether this should be possible with =

oFono and modems, which provide a more sane interface (e.g. isimodem,
see drivers/isimodem/sms.c:send_deliver_report()).

> There is still the practical considerations of when / if to start
> naking messages. Remember you can have multiple history plugins, so =

> what if the first one succeeds but the second one fails?  =


True. If (and that's potentially a big if) this is implemented,
a separate method on org.ofono.MessageManager for stopping
delivery might be a better option. Hmm, although, if this is now
only used in case of device malfunction, then you could just as well
put the modem offline (works with AT modems as well). So let's just =

drop this, unless someone feels more strongly.

> In the end the ack feature was meant for SIM/ME store and out of memory
> conditions for the very limited storage those devices had.  Since the

Yes, much of the specs have been written with this is mind, and
I agree, this is out-of-scope for oFono.

>>> So yes, there might be conditions where you crash before fsync
>>> really completes and you lose the SMS.  However, there's nothing in the
>>
>> I think this is perfectly reasonable. Even if some storage system
>> had some internal caches outside the kernel sync's reach, I'd imagine
> =

> Of course, fsync is the best you can do.  I'm just pointing out that
> even with fsync you're not guaranteed to 'safely' receive the SMS.  You

Bad wording on my side: I was trying to say that I very much
agree with you on this. We are not controlling nuclear reactors
with SMS messages (at least not yet ;)), so no need to go overboard.


--===============2157376968325666641==--

