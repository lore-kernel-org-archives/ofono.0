Content-Type: multipart/mixed; boundary="===============4539815139295931472=="
MIME-Version: 1.0
From: Chris Pitchford <ofono@intrepid.cx>
Subject: Incoming line identity and ALS
Date: Sun, 25 Oct 2009 23:03:44 +0000
Message-ID: <alpine.LNX.2.00.0910252301450.22627@boatman.intrepnet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4539815139295931472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I've been looking through the 0.8 source code for some indication of ALS =

support.

ALS (or line-2) allow two different numbers to be attached to a mobile =

device. The device can accept calls from both numbers and make calls from =

either of the two numbers, effectively acting as if two lines were =

attached to the device.

http://en.wikipedia.org/wiki/Alternate_line_service

AT+CNUM reports all of the lines available on a mobile device that =

supports/is using ALS.

I guess there are two problems for supporting ALS in ofono.

First is selecting which line/number to use when making a call. I'm not =

certain how handsets make this distinction and I wonder if it might be =

vendor specific.. Changing out bound line seems to be set as a mode rather =

than on a
per-call basis. Switching out bound lines is sometimes locked with PIN1.

The other problem is identifying which line was called by a remote caller. =

I believe +CDIP includes this information (after each RING / +CRING)

From what I've seen of the API, it has the ability to report the caller =

identity for in bound calls and the dialed number for out bound calls, but =

I can't seem to find any reference to the number called for in bound calls =

which would be used to identify which line was ringing..

I was wondering if this service has been considered for ofono or if =

perhaps it is already there and I've missed it..

Cheers

Chris

--===============4539815139295931472==--

