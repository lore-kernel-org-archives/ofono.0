Content-Type: multipart/mixed; boundary="===============3487884080199024102=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: The way to install proper driver for 3G dongle in oFono
Date: Thu, 22 Dec 2011 09:09:31 -0800
Message-ID: <1324573771.1965.214.camel@aeonflux>
In-Reply-To: <4EF2FCF6.1050405@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3487884080199024102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> >>>>>> We are facing a problem in oFono when using 3G modems:
> >>>>>>
> >>>>>> A CDMA2000 modem can have same PID with WCDMA modem, or
> >>> TDS-CDMA
> >>>>>> modem -- 3G modem vendors already confirm they do that.
> >>>>>>
> >>>>>> That's to say, if following current strategy, it will be a problem=
 to
> >>>>>> install proper driver for this kind of 3G modem.
> >>>>>>
> >>>>>> So, is it feasible to find out a solution such as to probe the mod=
em
> >>>>>> firstly, find out what kind of network modes it supports, and then
> >>>>>> install the driver?
> >>>>>>
> >>>>>> The way to probe the modem could be some action as to read the
> >>>>>> capability or get system mode, or issue some specific AT command t=
hat
> >>>>>> only response to certain network mode?
> >>>>>>
> >>>>> Indeed, we could use for Huawei modems for instance the AT^SYSINFO
> >>>>> command and retrieve the sys_mode field and parse it, I have found
> >>>>> this in public Huawei specifications:
> >>>>>
> >>>>> <sys_mode>: System mode. The values are as follows:
> >>>>> 0 No service.
> >>>>> 1 AMPS mode
> >>>>> 2 CDMA mode
> >>>>> 3 GSM/GPRS mode
> >>>>> 4 HDR mode
> >>>>> 5 WCDMA mode
> >>>>> 8 CDMA/HDR HYBRID mode
> >>>>>
> >>>>> Thus we can chose accordingly the drivers to create oFono atoms.
> >>>> After some investigations, it seems SYSINFO won't be enough to get t=
he
> >>>> modem type because with this AT command we will have to be registere=
d to
> >>>> the network to get the system mode.
> >>>> The only way I found until now is using the AT+GCAP to check whether=
 the
> >>>> modem is CDMA or GSM type.
> >>>> However if we do the AT+GCAP request for each constructor plugin
> >>>> (huawei, zte, ...) it will bring some duplicated code.
> >>>> Does someone see any better solution?
> >>> I like to see that we do proper homework here. The first question is
> >>> actually can you execute AT+GCAP if not SIM card has been inserted or=
 is
> >>> actually locked? And if not does, ATI provide an extra +GCAP response.
> >>> Without a SIM atom you will not be able to unlock the modem. And you =
can
> >>> only create the SIM atom if you know what modem technology you are
> >>> using. Additionally of course additionally, what are the responses for
> >>> various modem models and manufactures. Are they doing this actually
> >>> properly.
> >>>
> >>> We need OFONO_AT_DEBUG traces for all the various permutations of this
> >>> behavior. This needs to be documented first. Feel free to send patches
> >>> to add the results to doc/ directory inside oFono.
> >>>
> >>> Just randomly hacking around will get us in trouble and will make well
> >>> behaved modems like MBM or IFX fail or suffer for no apparent reasons.
> >> The at+gcap command only effective after SIM card inserted.
> >> It is feasible to firstly find the vendor, then choose specific method=
 to detect
> >> if it is wcdma/cdma2k, then install proper driver?
> > and how does this work if you can't execute AT+GCAP since either your
> > SIM card is not present of actually locked. As I said above, you can
> > only unlock the SIM card with the SIM atom loaded. And for loading the
> > SIM atom you need to know which technology you are operating on.
> >
> > I really prefer that the mentioned homework is done properly and
> > information are first gathers. Wild guessing is not going to help here
> > and random assumption on how things are suppose to work will eventually
> > fail because of the nature of this hardware. So lets get real facts
> > first and then we see what we do to solve this problem.
> =

> I have made some tests on a dozen of dongles from Huawei and ZTE.
> I have remove the sim card for each dongle in order to be in the use =

> case you mentionned.
> I used minicom in order the modem not to be intialized.
> For all GSM one there is an answer to ATI but none to AT+GCAP.
> =

> Huawei GSM AT+GCAP ATI answer:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> AT+GCAP
> +CME ERROR: SIM failure
> =

> ATI
> Manufacturer: huawei
> Model: E1552
> Revision: 11.608.10.00.309
> IMEI: 353143036552488
> +GCAP: +CGSM,+DS,+ES    --> this is a GSM modem
> =

> This is the case for ALL Huawei GSM dongles we got.
> =

> Huawei CDMA AT+GCAP ATI answers:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> AT+GCAP
> +GCAP: +CIS707-A,CIS-856-A,+MS, +ES, +DS, +FCLASS
> =

> ATI
> Manufacturer: +GMI: HUAWEI TECHNOLOGIES CO., LTD
> Model: EC152
> Revision: TCPU_HWEC152DT01
> ESN: +GSN:80aad6fd
> +GCAP: +CIS707-A,CIS-856-A,+MS, +ES, +DS, +FCLASS -->this is CDMA modem =

> (no +CGSM label)
> =

> The Huawei CDMAdongle above with ROM SIM answers to both AT+GCAP and ATI.
> This is the case for ALL Huawei CDMA dongles we got.
> =

> Concerning ZTE we got only GSM modems.
> =

> ZTE AT+GCAP ATI answer:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> AT+GCAP
> ERROR
> =

> ATI
> Manufacturer: ZTE INCORPORATED
> Model: MF668
> Revision: BD_INRELMF668V1.0.0B01
> IMEI: 355987033958538
> +GCAP: +CGSM,+DS,+ES
> =

> This is the case for ALL ZTE GSM dongles we got.

and what about the case when the SIM card is present, but PIN locked?

> According to the result, it might be interesting to send ATI when the =

> constructor plugin is probe by oFono.
> Thus with +GCAP info we can decide which driver to use.

Is sending +GCAP after ATI really a standard? Have we tried anything
else besides Huawei or ZTE?

Also you do realize that the GAtChat object and thus the file descriptor
is owned by the modem plugin. The plugin itself is the only one that
should do any kind of IO.

So if we require to run ATI first to identify if we are GSM or CDMA,
then this is a per modem manufacture specific detail. And we rather add
a helper function like we did for CPIN polling that makes this easier.

The udev plugins will not open any file descriptors and randomly trying
to execute commands, then close them again and just hope for the best.
It is the modem plugin (and only that one) that is allowed to do IO. It
is fully responsible for driving the modem.

Regards

Marcel



--===============3487884080199024102==--

