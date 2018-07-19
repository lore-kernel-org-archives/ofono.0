Content-Type: multipart/mixed; boundary="===============4757551580586119794=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: no connection after ofono restart while huawei modem connected
Date: Thu, 19 Jul 2018 11:20:31 -0500
Message-ID: <fb1bd594-a374-08a9-eae4-db3db745f35e@gmail.com>
In-Reply-To: <faf6cc59-d31b-54a1-9e51-fa9a97980847@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4757551580586119794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

>> The best course of action would be to have modem.disable() issue a
>> CFUN=3D0 equivalent that resets everything properly.=C2=A0 If that's not
>> possible, then a solution along the lines of what you propose is
>> needed. =C2=A0E.g. sending a '+++' in at_gprs_context_remove if the state
>> isn't IDLE.
> I don't have a document describing AT command supported by MS2372. I use
> a document describing AT command supported by another Huawei modem. I
> didn't find any better command than AT+CFUN=3D0 to try to put back PPP
> channel in command mode.

Sometimes these modules take an extra reset parameter after the CFUN. =

E.g. AT+CFUN=3D0,1 to reset the module completely.  Not sure if this has =

other implications.  Possibly we can issue a AT+CFUN=3D1,1 or AT+CFUN=3D4,1 =

on .enable() that might fix this as well.

> I had a look at g_at_ppp_suspend and you are right, there is a guard
> timeout before sending '+++'. That's why it won't solve my problem.
> Ofono will die before this command is really sent.
> So I don't have any better idea than patch I already sent? Should I send
> a proper patch series with similar content?

That's the issue, the guard timeout is supposed to be used after all =

activity has been stopped and only then should '+++' be sent.  So it =

might be a good idea to put this behind a VENDOR guarded if-statement =

and issue the '+++' directly to the GAtIO without involving GAtPPP at all.

Regards,
-Denis

--===============4757551580586119794==--

