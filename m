Content-Type: multipart/mixed; boundary="===============5963021087334362107=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Serial Port modems - can ofono help?
Date: Sat, 11 Jun 2011 08:30:21 -0500
Message-ID: <4DF36DED.1020102@gmail.com>
In-Reply-To: <4DF4A366.2090506@wildgooses.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5963021087334362107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ed,

On 06/12/2011 06:30 AM, Ed W wrote:
> Hi, I have a bunch of serial to usb adaptors which will be connected to
> either a GPS or a serial port modem (yes such things still exist in
> use).  Can ofono help me detect whether a given serial port is connected
> to a modem, gps or disconnected?

Not really.  You can certainly integrate with oFono's udev detection
code for the usb serial port converter detection and automatically know
which ttys belong to the serial converter.

However, to my knowledge there is no way to know what is 'on the other
side'.  You would need to open the tty and run a few AT commands to find
out the actual device type.

If you can combine the two above parts then you might be able to detect
modem devices automatically, Marcel had a few ideas how to do this, but
nothing concrete has been done yet.

Regards,
-Denis

--===============5963021087334362107==--

