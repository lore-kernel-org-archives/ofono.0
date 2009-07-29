Content-Type: multipart/mixed; boundary="===============1704108562945936691=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Network information can't be updated dynamically
Date: Wed, 29 Jul 2009 12:24:23 -0500
Message-ID: <200907291224.24273.denkenz@gmail.com>
In-Reply-To: <B94C62E7C2870743865418621F040C1302053C4EFB@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1704108562945936691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi,
> I take a phone as modem to use ofono and find the network information can=
't
> be updated dynamically in ofono: so the network status always is roaming.
> Because ofono get the response is roaming status at beginning.
>   ofonod[10503]:  Response line: +CREG: 2,5,"188E","00006302"
>
> The network status and signal strength will update dynamically but ofono
> can't receive it automatically because modem can't send it regular. or
> anything wrong in my understanding?

The only thing that oFono core will poll periodically is the network =

operators.  Everything else must be handled by the driver.  For network sta=
tus =

updates atmodem sends an AT+CREG=3D2, quoting 27.007:

"2 - enable network registration and location information unsolicited resul=
t =

code +CREG: <stat>[,<lac>,<ci>[,<AcT>]]"

This seems to work ok on my devices.  Are you sure your modem re-registers =
to =

the home network?

For signal strength oFono explicitly doesn't poll this in the reference =

driver.  This is because vast majority of vendors out there have their own =

specific command to turn on period signal strength updates.  If you want th=
is =

feature, you need to submit a patch that enables this support explicitly.

>
> Can ofono send the CREG command regular to get the network information lo=
ok
> like COPS command?

No.

>
> If we expect application to initialize this request then which interface
> for it? Get properties and properties_changed can't get the updated
> information so far.

Nope, nothing like this is required.

Regards,
-Denis

--===============1704108562945936691==--

