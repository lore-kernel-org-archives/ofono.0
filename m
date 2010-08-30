Content-Type: multipart/mixed; boundary="===============4037965519404745160=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/2] Add: n900modem driver
Date: Mon, 30 Aug 2010 17:23:27 +0300
Message-ID: <AANLkTinVYbHMGn7Pi+0Juhng+sTBPDP+OWzqm55He-Uz@mail.gmail.com>
In-Reply-To: <4C6AE0D3.5090903@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4037965519404745160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/8/17 Denis Kenzior <denkenz@gmail.com>:
> Why are we doing this inside n900modem? =C2=A0Can't we simply:
>
> 1. Make isimodem/isimodem.c register these (just like atmodem, stemodem,
> mbmmodem, etc does)
> 2. Rip out the actual modem driver out of isimodem/isimodem.c
> 3. Have plugins/n900.c contain the modem driver?

I think you mean rip out the modem driver in isimodem/isimodem.c, and
put it in usbpnmodem.c? I think that makes sense.

>> - =C2=A0 =C2=A0 /* Expect phonet interface name usbpn<idx> */
>> - =C2=A0 =C2=A0 if (strncmp(ifname, "usbpn", 5) ||
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifname[5 + strspn(ifname + 5=
, "0123456789")])
>> + =C2=A0 =C2=A0 if (match_ifname("usbpn", ifname)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 driver =3D "isimodem";
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 address =3D PN_DEV_PC;
>> + =C2=A0 =C2=A0 } else if (strcmp("phonet0", ifname) =3D=3D 0) {
>> +#if HAVE_N900MODEM
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 driver =3D "n900modem";
>> +#else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 driver =3D "isimodem";
>> +#endif
>
> And this really needs to go...

Couldn't we rather either build support for native modem or USB
modems, but not both at the same time? In other words, build only one
or the other of these two plugins.

Cheers,
Aki

--===============4037965519404745160==--

