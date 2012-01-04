Content-Type: multipart/mixed; boundary="===============1121024849423659143=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: The way to install proper driver for 3G dongle in oFono
Date: Wed, 04 Jan 2012 08:48:32 -0800
Message-ID: <1325695712.6454.60.camel@aeonflux>
In-Reply-To: <4F047EF6.90901@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1121024849423659143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> >>>>>>>>>> and what about the case when the SIM card is present, but PIN =
locked?
> >>>>>>>>>>
> >>>>>>>>>>> According to the result, it might be interesting to send ATI =
when the
> >>>>>>>>>>> constructor plugin is probe by oFono.
> >>>>>>>>>>> Thus with +GCAP info we can decide which driver to use.
> >>>>>>>>>> Is sending +GCAP after ATI really a standard? Have we tried an=
ything
> >>>>>>>>>> else besides Huawei or ZTE?
> >>>>>>>>> I tried with more dongles from different vendors, as attached t=
able.
> >>>>>>>>> The scenarios include:
> >>>>>>>>> With valid sim card, sim card PIN locked, no sim card, sim card=
 locked.
> >>>>>>>>> N(ROM) in table indicates the SIM in ROM already.
> >>>>>>>>> ATI command can always return GCAP content in all tests.
> >>>>>>>> and what about other manufactures other than Huawei, ZTE and Spe=
edUp?
> >>>>>>>> What about Sierra, Ericsson etc.?
> >>>>>>> Just checked Dell 5530 with Ericsson module,
> >>>>>>> With SIM card or not, at+gcap can return +GCAP:+CGSM, +DS
> >>>>>>> But the ATI only returns: D5530
> >>>>>> I think it is clear that we need to do our homework here and prope=
rly
> >>>>>> document the different manufacturers. Someone sending patches for =
our
> >>>>>> doc/ directory?
> >>>>> There're many vendors of 3G dongle..
> >>>>> Huawei, ZTE (they share 70%+ of global market), Longcheer, Haier, S=
entar, Viton, D-link, SCV, BandRich, Strongrising.. (more than 30 vendors i=
n China)
> >>>>> Sierra, Sony-Ericsson, Option, Novatel, Alcatel, Samsung, LG, AnyDa=
ta, C-motech, Micromax...
> >>>>> We can try with them step by step, but can we work out the 2 bigges=
t firstly?
> >>>>> Looks ATI command can work for both Huawei and ZTE dongles.
> >>>>>
> >>>> I agree here, the work to be done over all manufacturers will be
> >>>> fastidious and might require a lot of dongles that we don't have cur=
rently.
> >>>> Maybe we could do as Ying An proposed as we are sure ATI works for
> >>>> Huawei and ZTE (at least the ones we have).
> >>>> However, conerning ZTE I haven't seen any CDMA dongle for the moment.
> >>>>
> >>>>>>>>>> Also you do realize that the GAtChat object and thus the file =
descriptor
> >>>>>>>>>> is owned by the modem plugin. The plugin itself is the only on=
e that
> >>>>>>>>>> should do any kind of IO.
> >>>>>>>>>>
> >>>>>>>>>> So if we require to run ATI first to identify if we are GSM or=
 CDMA,
> >>>>>>>>>> then this is a per modem manufacture specific detail. And we r=
ather add
> >>>>>>>>>> a helper function like we did for CPIN polling that makes this=
 easier.
> >>>>>>>>>>
> >>>>>>>>> In current code the 'driver' is hardcoded by comparing with ven=
dor_list[].
> >>>>>>>>> So if it possible to break the step into several:
> >>>>>>>>> vendor_list[] in udevng just cares about vendor - by comparing =
vendor ID
> >>>>>> only,
> >>>>>>>>> and add all possible drivers according to that vendor - (for ex=
ample add
> >>>>>>>>> WCDMA, CDMA2k, TDSCDMA, LTE ...drivers if Huawei dongle is plug=
ged
> >>>>>> in),
> >>>>>>>>> and the probe interface in each driver does real probe work as =
to issue
> >>>>>>>>> ATI command to ensure only correct driver will be loaded?
> >>>>>>>> As I said before, the only time IO can be started is when the ->=
enable()
> >>>>>>>> callback of the modem plugin is called. Not a second earlier.
> >>>>>>> But if done after enable() called, from semantic aspect the corre=
ct driver has
> >>>>>> been
> >>>>>>> chosen. Indeed the probe() interface in each driver is not doing =
something to
> >>>>>> probe,
> >>>>>>> then can the work be done in probe()? As set CFUN=3D1 then doing =
some dongle
> >>>>>> vendor
> >>>>>>> specific work as query model or network mode by ATI, AT+GCAP comm=
and,
> >>>>>> etc..? After
> >>>>>>> that disable dongle when quit probe()?
> >>>>>> The probe() callback is for accepting the driver and allocating re=
quired
> >>>>>> local data structures. It is not for IO. And as you can see it has=
 no
> >>>>>> callback handling like enable() with set_powered().
> >>>>>>
> >>>>>> As I said before, no AT commands before enable() has been called. =
That
> >>>>>> is how it is suppose to be. We are not changing this.
> >>>> First, ATI command is working without sending AT+CFUN=3D1, we could =
keep
> >>>> CFUN=3D1 into enable() as we do some vendor/modem type specific job =
there.
> >>>>
> >>>> Then vendor plugin can be chosen using udevng using Vendor ID, howev=
er
> >>>> driver type (CDMA/GSM) can't lie on the Product ID. So it will be ha=
rd
> >>>> to chose the right vendor plugin with right type.
> >>>> And if we can't send AT command before enable() time we will face to=
 bag
> >>>> end e.g. :
> >>>> For huawei plugin we send GSM specific AT command (AT^RFSWITCH) duri=
ng
> >>>> the enable() time.
> >>>> We are also querying the sim state using polling mechanism that might
> >>>> fail for CDMA modems that is not using SIM.
> >>>> What would you suggest here?
> >>> as I said before, no AT commands before ->enable() callback from the
> >>> core.
> >>>
> >>> The callback ->probe() is for accepting the modem driver binding and
> >>> allocating modem specific data memory. The callback ->remove() is for
> >>> cleanup.
> >>>
> >>> The callbacks ->enable(), ->disable() and ->set_online() are the only=
 IO
> >>> entry points for every modem driver. And we need to keep it like this.
> >> Ok, so I suggest to do the ATI at the very beginning of ->enable() cal=
lback.
> > the first command has to be always ATE0 +CMEE=3D1 since otherwise you a)
> > can not use the permissive syntax parser and b) your error values will
> > be useless.
> >
> > But yes, after that it is fine to send ATI.
> >
> =

> Ok
> =

> >> Then depending on the ATI answer:
> >>       - tag the huawei modem data with GSM / CDMA type.
> >>       - send the GSM / CDMA specific AT commands followed by AT+CFUN=
=3D1.
> > What different commands depending on GSM or CDMA do you actually have?
> >
> > The AT^RFSWITCH=3D? is exactly designed to handle if that command is
> > supported or not. There are plenty of GSM versions of the Huawei that do
> > not support AT^RFSWITCH. You do need to know if this is supported or
> > not.
> =

> I see, so we can send AT^RFSWITCH for both type. If it is not supported, =

> it will be ignored using terminator and then use
> default AT+CFUN=3D5.
> =

> > Also we do not send AT+CFUN=3D1 in ->enable() callback. We bring the mo=
dem
> > into offline mode. The only time you send AT+CFUN=3D1 is if you have
> > hardware that does not support online/offline distinction. So if this is
> > true for Huawei CDMA modems, then the obvious questions is why that is
> > the case? Or is this a bug with our CDMA support not supporting offline
> > mode.
> >
> =

> For the moment, CDMA modems are not using ->set_online() callback (it is =

> automatically set online into modem.c).
> We will have to make some test to check AT+CFUN=3D5 is working on CDMA mo=
dems.

The Huawei GSM support is using ->set_online() callback. And so this
means that you need it also for CDMA support. Otherwise you are back at
square one.

Actually you need to test the full CDMA support and if it can properly
handle ->set_online() support. If not, then this needs fixing.

Also I am still not seeing proper support for CDMA SIM atom. We need to
stop hacking around here. The core functionality needs to be implemented
first. Without it, the modem plugins can not function properly.

So why are we wasting time with modem details here. If I remember
correctly, Denis and I made it pretty clear that SIM atom and network
registration atom is a fundamental requirement for CDMA support.

Regards

Marcel



--===============1121024849423659143==--

