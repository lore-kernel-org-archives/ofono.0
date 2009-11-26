Content-Type: multipart/mixed; boundary="===============0006013788685611684=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono running on new Freerunner distribution
Date: Thu, 26 Nov 2009 07:44:51 -0600
Message-ID: <200911260744.52771.denkenz@gmail.com>
In-Reply-To: <4B0E5533.7090109@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0006013788685611684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dario,

> Hi Denis,
>
> > I pushed an experimental fix.  Let me know if you can now hangup alerti=
ng
> > calls.  It did not make it into release 0.11 though.
>
> before, I can dial but can't hangup during alerting state. Furthermore

Ok, I pushed a few more things that should fix this.  At least it does for =
me =

on my Freerunner.   If it still doesn't work, can you send me a log of what =

happens.  export OFONO_AT_DEBUG=3D1 and run with ofono -nd.

> after the first conversation this new release doesn't let me dial any
> other number but can receive calls... I tried the previous one (0.9
> IIRC) and it worked well.

Is your moko device upgraded to the latest gsm firmware?  I'm using moko11 =
and =

this seems to work.  Are you running the native calypso plugin or using =

phonesim plugin?

Note that the previous wakeup handling did not always for the phonesim one, =

I've pushed a few fixes that should take care of this as well.

Regards,
-Denis

--===============0006013788685611684==--

