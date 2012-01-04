Content-Type: multipart/mixed; boundary="===============1985630851862214116=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: The way to install proper driver for 3G dongle in oFono
Date: Wed, 04 Jan 2012 07:29:05 -0800
Message-ID: <1325690945.6454.24.camel@aeonflux>
In-Reply-To: <4F042270.4020305@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1985630851862214116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> >>>>>> and what about the case when the SIM card is present, but PIN lock=
ed?
> >>>>>>
> >>>>>>> According to the result, it might be interesting to send ATI when=
 the
> >>>>>>> constructor plugin is probe by oFono.
> >>>>>>> Thus with +GCAP info we can decide which driver to use.
> >>>>>> Is sending +GCAP after ATI really a standard? Have we tried anythi=
ng
> >>>>>> else besides Huawei or ZTE?
> >>>>> I tried with more dongles from different vendors, as attached table.
> >>>>> The scenarios include:
> >>>>> With valid sim card, sim card PIN locked, no sim card, sim card loc=
ked.
> >>>>> N(ROM) in table indicates the SIM in ROM already.
> >>>>> ATI command can always return GCAP content in all tests.
> >>>> and what about other manufactures other than Huawei, ZTE and SpeedUp?
> >>>> What about Sierra, Ericsson etc.?
> >>> Just checked Dell 5530 with Ericsson module,
> >>> With SIM card or not, at+gcap can return +GCAP:+CGSM, +DS
> >>> But the ATI only returns: D5530
> >> I think it is clear that we need to do our homework here and properly
> >> document the different manufacturers. Someone sending patches for our
> >> doc/ directory?
> > There're many vendors of 3G dongle..
> > Huawei, ZTE (they share 70%+ of global market), Longcheer, Haier, Senta=
r, Viton, D-link, SCV, BandRich, Strongrising.. (more than 30 vendors in Ch=
ina)
> > Sierra, Sony-Ericsson, Option, Novatel, Alcatel, Samsung, LG, AnyData, =
C-motech, Micromax...
> > We can try with them step by step, but can we work out the 2 biggest fi=
rstly?
> > Looks ATI command can work for both Huawei and ZTE dongles.
> >
> =

> I agree here, the work to be done over all manufacturers will be =

> fastidious and might require a lot of dongles that we don't have currentl=
y.
> Maybe we could do as Ying An proposed as we are sure ATI works for =

> Huawei and ZTE (at least the ones we have).
> However, conerning ZTE I haven't seen any CDMA dongle for the moment.
> =

> >>>>>> Also you do realize that the GAtChat object and thus the file desc=
riptor
> >>>>>> is owned by the modem plugin. The plugin itself is the only one th=
at
> >>>>>> should do any kind of IO.
> >>>>>>
> >>>>>> So if we require to run ATI first to identify if we are GSM or CDM=
A,
> >>>>>> then this is a per modem manufacture specific detail. And we rathe=
r add
> >>>>>> a helper function like we did for CPIN polling that makes this eas=
ier.
> >>>>>>
> >>>>> In current code the 'driver' is hardcoded by comparing with vendor_=
list[].
> >>>>> So if it possible to break the step into several:
> >>>>> vendor_list[] in udevng just cares about vendor - by comparing vend=
or ID
> >> only,
> >>>>> and add all possible drivers according to that vendor - (for exampl=
e add
> >>>>> WCDMA, CDMA2k, TDSCDMA, LTE ...drivers if Huawei dongle is plugged
> >> in),
> >>>>> and the probe interface in each driver does real probe work as to i=
ssue
> >>>>> ATI command to ensure only correct driver will be loaded?
> >>>> As I said before, the only time IO can be started is when the ->enab=
le()
> >>>> callback of the modem plugin is called. Not a second earlier.
> >>> But if done after enable() called, from semantic aspect the correct d=
river has
> >> been
> >>> chosen. Indeed the probe() interface in each driver is not doing some=
thing to
> >> probe,
> >>> then can the work be done in probe()? As set CFUN=3D1 then doing some=
 dongle
> >> vendor
> >>> specific work as query model or network mode by ATI, AT+GCAP command,
> >> etc..? After
> >>> that disable dongle when quit probe()?
> >> The probe() callback is for accepting the driver and allocating requir=
ed
> >> local data structures. It is not for IO. And as you can see it has no
> >> callback handling like enable() with set_powered().
> >>
> >> As I said before, no AT commands before enable() has been called. That
> >> is how it is suppose to be. We are not changing this.
> =

> First, ATI command is working without sending AT+CFUN=3D1, we could keep =

> CFUN=3D1 into enable() as we do some vendor/modem type specific job there.
> =

> Then vendor plugin can be chosen using udevng using Vendor ID, however =

> driver type (CDMA/GSM) can't lie on the Product ID. So it will be hard =

> to chose the right vendor plugin with right type.
> And if we can't send AT command before enable() time we will face to bag =

> end e.g. :
> For huawei plugin we send GSM specific AT command (AT^RFSWITCH) during =

> the enable() time.
> We are also querying the sim state using polling mechanism that might =

> fail for CDMA modems that is not using SIM.
> What would you suggest here?

as I said before, no AT commands before ->enable() callback from the
core.

The callback ->probe() is for accepting the modem driver binding and
allocating modem specific data memory. The callback ->remove() is for
cleanup.

The callbacks ->enable(), ->disable() and ->set_online() are the only IO
entry points for every modem driver. And we need to keep it like this.

The callback ->pre_sim(), ->post_sim() and ->post_online() are the entry
points for selecting atom drivers. These are not allowed to do IO
directly either.

Regards

Marcel



--===============1985630851862214116==--

