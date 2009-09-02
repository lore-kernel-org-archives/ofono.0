Content-Type: multipart/mixed; boundary="===============9000428473390364558=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 18:42:44 +0300
Message-ID: <a32762a20909020842q1005da84s1a6816be5e103d2e@mail.gmail.com>
In-Reply-To: <200909021028.52347.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9000428473390364558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/9/2 Denis Kenzior <denkenz@gmail.com>:
>> AFAIK, attach status of GPRS has both regulatory aspects to consider
>> (some operators require always attached vs. some prohibit it) as well
>> as power consumption issues (auto-attach might draw more power than
>> on-demand, although there's an inverse effect on latency). These are
>> issues you need to take into account, and higher layers in the stack
>> definitely *need* to be aware of as well. Also, I don' t think oFono
>> is the correct place for these decisions -> better expose a necessary
>> API and let upper layers deal with it.
>
> I know you guys are coming from mobile phone perspective, but that one is=
n't
> the only scenario. =C2=A0We have netbooks/laptops with gprs data cards to=
 consider
> as well. =C2=A0Hardcoding operator requirements is also not an option, si=
nce SIM
> cards can be changed.
>
> I fundamentally disagree that the logic should be in the higher layers. =
=C2=A0oFono
> has all the information to handle this, and can be hinted on what is
> appropriate behavior easily enough. =C2=A0oFono should simply store the a=
uto-attach
> preferences in its IMSI-indexed preference store. =C2=A0The operator can =
bootstrap
> these preferences if required.

Operator requirements were only half of the story. You need to be able
to disable auto-attach in low power conditions, and this logic
definitely doesn't belong in oFono. This applies equally well to
mobile phones as it does to laptops/netbooks.

>> In general, I appreciate the attempt to hide ugly details from
>> applications, but unfortunately some things can't well be hidden.
>> Another unrelated, but similar issue is network scanning. It just
>> isn't going to work without us exposing it in the D-Bus API
>> explicitly.
>>
>
> Modem drivers will have some control over whether the scan is performed
> automatically, but denying the capability for everyone is not the right t=
hing
> to do either.

Agree, and I don't think that was what I was suggesting either.

>> The reason is simple, Nokia modems suspend GPRS when scanning (or
>> registering), simply because the operation will take roughly three
>> times as long with GPRS attached. You will find this feature in
>> current phones, too.
>
> Then ideally you should have two scan modes, periodic and user initiated.=
 =C2=A0For
> periodic mode we don't care how long it takes.

+1

Cheers,
Aki

--===============9000428473390364558==--

