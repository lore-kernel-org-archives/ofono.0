Content-Type: multipart/mixed; boundary="===============9130501208596159733=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 4/4] udev: add Telit UC864-G and update udev rules
Date: Mon, 13 Jun 2011 04:28:43 -0500
Message-ID: <4DF5D84B.4030607@gmail.com>
In-Reply-To: <alpine.DEB.2.00.1106140956070.30119@entw48>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9130501208596159733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

>> In theory you can use $GPSNMUN to enable GPS reporting on Ports 1 and 4
>> which seem to be fully functional.  However, it does look like on my
>> UC864-G, port #3 is used for the GPS stream.  Port #1 doesn't seem to
>> respond to anything.
>>
> =

> I just tried the following at my modem:
> =

> AT$GPSNMUN=3D1,1,1,1,1,1,1
> AT$GPSP=3D1
> =

> Which enables the GPS reporting on Ports 1 and 4 and adds $GPSNMUN: at
> the beginning of every GPS report e.g.
> =

> $GPSNMUN: $GPVTG,,T,,M,,N,,K*4E
> =

> Which would be easy to catch from ofono.
> =

> In my opinion the problem about this is that the GPS atom needs to be
> loaded for every telit modem, then try AT$GPSNMUN=3D1,1,1,1,1,1,1 and wait
> for the response. If the response is an error the atom knows that the
> modem does not support GPS. Could this check/enable also be added to a
> part of the telit plugin?
> =

> The udev approach has the benifet to be able to do
> =

> if (HasGPS)
>     ... =3D ofono_location_reporting_create(...);
> =

> or something like that at the telit plugin.
> =


I agree that your proposed approach is the right one.

>>
>> Yes and no.  ofono_modem_create has two modes of operation, one where a
>> known unique id is given.  This can come for example from the serial
>> number of the USB device.  Some manufacturers provide this information
>> properly, others do not.  If you cannot trust the USB serial ID, then
>> giving a NULL parameter to ofono_modem_create will tell oFono to
>> generate a unique id itself.  Your path will then look like /telit2 or
>> something like that.
> =

> Ah, ok then the patch is fine I think and I like to get it reviewed :)
> =

> But I can alter the patch to only search for the modem device and add
> the GPS check later to the telit plugin or the GPS atom, if you like.
> =


Patch has been reviewed, however we might have to examine whether we
need to tweak the udev rules for this serial number / modem path stuff
to work properly.  Marcel will have to take a look as I'm lost in that
part of the udev plugin.

Regards,
-Denis

--===============9130501208596159733==--

