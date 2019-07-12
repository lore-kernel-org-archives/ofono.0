Content-Type: multipart/mixed; boundary="===============0207728255495186079=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 0/9] Quectel M95 support
Date: Fri, 12 Jul 2019 10:22:30 -0500
Message-ID: <fe016562-fe57-fee5-e4c5-ab98bc5d9856@gmail.com>
In-Reply-To: <26e9846b-7fea-4ab3-f687-aec9e32f5691@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0207728255495186079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 7/10/19 5:21 PM, Martin Hundeb=C3=B8ll wrote:
> Hi,
> =

> The modem supports an unsolicited notification for voltage level =

> warnings and errors. I.e it can send
> =

>  =C2=A0 UNDER_VOLTAGE POWER DOWN
>  =C2=A0 UNDER_VOLTAGE WARNING
>  =C2=A0 OVER_VOLTAGE WARNING
>  =C2=A0 OVER_VOLTAGE POWER DOWN
> =

> The power down messages should probably just close the serial ports and =

> call ofono_modem_set_powered(modem, false), but what about the warnings?

What can be usefully done with these?  I mean, if you just send them to =

syslog, or nowhere at all, will anyone notice?

> =

> Should I just add a hardware monitor dbus interface like the =

> gemalto/cinterion drivers do, with a signal for the warnings?
> =


If you think someone will find this useful, then sure.

Regards,
-Denis

--===============0207728255495186079==--

