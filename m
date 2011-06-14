Content-Type: multipart/mixed; boundary="===============4744431868011396825=="
MIME-Version: 1.0
From: Ed W <lists@wildgooses.com>
Subject: Re: Serial Port modems - can ofono help?
Date: Tue, 14 Jun 2011 15:28:36 +0100
Message-ID: <4DF77014.2090002@wildgooses.com>
In-Reply-To: <4DF36DED.1020102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4744431868011396825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/06/2011 14:30, Denis Kenzior wrote:
> Hi Ed,
> =

> On 06/12/2011 06:30 AM, Ed W wrote:
>> Hi, I have a bunch of serial to usb adaptors which will be connected to
>> either a GPS or a serial port modem (yes such things still exist in
>> use).  Can ofono help me detect whether a given serial port is connected
>> to a modem, gps or disconnected?
> =

> Not really.  You can certainly integrate with oFono's udev detection
> code for the usb serial port converter detection and automatically know
> which ttys belong to the serial converter.

Thanks could you offer me some reference to what you mean here?  ie does
ofono offer me something over and above simply a udev rule firing on the
correct subsystem (and perhaps limiting by driver name if we really want
to tighten up the rule?)

> However, to my knowledge there is no way to know what is 'on the other
> side'.  You would need to open the tty and run a few AT commands to find
> out the actual device type.

Agreed - I currently plan to gently probe any serial to usb devices to
see if they either a) chat without listening (GPS), b) raise various
modem lines high, c) respond to AT, ATI, ATCGSM, etc

A slight subtlety is that we need to allow for someone to plug in the
serial to usb adaptor without the modem powered on, and hence probing
might take an unknown amount of time (wow doesn't USB solve a lot of
issues...)

> If you can combine the two above parts then you might be able to detect
> modem devices automatically, Marcel had a few ideas how to do this, but
> nothing concrete has been done yet.

I need to implement something pretty imminently - just wondering if
ofono had something to help.  For example is there a "probe this port
and tell me what modem is on the end" feature? That way I could point it
at my suspected serial port and ask ofono to scan it?

Thanks

Ed W

--===============4744431868011396825==--

