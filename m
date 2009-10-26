Content-Type: multipart/mixed; boundary="===============8100847874068904853=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Incoming line identity and ALS
Date: Mon, 26 Oct 2009 10:59:03 -0500
Message-ID: <200910261059.04471.denkenz@gmail.com>
In-Reply-To: <alpine.LNX.2.00.0910252301450.22627@boatman.intrepnet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8100847874068904853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Chris,

> Hi all,
>
> I've been looking through the 0.8 source code for some indication of ALS
> support.
>
> ALS (or line-2) allow two different numbers to be attached to a mobile
> device. The device can accept calls from both numbers and make calls from
> either of the two numbers, effectively acting as if two lines were
> attached to the device.

ALS was never part of the core GSM specification.  It was an extension =

supported by several network providers and phone manufacturers.  It was =

incorporated into recent GSM specifications as 'Multiple Subscriber Profile=
.'

> First is selecting which line/number to use when making a call. I'm not
> certain how handsets make this distinction and I wonder if it might be
> vendor specific.. Changing out bound line seems to be set as a mode rather
> than on a
> per-call basis. Switching out bound lines is sometimes locked with PIN1.

This is done as a supplementary service control sent to the network over US=
SD.  =

The details are pretty sketchy but the basics are described in 22.030 Secti=
on =

6.5.6.1.

>
> The other problem is identifying which line was called by a remote caller.
> I believe +CDIP includes this information (after each RING / +CRING)
>
> From what I've seen of the API, it has the ability to report the caller
> identity for in bound calls and the dialed number for out bound calls, but
> I can't seem to find any reference to the number called for in bound calls
> which would be used to identify which line was ringing..

CDIP (like CLIP) is issued after every RING/CRING.  Whereas CLIP returns th=
e =

calling line identity, CDIP returns the called line identity (e.g. the phon=
e =

number the remote caller dialed.)  According to the specification it is not =

reported for outbound calls.

>
> I was wondering if this service has been considered for ofono or if
> perhaps it is already there and I've missed it..

oFono currently does not support ALS/MSP and we do not foresee enabling thi=
s =

feature in the near term.  If you would like to help out, code / research / =

documentation contributions are always welcome :)

Regards,
-Denis

--===============8100847874068904853==--

