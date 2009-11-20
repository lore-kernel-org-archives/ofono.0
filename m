Content-Type: multipart/mixed; boundary="===============0572177059687391503=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Palm Pre modem plugin
Date: Fri, 20 Nov 2009 07:08:30 -0600
Message-ID: <200911200708.31068.denkenz@gmail.com>
In-Reply-To: <359c5480911211147o23607b25q247a19a6f6abee17@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0572177059687391503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

>As of that I'm able to imagine only few reasons to use ofono instead of fs=
o.

Then either you're not thinking hard enough or do not have enough domain =

experience to really comment.  One example: carrier certification. Please =

examine what oFono APIs cover and what FSO GSM APIs cover.  Hint, to pass G=
CF =

certification you will require quite a bit of what oFono provides (or figur=
es =

out for you) and FSO is currently missing.

>The forth and worring is that a developer may be forced to use
>ofono, as the target device has some closed parts necessary for the os
>that does not work anymore if you remove ofono and use FSO.

Please do not post these crazy conspiracy theories here.  oFono is GPLed fo=
r =

exactly this reason.

> So, instead of discuss oFono vs FSO, I'd like to know what is the long
> time strategy and how to address these issues, and of course if I
> missed some important points.

FSO vs oFono is not a fair comparison anyway.    Please keep in mind that =

oFono is focused _only_ on being a telephony stack that is generic and =

applicable to all types of devices.  We started oFono to enable telephony =

applications on Laptops, Netbooks, MIDs, In-Vehicle Infotainment and many =

other types of devices.  These system types are different enough that diffe=
rent =

approaches to resource management, PIM, etc might be required.  Not every =

device type will have or even needs a fully-featured GSM modem.

For this reason oFono does not distinguish between smartphone vs non-
smartphone use cases.  Case in point: oFono already supports data-only GPRS =

devices, Bluetooth Handsfree profile devices, and of course proper modems (=
AT =

command and binary-protocol.)  =


The other long-term goal is to integrate oFono with other system-level daem=
ons =

such as BlueZ, NTPD, ConnMan, NetworkManager Gypsy, etc.  This will allow u=
s =

to e.g. expose GPS data from the modem; enable Bluetooth telephony profiles =

like DUN, HFP AG; and expose 3G data connections for management by real =

connection managers.  We already have integration plugin infrastructure for =

feeding call history, sms history information to a PIM database of your =

choice, as well as export your phone's phonebooks to VCard format.

So, as you see, oFono allows you to integrate it into any type of system.  =
You =

can even make it coexist with FSO daemons (with the exception of the gsm on=
e =

of course) if these satisfy your particular requirements.

Regards,
-Denis

--===============0572177059687391503==--

