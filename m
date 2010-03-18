Content-Type: multipart/mixed; boundary="===============8508753425174240761=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Barring API
Date: Thu, 18 Mar 2010 16:46:28 +0200
Message-ID: <80fd4e751003180746n2acc1eey3e4bf66f44e3f427@mail.gmail.com>
In-Reply-To: <201003161310.22835.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8508753425174240761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/16 Denis Kenzior <denkenz@gmail.com>:
> The signals and properties are actually different. =C2=A0The signals are =
reported
> via IncomingBarringInEffect and OutgoingBarringInEffect are reported by t=
he
> classical 27.007 modem through +CSSI/+CSSU. =C2=A0They're just simple not=
ifications.
> The PropertyChanged is what reports the changes in properties.

Oh, looks like there was a bug in get_query_lock_callback() that I
could not figure out. It returned the initial reply based on the old
state and emitted signals based on the new state. I've sent patches,
too.

> We query all basic services at once, so in theory there should be no extra
> time needed for Fax, Data, SMS, etc. =C2=A0The attributes are simply neve=
r exposed
> today.

Yes, it seems to me that you are right, I did not read the 27.007
closely enough.

-- =

Pekka.Pessi mail at nokia.com

--===============8508753425174240761==--

