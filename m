Content-Type: multipart/mixed; boundary="===============4242485909143661628=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Incoming line identity and ALS
Date: Mon, 26 Oct 2009 11:53:37 -0500
Message-ID: <200910261153.38050.denkenz@gmail.com>
In-Reply-To: <20091026162708.14816kvlcut5xts0@boatman.intrepid.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4242485909143661628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Chris,

> > CDIP (like CLIP) is issued after every RING/CRING.  Whereas CLIP returns
> > the calling line identity, CDIP returns the called line identity (e.g.
> > the phone number the remote caller dialed.)  According to the
> > specification it is not reported for outbound calls.
>
> It seems that my phone doesn't support CDIP, although it does support
> line-2/ALS which is a bit odd. I'll investigate more on that..

Many Phase 2+ devices only supported ALS and the rest of the CPHS standards=
.  =

CPHS was largely merged into the 3G GSM standards.  If you're interested, =

google Common PCN Handset Specification.  This is where ALS comes from.

>
> One thing I'm not certain about is whether CDIP would report which
> line received the call, or which number the calller dialed as they
> could be different. I know other areas deal with routing information,
> but I wasn't sure which which number CDIP reported. It would be great
> for ALS support if it were the line that received the call, rather
> than the number dialed by the caller.. though that could be
> interesting in other situations.

This is entirely up to the network.  The likely scenario is that the networ=
k =

will normalize the number according to the network's rules.  While this sou=
nds =

nice, it can still lead to some ambiguities.  E.g. in the US the following =

numbers (as presented in CLIP) are equivalent:
"15556677", 129
"15556677", 145
"5556677",129

> I'll do more investigation and try and come back with something more
> constructive

Sounds good.

Regards,
-Denis

--===============4242485909143661628==--

