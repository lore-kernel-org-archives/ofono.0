Content-Type: multipart/mixed; boundary="===============1439945246267449343=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Motorola motmdm support
Date: Sun, 30 Dec 2018 14:46:50 -0600
Message-ID: <2c639e8b-2594-6dc6-7dc5-7fad8a81e356@gmail.com>
In-Reply-To: <20181230202454.GF6707@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1439945246267449343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 12/30/2018 02:24 PM, Tony Lindgren wrote:
> * Denis Kenzior <denkenz@gmail.com> [181230 19:32]:
>> You still need someone to send AT+CMUX, no?  And you most likely need to
>> integrate power management into the telephony stack anyway.  As I mentio=
ned,
>> we had a driver like this that worked just fine.  oFono ended up using a
>> user space MUX since most of the quality of life improvements to n_gsm c=
ame
>> in much later.  If I was writing a new MUXed driver these days, I'd
>> seriously consider using GSMIOC_SETCONF and GSMIOC_ENABLE_NET.
> =

> No need to type AT+CMUX or anything, things start in ts 27.010
> mode from the start for the hardware. Then the serdev driver
> layer handles doing GSMIOC_SETCONF.

Gotcha.  That makes things a bit easier.

> =

> I have not played with GSMIOC_ENABLE_NET, I thought that needed
> support on the modem side as well, but maybe not?
>

It requires the modem to support Raw IP.  Many (most?) AT command based =

modems do these days, no idea about your hardware.

> Would GSMIOC_ENABLE_NET make things easier from ofono
> point of view?

Depends on your definition of easier.  The real reason for =

GSMIOC_ENABLE_NET is speed/efficiency.  In a typical 27.010 / 27.007 =

compliant modem you'd setup N logical AT command channels where N =3D 1 =

(minimum, but can be more if you want) + max number of active contexts. =

Typically modems support 3+ of these.  Once a context is activated, =

you'd switch the channel into data mode via AT+CGDATA (e.g. for PPP or =

raw IP) and start shoving your network packets on that channel in the =

format chosen.

How are you handling data connections?  PPP? Or is there some other =

protocol to transfer packets back and forth?

>> - GNSS/GPS is intended to be handled via oFono LocationReporting API.  I
>> would recommend integrating this as intended...
> =

> We have a standard kernel GNSS API now :) And we have /dev/gnss0
> already working for droid 4.

That's great.  But I think my recommendation still stands.  You want GPS =

state to be synchronized with the overall modem state, etc...

> =

>> There's no real functional CDMA support in oFono anyhow.  Given that most
>> CDMA networks are about to be switched off, I don't know why you would
>> bother?
> =

> Hmm right, good point. Anyways that's how the SMS gets sent and
> received in the US for droid 4 currently.. The file I was looking at
> is src/cdma-sms.c and the only thing to do there is the PDU coding
> and encoding.

I believe the utilities you mention should be good enough to decode the =

basics.  I think someone has even tested these on a real network at some =

point.  But the people working on CDMA have not contributed since ~2011, =

so I have no idea about the state of that code.  I was considering =

removing it given that CDMA is essentially defunct (or will be in a few =

years).

Regards,
-Denis

--===============1439945246267449343==--

