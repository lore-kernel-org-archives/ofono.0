Content-Type: multipart/mixed; boundary="===============3331487854298603701=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: Voice call audio routing
Date: Mon, 20 Dec 2010 15:08:54 +0100
Message-ID: <725063E4C37388418CDDC5A2C287906A24C7338177@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <AANLkTimupnMBwpoZAM1+mmTPaojOewv4+mJTCYeiWJzt@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3331487854298603701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 16 Dec 2010, Nicola Mfb wrote:
> While testing an e169 huawei card I was able to make voice calls and
> hear something with aplay and /dev/ttyUSB1.
> On the openmoko/freerunner is a matter of HW switches, on the n900
> IIRC is done with pulseaudio.
> I guess that voice call audio routing is not in oFono plans, if I'm
> correct is there a reference project (may be not depending deeply on
> meego) that abstracts that task in an extensible/pluggable way?

not really I'm afraid, no reference project yet. The MeeGo stack =

for N900 is the closest thing at the moment:
http://wiki.meego.com/ARM/N900/Features/CallAudio

There's nothing inherently specific to MeeGo in the above, but of =

course some parts of it are very specific to N900 and its modem. =

Fortunately these are mostly isolated into a separate PA modules (so =

the rest of the stuff could be shared with other modems). More
generally, the speech interface to modems is currently not at all =

standard, and the differences are fairly big among the current modems =

that supports this (the low-level hw interfaces are different, =

the protocols are different, the kernel drivers are different and =

so forth).

E.g. USB might be used as the interface in dongles for laptops, but
it is not really suitable as the primary interface when building
a phone (it might be used as a secondary channel to record calls,
but that's different). USB audio can still be supported of course,
but just as an example why not all modems will have an interface
such as the e169 has.

But e.g. if you got the e169 working with aplay, then in theory
it fits quite nicely to the N900 stack mentioned above. The same
pipeline (on N900) is already used for CS (with the device modem) and =

VoIP calls (with gstreamer/farsight), so architecture is in that sense =

ready to support other network source/destinations for voice streams.
The integration to oFono AudioSettings interface is also there
(so that the audio pipeline is automatically set up when there is =

a call).

br,
-- =

Kai Vehmanen


--===============3331487854298603701==--

