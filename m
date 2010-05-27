Content-Type: multipart/mixed; boundary="===============0591992222160003060=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Add: Online property to modem
Date: Thu, 27 May 2010 09:45:53 -0500
Message-ID: <201005270945.53526.denkenz@gmail.com>
In-Reply-To: <AANLkTikQJ6AooO-z3IUNthX_d9IlXffpaZKI1XXT18xZ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0591992222160003060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> 2010/5/27 Denis Kenzior <denkenz@gmail.com>:
> > Patch has been applied, however I did some refactoring afterward.  Plea=
se
> > test that I didn't break something.
> =

> There is now a race condition in online/offline and sim hotswap. With
> imperfect hw a missing sim gets detected only when modem attempts to
> register to network and actually tries to read something from sim
> card. I have no idea if the missing sim can be reported before +cops
> command response is returned.

Sorry, but how does such a modem even get to the sim ready state?  oFono re=
ads =

the IMSI before it even tries to send post_sim, and you certainly can't rea=
d =

the IMSI without a sim card.

Or are you talking about an emergency call case here?

> =

> However, at least isimodem needs explicitly told to go offline when
> sim gets removed.
> =


My thinking is that the modem drivers can take care of this.  The core need=
s =

to be kept simple here and assume an 'ideal' implementation.

I'm still having trouble understanding how we'll support emergency calls wi=
th =

no SIM with this framework though.

Regards,
-Denis

--===============0591992222160003060==--

