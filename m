Content-Type: multipart/mixed; boundary="===============4463962768170273662=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC at-export 0/2] Export AT-modem functions to other drivers
Date: Mon, 22 Apr 2019 15:12:23 -0500
Message-ID: <24fb3fc9-7d8b-4e25-bafe-74c6e272ca27@gmail.com>
In-Reply-To: <e1c7344a-2bd8-1258-4eb7-24a1f308a590@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4463962768170273662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/22/2019 12:33 PM, Jonas Bonn wrote:
> Hi Denis,
> =

> On 22/04/2019 17:52, Denis Kenzior wrote:
> =

>> What is actually different for uBlox that requires such a drastic =

>> approach?=C2=A0 Right now I'm seeing a duplication of CMER/CIEV and NITZ =

>> logic.=C2=A0 Not much else.
> =

> For the TOBY L4 I hit this:
> ofono_error("This driver is not setup with Signal Strength reporting"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " via=
 CIND indications, please write proper netreg"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " han=
dling for this device");
> =

> This device requires _polling_ ECSQ to get this info (no async signal =

> strenght reporting).=C2=A0 Other uBlox models don't have this issue.

You have to be kidding...  Sigh.

> =

> So we need to have UBLOX_TOBY_L4, UBLOX_TOBY_L2, etc. "vendor" types to =

> differentiate not only the vendor but the model.=C2=A0 Is that ok?=C2=A0 =
Not =

> enough to warrant a custom driver?

We used to have UBLOX_L2 prior to =

e70789534efc62d31112f54e42c0d249bed93b37.  So I don't really mind.  If =

you can do the l_container_of polymorphism going nicely, that's fine =

with me as well.

> =

> Is NITZ really a thing?=C2=A0 I interpreted it as "No immediate timezone"=
...

NITZ stands for: Network Identity & Time Zone.  And yes, it is a 'thing' =

and part of the 3GPP standards for at least 15 years.

> =

> /Jonas

Regards,
-Denis

--===============4463962768170273662==--

