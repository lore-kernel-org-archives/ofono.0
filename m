Content-Type: multipart/mixed; boundary="===============6652117103245863275=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 3/3] Add: online and post_online methods to isimodem driver
Date: Wed, 26 May 2010 00:24:11 +0300
Message-ID: <1274822651.3755.465.camel@tucson.research.nokia.com>
In-Reply-To: <201005260001.17101.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6652117103245863275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-25 at 23:01 +0200, ext R=C3=A9mi Denis-Courmont wrote:
> > bool not_online =3D isi->online !=3D TRUE;
> > bool not_normal =3D mtc_state !=3D MTC_NORMAL;
> > =

> > struct ofono_error error =3D {
> > 	not_normal && not_online ? NO_ERROR : FAILURE;
> > };
> =

> Err no. You've put a logical AND where Pekka had a logical NOT XOR.

Ah, so maybe it should have been s/&&/=3D=3D, but my point remains.
Chaining ? operators like that is confusing.

Cheers,
Aki







--===============6652117103245863275==--

