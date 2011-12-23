Content-Type: multipart/mixed; boundary="===============0942874227637765710=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: The way to install proper driver for 3G dongle in oFono
Date: Thu, 22 Dec 2011 19:26:23 -0800
Message-ID: <1324610783.1965.228.camel@aeonflux>
In-Reply-To: <688E999A39D0DD478D9CFCDC485D64828892@SHSMSX102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0942874227637765710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ying An,

> >and what about the case when the SIM card is present, but PIN locked?
> >
> >> According to the result, it might be interesting to send ATI when the
> >> constructor plugin is probe by oFono.
> >> Thus with +GCAP info we can decide which driver to use.
> >
> >Is sending +GCAP after ATI really a standard? Have we tried anything
> >else besides Huawei or ZTE?
> =

> I tried with more dongles from different vendors, as attached table.
> The scenarios include:
> With valid sim card, sim card PIN locked, no sim card, sim card locked.
> N(ROM) in table indicates the SIM in ROM already.
> ATI command can always return GCAP content in all tests.

and what about other manufactures other than Huawei, ZTE and SpeedUp?
What about Sierra, Ericsson etc.?

> >Also you do realize that the GAtChat object and thus the file descriptor
> >is owned by the modem plugin. The plugin itself is the only one that
> >should do any kind of IO.
> >
> >So if we require to run ATI first to identify if we are GSM or CDMA,
> >then this is a per modem manufacture specific detail. And we rather add
> >a helper function like we did for CPIN polling that makes this easier.
> >
> =

> In current code the 'driver' is hardcoded by comparing with vendor_list[].
> So if it possible to break the step into several:
> vendor_list[] in udevng just cares about vendor - by comparing vendor ID =
only,
> and add all possible drivers according to that vendor - (for example add =

> WCDMA, CDMA2k, TDSCDMA, LTE ...drivers if Huawei dongle is plugged in),
> and the probe interface in each driver does real probe work as to issue
> ATI command to ensure only correct driver will be loaded?

As I said before, the only time IO can be started is when the ->enable()
callback of the modem plugin is called. Not a second earlier.

Regards

Marcel



--===============0942874227637765710==--

