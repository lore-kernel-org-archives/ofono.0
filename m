Content-Type: multipart/mixed; boundary="===============7160004816860974291=="
MIME-Version: 1.0
From: Alexander Smirnov <asmirnov@ilbers.de>
Subject: Re: U-Blox modem reconnect
Date: Sat, 02 Jul 2016 00:15:08 +0300
Message-ID: <8A0EEF47-9278-43DD-8E50-AF99E6305F7E@ilbers.de>
In-Reply-To: <5776CB53.2050609@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7160004816860974291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks a lot for the reply!

>> could you please help me with the following issue. I use U-Blox
>> SARA-U270 modem. I'm able to online it and connect to GPRS using both:
>> connman and ofono-tests. The problem occurs when modem loses GSM link.
>> =

>> What I did:
>> =

>>  - Boot board with ofono 1.18
>>  - activate-context & process-context-settings
>>  - ifconfig shows ppp0, everything works
>>  - Disconnect physical GSM antenna, network strength becomes 0 (in
>> list-modems)
> =

> I doubt that this is a good way of testing out-of-coverage conditions. Yo=
u'd probably need a proper network simulator to do that...
> =


I'm not cellular expert, so probably ask dummy things :-) what can be wrong=
 with such test? How it differs from, for example, going underground like m=
etro, or tunnel in highway?

>>  - Connect antenna, network strength becomes 40
>> =

>> Problem:
>> =

>>  After these steps, modem doesn't reconnect to GPRS, while
>> list-contexts shows correct settings:
>> =

>> [ /ublox_0 ]
>>     [ /ublox_0/context1 ]
>>         Username =3D t-mobile
>>         AuthenticationMethod =3D chap
>>         Protocol =3D ip
>>         Name =3D Internet
>>         Settings =3D { Interface=3Dppp0 Netmask=3D255.255.255.255
>> Method=3Dstatic DomainNameServers=3D10.74.210.210,10.74.210.211,
>> Address=3D10.23.6.118 }
>>         IPv6.Settings =3D { }
>>         Active =3D 1
>>         AccessPointName =3D internet.t-mobile
>>         Password =3D tm
>>         Type =3D internet
>> =

>> But I don't see ppp0 interface.
> =

> Run oFono with AT command logging enabled as well as debugging enabled.  =
See HACKING, 'Running from within the source code repository' section for i=
nstructions.

Yeah, I've enabled this, but there is no output. The last command was print=
ed when I activated context first time, IIRC it was CONNECT.

> =

>> =

>> An attempt to activate-context doesn't do anything, just empty output
>> (with enabled debugging).
>> =

>> Attempt to deactivate-context failed with:
>> =

>> Error deactivating /ublox_0/context1:
>> org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible
>> causes include: the remote application did not send a reply, the message
>> bus security policy blocked
> =

> Most likely because your modem's firmware itself has crashed.
> =

>> =

>> The only hard modem reset helps.
>> =

>> Moreover, after antenna disconnect, there is no more cellular service in
>> ConnMan. Only daemon restart helps.
>> =

>> =

>> How should I handle lose GSM network events to keep ppp0 up? Why ofonod
>> hangs with the steps mentioned above?
> =

> oFono itself is not hung, but the underlying modem has.  Remind me, is th=
e SARA a serial based device or USB?

USB, it's connected using ACM Linux driver (ttyACM0-ttyACM6).

Btw: what should be the behavior, when ofono is out from cells coverage? Wh=
o should deactivate context, ofono or modem?

Alex

> =

> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============7160004816860974291==--

