Content-Type: multipart/mixed; boundary="===============4013160862260385687=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 09:58:10 -0600
Message-ID: <4D4AD092.6030403@gmail.com>
In-Reply-To: <A459777776EB4841B844E1134E7928740157B51C@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4013160862260385687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On 02/03/2011 05:57 AM, mikhail.zabaluev(a)nokia.com wrote:
> Hi Denis,
> =

>> -----Original Message-----
>> From: ext Denis Kenzior [mailto:denkenz(a)gmail.com]
>> Sent: Wednesday, February 02, 2011 9:23 PM
>> To: ofono(a)ofono.org
>> Cc: Zabaluev Mikhail (Nokia-MS/Helsinki)
>> Subject: Re: [RFC 2/2] doc: Add description for history agent interface
>>
>> This has been discussed to death a bazillion times.  So lets recap very
>> quickly:
>>
>> AT modems have two ways of delivering SMS messages:
>> - CMTI
>> - CMT
>>
>> CMTI delivery means the message goes to the SIM / ME store first, and
>> then signaled up.  The modem takes care of automatically acking the
>> message in this case.  CMT delivery gives the message straight to the
>> sms driver and expects messages to be acked.
>>
>> Here's the problem, half the modems in this world don't support CMTI
>> delivery, the other half does not support CMT delivery.  oFono core
>> does
>> not know or care what mechanism is used.  It is the driver's
>> responsibility to ack the received pdu.
> =

> Sorry, I'm quite new to oFono.
> My gut instinct tells me that oFono should be able to hide the difference=
 by providing CMTI-like spool semantics to the client in all cases. But I m=
ight be missing quite a lot of background here.
> =


Actually that is not what we want.  CMTI is pretty damn slow since you
have to store on the SIM first, then signal the core.  And the core has
to delete from the SIM as well.  CMT skips the first step and goes
straight to the core, only the ack is required.

>> If CMTI delivery is used, then the core has to care about SIM / ME
>> storage, reading of the SMS store and managing free space -> disaster
>> area.  Been there, got the t-shirt.
> =

> So, it's less disastrous if you implement some file-backed spool for both=
 models.
> =


And this is what we do, no?

>> If CMT delivery is used, you have to ack the message in a 'reasonable'
>> period of time.  If you do not, then the modem silently (e.g. it does
>> not tell you) turns off SMS delivery.  Of course you can send a
>> negative
>> ack, however, there is no mechanism that I'm aware of to tell the
>> network you can receive SMS messages again -> disaster area.
>>
>> Another fun fact about CMT delivery is that if you do not ack in a
>> 'reasonable' amount of time, the modem _silently_ turns off SMS
>> delivery.  So putting acks over D-Bus is simply a bad idea.
>>
>> So oFono:
>>  1. Parses the SMS
>>  2. If the SMS is a multi-fragment SMS, it is written to store
>> 2a. If the SMS is the last missing fragment goes to step 2b, otherwise
>> goes to step 5
>> 2b. re-assembles the sms and removes intermediate store
>>  3. Signals the SMS over D-Bus / history
>>  4. Returns control to the driver which is responsible for acking the
>> SMS if needed.
> =

> But this means that you do put a D-Bus roundtrip (step 3) in the loop for=
 acks --> bad idea?
> Also, the first fragment may not be acked until you got the whole message=
 AND confirmed to have stored it? Can it even work reliably in all networks?

We do not have a D-Bus roundtrip for the ack.  The ack always happens as
soon as the fragment is delivered.  It is assumed to hit the disk
synchronously in step 2 (for multi-fragment) or step 3 (in history).

Regards,
-Denis

--===============4013160862260385687==--

