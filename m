Content-Type: multipart/mixed; boundary="===============5835155671509218468=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Cinterion EHS6 support
Date: Wed, 29 Apr 2015 22:11:41 +0200
Message-ID: <55413AFD.40703@dynamicdevices.co.uk>
In-Reply-To: <55413915.4000707@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5835155671509218468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 29/04/2015 22:03, Alex J Lennon wrote:
>
> On 29/04/2015 21:17, Denis Kenzior wrote:
>> Hi Alex,
>>
>>> I understand. I am not sure what the differences are between the tc65
>>> and the ehs6. I'll speak with Gemalto/Cinterion to get some
>>> clarification on this.
>> Sure.  In the past we have found that the modem firmware is similar
>> enough that no changes are needed between different modem families
>> from the same manufacturer.  There were one or two exceptions of course.
>>
>>> My thought process for splitting it out was along these lines:
>>>
>>> At present I am focussed just on supporting a data-connection for one of
>>> our boards with the EHS6 on it with connman/ofono.
>>>
>>> We'll be working with the EHS6 and probably the EHS5 extensively over
>>> the next few years on a range of board products so I will likely be
>>> testing out other functionalities for the EHS6 such as voice, sms etc.
>>> etc. I imagine.
>>>
>>> I can prove this out on our hardware and provide any needed patches
>>> upstream if that is of use.
>>>
>>> But we don't plan to make use of the TC65 and so I can't commit to
>>> ensuring that anything I implement for the EHS6 would work for the TC65,
>>> or indeed wouldn't break the current TC65 implementation.
>> Some things can be done by eye-balling the code.  For example, I just
>> ran a diff on the code you submitted.  The only difference between
>> plugins/ehs6.c and plugins/tc65.c is the vendor quirk for
>> ofono_netreg_create.  Something that tc65 also probably needs.
>>
>>> I assumed that the current tc65 code worked, although it wasn't working
>>> for me on the ehs6, and as I don't know what's' going on there I was
>>> keen not to make any potentially breaking changes that might cause
>>> others problems.
>> I'm not quite sure why that would be the case.  Registering for CIND
>> indications that will never come should not cause any significant
>> issues... =

> Yes I take your point Denis. Taking a step back, if I run with the
> unpatched tc65 plugin I see
>
> ofonod[1886]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
> 00, 28
> ofonod[1886]: > AT+CIND=3D?\r
> ofonod[1886]: < AT+CIND=3D?\r
> ofonod[1886]: < \r\n+CIND :     ("call",(0,1)),     ("roam",(0,1))     \r=
\n
> ofonod[1886]: < \r\nOK\r\n
> ofonod[1886]: This driver is not setup with Signal Strength reporting
> via CIND indications, please write proper netreg handling for this device
> ofonod[1886]: src/network.c:netreg_remove() atom: 0x12eb408
>
> This is what lead me to the patch I used here:
> https://lists.ofono.org/pipermail/ofono/2012-March/012590.html
>
> So it would appear that something is unhappy in the response parsing in
> network-registration.c  cind_support_cb() leading us to arrive at the
> error label?
>
> One option is to disable the sending of the AT+CIND=3D? as Reynaldo
> originally did, but perhaps a preferable solution is to work out what's
> failing here.
>
> Does anything leap out at you as unexpected from the above response?
>

It looks as though the issue is that the Cinterion parts don't support
signal strength via +CIND ?

Yet in at_signal_strength() it looks to me as though if this is the case
the code will fall back happily to using +CSQ

That being the case I'm not sure why cind_support_cb() should be
reporting an error and removing the device when it should be able to
fallback and continue?

Regards,

Alex


--===============5835155671509218468==--

