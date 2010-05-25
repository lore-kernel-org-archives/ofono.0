Content-Type: multipart/mixed; boundary="===============1418821557848064903=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH 3/3] Add: online and post_online methods to isimodem driver
Date: Wed, 26 May 2010 00:01:16 +0300
Message-ID: <201005260001.17101.remi@remlab.net>
In-Reply-To: <1274820669.3755.448.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1418821557848064903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le mardi 25 mai 2010 23:51:09 Aki Niemi, vous avez =C3=A9crit :
> > i.e. if ISI online status equals to MTC state normal, then no error,
> > otherwise, error. C does not provide a *logical* XOR operator that would
> > simplify this.
> =

> It just isn't very readable.
> =

> Write that open, and I am able to parse it, so I think something like
> this would be better:
> =

> bool not_online =3D isi->online !=3D TRUE;
> bool not_normal =3D mtc_state !=3D MTC_NORMAL;
> =

> struct ofono_error error =3D {
> 	not_normal && not_online ? NO_ERROR : FAILURE;
> };

Err no. You've put a logical AND where Pekka had a logical NOT XOR.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/
http://fi.linkedin.com/in/remidenis

--===============1418821557848064903==--

