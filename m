Content-Type: multipart/mixed; boundary="===============5515083532617252447=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCHv2] plugin: Add ste modem initd integration
Date: Mon, 03 Jan 2011 23:30:28 +0100
Message-ID: <AANLkTi=4GrWaC7OiYEyM=4C=C3NYn0Vob70-CMmnUvWj@mail.gmail.com>
In-Reply-To: <1294091716.5852.32.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5515083532617252447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> Signals       StateChange(string State)
>>
>>                       The modems state sent from when
>>                       a modem state change occurs. State is the only
>>                       dynamic property in this Interface.
>
>I would personally just go straight for PropertyChanged signal here and
>not bother with StateChanged. It is actually "...Changed" since at that
>time the state has already changed ;)

OK, I'll look into this. I thought StateChange was the only dynamic paramet=
er,
but I might have been wrong here (see below).

> You also need the following signals:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ModemAdded(object, dict)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ModemRemoved(object)

I think I'd rather add this when I see a use case for it. The Modem
Init Deamon would need to
know what GPIOs are associated with what modems, and what CAIF
interfaces to use etc.
This information is not dynamic, at least not at the moment. So
ModemAdded and ModemRemoved
will not happen in the current implementation, all the modems will be
known when the Manager
interface becomes available.

...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 string CaifAtInterface =
[readonly]
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 CAIF Link Layer interface to be used for
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 AT channels for a modem.
>
> I would really just call this "Interface" to make it simpler. Don't
> think that you are expecting more than just CAIF interface here anyway.

OK, Fair enough.

> And in addition if we can have the modem serial number here as "Serial"
> as well would be good. Even it is is not right away available, you can
> signal a change via PropertyChanged signal.
>
> That way we can construct a proper modem object path inside oFono. I
> really rather use the serial number and only fallback to the interface
> name.
>

OK, a Serial property is doable, but I think this is only available
after state "on" (ready)
has been reached. The drawback is that my assumption of State being the only
dynamic property wrong.
Crap you were right - I might need to add a PropertyChanged signal.

Regards,
Sjur

--===============5515083532617252447==--

