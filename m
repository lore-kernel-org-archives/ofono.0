Content-Type: multipart/mixed; boundary="===============3052102970628144738=="
MIME-Version: 1.0
From: Max <Max.Suraev@fairwaves.ru>
Subject: Re: scan problem
Date: Fri, 20 Apr 2012 15:08:04 +0800
Message-ID: <4F910B54.2020103@fairwaves.ru>
In-Reply-To: <ED4DEEB78293B34A9D0EAC02A474A46E18AA2607@IRSMSX102.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3052102970628144738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

20.04.2012 14:44, Aygon, Bertrand =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:

> Can you please give more details?

Sure thing but I'll need some guidance on how obtain relevant information s=
ince I'm
complete newbie to ofono stack.

Btw, I'm trying to use this monstrous http://shop.sysmocom.de/products/load=
-tester16
assembly :)

> Is your modem enabled and online?

I think so - at least "./enable-modem /wavecom_q_0" returned no errors and =
changed
modem status to following:

[ /wavecom_q_0 ]
    Features =3D sim
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.SimManager
    Online =3D 0
    Type =3D hardware
    [ org.ofono.SimManager ]
        Retries =3D
        FixedDialing =3D 0
        SubscriberNumbers =3D
        BarredDialing =3D 0
        LockedPins =3D
        PinRequired =3D none
        Present =3D 1


> Can you please attach a log?

Adding -n -d to ofonod revealed nothing interesting besides absence of
/etc/ofono/phonesim.conf - which seems unlikely to be the culprit. What's t=
he
recommended procedure for log collection?

thanks,
Max.


--===============3052102970628144738==--

