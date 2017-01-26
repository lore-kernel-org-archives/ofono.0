Content-Type: multipart/mixed; boundary="===============5306850990613216782=="
MIME-Version: 1.0
From: gluedig@gmail.com
Subject: Re: [PATCH 2/4] plugins: support for Telit LE910 V2 modem
Date: Thu, 26 Jan 2017 12:13:29 +0100
Message-ID: <feeb9a57-832b-eab1-2851-8b1a2658f364@gmail.com>
In-Reply-To: <710ce16f-892b-3114-6ca2-039a630fb6f6@overkiz.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5306850990613216782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi
On 01/26/2017 10:40 AM, Antoine Aubert wrote:
> Hi,
> =

> I'v recently add support for ge910 quad,
> (https://github.com/p1ng0o/ofono/commits/ovk) and I had some ugly issues.
> =

> 1/ doesn't support proper atmux
> (https://github.com/p1ng0o/ofono/commit/1b7f64b2faaca91ce711774a12ba79ad3=
5cbb8ed)
> =

> Quote from support(a)telit:
> =

> "In Telit implementation module is NEVER an initiator since it is up to
> controller to send the
> SABM command to DLCI 0
> * Module is ALWAYS a responder
> * Module send the V24 frame as F9 01 EF 09 E3 05 0B 8D 9A F9 where C/R
> bit is set to 1
> * According to Table 1 this is a response frame
> * According to above DTE don=E2=80=99t have to copy the status."
> =

> thread with denis,
> https://lists.ofono.org/pipermail/ofono/2016-October/016590.html
> =

> 2/ Ugly init process, forced me to create plugin from scratch
> (https://github.com/p1ng0o/ofono/commit/6534001cd5801a30b0c237b697226ed2d=
02fe774)
> =

> - I have to wait QSS=3D2 for initialize all devices, sometimes it take
> more than modem powered timeout !
> =

> - Sometime I didn't receive QSS notification at all
> =

> Quote from support(a)telit:
> =

> "just try to increase the waiting time for QSS answer (also 1 minute at
> the beginning: it depends also on the number of records in the SIM
> phonebook, ecc.)"
> =

> Did you face same issues ?
> =

No really, LE910V2 does not need AT mux as far as i know - it uses
separate network interface as default (CDC-NCM).
I also tried PPP over modem port, worked ok, just switched aux and modem
ports for it to work ok.

And #QSS=3D2 returns right away.
First #QSS query returns 0 (SIM not inserted) but seconds later #QSS
notification arrives with status 1

Kind regards
Piotr


> Antoine Aubert
> a.aubert(a)overkiz.com
> =

> Le 26/01/2017 =C3=A0 10:09, gluedig(a)gmail.com a =C3=A9crit :
>> On 01/25/2017 05:37 PM, Denis Kenzior wrote:
>>> On 01/25/2017 04:41 AM, Piotr Haber wrote:
>>>> LE910 V2 is next generation Telit LTE modem.
>>>> It supports 3GPP Rel. 9 LTE Cat. 4 over multiple bands.
>>>> Default USB composition uses PID 0x36 and
>>>> consists of 6 CDC-ACM serial ports and 1 CDC-NCM network adapter.
>>>> ---
>>>>  Makefile.am       |   3 +
>>>>  plugins/le910v2.c | 400
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 403 insertions(+)
>>>>  create mode 100644 plugins/le910v2.c
>>>>
>>> Can you add the LE910 changes into the HE910 driver?  The two are 99%
>>> the same except for HE910 supporting voice calls and LE910 using a
>>> different gprs_context driver.
>>>
>>> There's no sense in maintaining a 400 line driver that is virtually
>>> identical to what we already have.
>>>
>>> Regards,
>>> -Denis
>>>
>> Hi,
>> of course you are right.
>>
>> I would prepare a series of patches that renames he910 plugin to xe910 -
>> this is how Telit calls the whole family that consists of lots of models
>> form 2g (GE910) through 3/3.5g (HE910, DE910, UE910, HE910V2) to
>> 4g(LE910, LE910V2)
>>
>> Then I'll add support for LE910V2 to xe910 plugin.
>> How does it sound?
>>
>> Piotr
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
> =



--===============5306850990613216782==--

