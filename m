Content-Type: multipart/mixed; boundary="===============0861381988617117537=="
MIME-Version: 1.0
From: Bernhard Guillon <Bernhard.Guillon@hale.at>
Subject: Re: [PATCH v4 4/4] udev: add Telit UC864-G and update udev rules
Date: Tue, 14 Jun 2011 10:34:35 +0200
Message-ID: <alpine.DEB.2.00.1106140956070.30119@entw48>
In-Reply-To: <4DEF338F.1020701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0861381988617117537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On Wed, 8 Jun 2011, Denis Kenzior wrote:

> Hi Bernhard,
>
>>>
>>> From what I remember of the Telit modems, all ports are fully
>>> functional, so the GPS port can be on any tty.  If this is the case,
>>> then the way this can be accomplished is by querying the model /
>>> revision of the modem during the enable() stage in the modem driver and
>>> adding the appropriate atom as needed.
>>>
>>
>> The GPS port is not fully functional as far is I know it is read only.
>> According to the manual it is necessary to enable over the modem line
>> with AT$GPSP=3D1 afterwards it starts reporting NMEA signals on the GPS =
line.
>>
>
> In theory you can use $GPSNMUN to enable GPS reporting on Ports 1 and 4
> which seem to be fully functional.  However, it does look like on my
> UC864-G, port #3 is used for the GPS stream.  Port #1 doesn't seem to
> respond to anything.
>

I just tried the following at my modem:

AT$GPSNMUN=3D1,1,1,1,1,1,1
AT$GPSP=3D1

Which enables the GPS reporting on Ports 1 and 4 and adds $GPSNMUN: at the =

beginning of every GPS report e.g.

$GPSNMUN: $GPVTG,,T,,M,,N,,K*4E

Which would be easy to catch from ofono.

In my opinion the problem about this is that the GPS atom needs to be =

loaded for every telit modem, then try AT$GPSNMUN=3D1,1,1,1,1,1,1 and wait =

for the response. If the response is an error the atom knows that the =

modem does not support GPS. Could this check/enable also be added to a =

part of the telit plugin?

The udev approach has the benifet to be able to do

if (HasGPS)
 	... =3D ofono_location_reporting_create(...);

or something like that at the telit plugin.

>
> Yes and no.  ofono_modem_create has two modes of operation, one where a
> known unique id is given.  This can come for example from the serial
> number of the USB device.  Some manufacturers provide this information
> properly, others do not.  If you cannot trust the USB serial ID, then
> giving a NULL parameter to ofono_modem_create will tell oFono to
> generate a unique id itself.  Your path will then look like /telit2 or
> something like that.

Ah, ok then the patch is fine I think and I like to get it reviewed :)

But I can alter the patch to only search for the modem device and add the =

GPS check later to the telit plugin or the GPS atom, if you like.

Best regards,
Bernhard


--
Scanned by MailScanner.


--===============0861381988617117537==--

