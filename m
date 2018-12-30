Content-Type: multipart/mixed; boundary="===============3553276107535008999=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Motorola motmdm support
Date: Sun, 30 Dec 2018 13:13:24 -0600
Message-ID: <ea54fd64-d45f-7324-c5a9-6044ff34bb23@gmail.com>
In-Reply-To: <20181230181419.GE6707@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3553276107535008999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

>> It might make your job easier if the oFono driver itself invoked the
>> necessary magic to setup the multiplexer and handed off the devices as
>> needed.  We used to have a driver like this, but not sure if it ever mad=
e it
>> upstream.
> =

> Playing with ldattach and user space handling earlier this year did
> not work out good.. It needed app specific handling for the Motorola
> custom layer on top of ts 27.010, custom handling for all the devices
> such as GNSS and audio mixer, and did not work well with device
> specific power management. So let's not go back to that :)

You still need someone to send AT+CMUX, no?  And you most likely need to =

integrate power management into the telephony stack anyway.  As I =

mentioned, we had a driver like this that worked just fine.  oFono ended =

up using a user space MUX since most of the quality of life improvements =

to n_gsm came in much later.  If I was writing a new MUXed driver these =

days, I'd seriously consider using GSMIOC_SETCONF and GSMIOC_ENABLE_NET.

How does the audio mixer handling work?  Just some AT commands to setup =

the mixing parameters, or something more involved?

Some other things to consider:
- oFono expects / is designed to expect exclusive access to all the tty =

ports
- GNSS/GPS is intended to be handled via oFono LocationReporting API.  I =

would recommend integrating this as intended...

> =

>>> One more question: I guess I'll need to implement this... Is there
>>> another example of driver doing AT commands but on multiple file
>>> descriptors? I could really use something to look at as a template..
>>
>> Any driver for a USB based device would be setup this way.  Each AT port=
 is
>> a separate file, e.g. ttyUSB1, ttyACM2, etc.  The discovery is done via
>> udev.  See plugins/mbm.c or plugins/ublox.c or plugins/telit.c, etc.
>>
>> Assuming you don't want to setup the multiplexer in oFono, then the only
>> tricky part is the port setup.  udevng.c setup_serial_modem() assumes a
>> single port, so you might need to add some extra logic to setup the ports
>> via udev rules.
> =

> We have network status data at /dev/motmdm1, outgoing SMS PDU device at
> /dev/motmdm3, incoming SMS PDU device at /dev/motmdm9 and so on for each
> ts 27.010 channel. At least incoming and outgoing SMS PDU devices could
> be considered as separate modems if that makes things easier?

No, that just makes things more difficult.

> =

>> Alternatively, simply use a config file specific to your driver.  See for
>> example how plugins/phonesim.c does this.
>>
>> Or, if it is an extremely platform specific driver, then just hardcode i=
t.
>> E.g. like plugins/calypso.c, which only works for the Freerunner.
> =

> Just adding one more thing to consider: Looks like the modem handling for
> SMS PDU's needs to be specific to the nework. First the network needs to
> be detected, and then the GSM or CDMA handlers need to be used for sending
> and receiving SMS. After that things should get standard.. Looks like
> ofono has parsing for the different type SMS PDUs in src/*sms*.c :)
> =


There's no real functional CDMA support in oFono anyhow.  Given that =

most CDMA networks are about to be switched off, I don't know why you =

would bother?

Regards,
-Denis

--===============3553276107535008999==--

