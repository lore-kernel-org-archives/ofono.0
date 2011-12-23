Content-Type: multipart/mixed; boundary="===============5774326577248040889=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: The way to install proper driver for 3G dongle in oFono
Date: Thu, 22 Dec 2011 20:44:49 -0800
Message-ID: <1324615489.1965.235.camel@aeonflux>
In-Reply-To: <688E999A39D0DD478D9CFCDC485D648288F6@SHSMSX102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5774326577248040889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ying An,

> >> >and what about the case when the SIM card is present, but PIN locked?
> >> >
> >> >> According to the result, it might be interesting to send ATI when t=
he
> >> >> constructor plugin is probe by oFono.
> >> >> Thus with +GCAP info we can decide which driver to use.
> >> >
> >> >Is sending +GCAP after ATI really a standard? Have we tried anything
> >> >else besides Huawei or ZTE?
> >>
> >> I tried with more dongles from different vendors, as attached table.
> >> The scenarios include:
> >> With valid sim card, sim card PIN locked, no sim card, sim card locked.
> >> N(ROM) in table indicates the SIM in ROM already.
> >> ATI command can always return GCAP content in all tests.
> >
> >and what about other manufactures other than Huawei, ZTE and SpeedUp?
> >What about Sierra, Ericsson etc.?
> =

> Just checked Dell 5530 with Ericsson module, =

> With SIM card or not, at+gcap can return +GCAP:+CGSM, +DS
> But the ATI only returns: D5530

I think it is clear that we need to do our homework here and properly
document the different manufacturers. Someone sending patches for our
doc/ directory?

> >> >Also you do realize that the GAtChat object and thus the file descrip=
tor
> >> >is owned by the modem plugin. The plugin itself is the only one that
> >> >should do any kind of IO.
> >> >
> >> >So if we require to run ATI first to identify if we are GSM or CDMA,
> >> >then this is a per modem manufacture specific detail. And we rather a=
dd
> >> >a helper function like we did for CPIN polling that makes this easier.
> >> >
> >>
> >> In current code the 'driver' is hardcoded by comparing with vendor_lis=
t[].
> >> So if it possible to break the step into several:
> >> vendor_list[] in udevng just cares about vendor - by comparing vendor =
ID only,
> >> and add all possible drivers according to that vendor - (for example a=
dd
> >> WCDMA, CDMA2k, TDSCDMA, LTE ...drivers if Huawei dongle is plugged in),
> >> and the probe interface in each driver does real probe work as to issue
> >> ATI command to ensure only correct driver will be loaded?
> >
> >As I said before, the only time IO can be started is when the ->enable()
> >callback of the modem plugin is called. Not a second earlier.
> =

> But if done after enable() called, from semantic aspect the correct drive=
r has been =

> chosen. Indeed the probe() interface in each driver is not doing somethin=
g to probe,
> then can the work be done in probe()? As set CFUN=3D1 then doing some don=
gle vendor =

> specific work as query model or network mode by ATI, AT+GCAP command, etc=
..? After =

> that disable dongle when quit probe()?

The probe() callback is for accepting the driver and allocating required
local data structures. It is not for IO. And as you can see it has no
callback handling like enable() with set_powered().

As I said before, no AT commands before enable() has been called. That
is how it is suppose to be. We are not changing this.

Regards

Marcel



--===============5774326577248040889==--

