Content-Type: multipart/mixed; boundary="===============9145119705663120897=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Motorola motmdm support
Date: Sat, 29 Dec 2018 18:14:06 -0600
Message-ID: <2e54ecb4-e104-5d1d-5e5c-274ee13b7d73@gmail.com>
In-Reply-To: <20181229220856.GA28688@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9145119705663120897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

>> Kernel 27.010 multiplexer or something else entirely?
> =

> Kernel 27.010 multiplexer, AFAICT. Some of the endpoints are handled
> in kernel (gps, audio mixer control).
> =


Who sets up the multiplexer? Kernel?

It might make your job easier if the oFono driver itself invoked the =

necessary magic to setup the multiplexer and handed off the devices as =

needed.  We used to have a driver like this, but not sure if it ever =

made it upstream.

> =

> One more question: I guess I'll need to implement this... Is there
> another example of driver doing AT commands but on multiple file
> descriptors? I could really use something to look at as a template..

Any driver for a USB based device would be setup this way.  Each AT port =

is a separate file, e.g. ttyUSB1, ttyACM2, etc.  The discovery is done =

via udev.  See plugins/mbm.c or plugins/ublox.c or plugins/telit.c, etc.

Assuming you don't want to setup the multiplexer in oFono, then the only =

tricky part is the port setup.  udevng.c setup_serial_modem() assumes a =

single port, so you might need to add some extra logic to setup the =

ports via udev rules.

Alternatively, simply use a config file specific to your driver.  See =

for example how plugins/phonesim.c does this.

Or, if it is an extremely platform specific driver, then just hardcode =

it.  E.g. like plugins/calypso.c, which only works for the Freerunner.

Regards,
-Denis


--===============9145119705663120897==--

