Content-Type: multipart/mixed; boundary="===============5063137594729189033=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 3/3] Add: online and post_online methods to isimodem driver
Date: Tue, 25 May 2010 23:51:09 +0300
Message-ID: <1274820669.3755.448.camel@tucson.research.nokia.com>
In-Reply-To: <201005252332.15624.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5063137594729189033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On Tue, 2010-05-25 at 22:32 +0200, ext R=C3=A9mi Denis-Courmont wrote:
> > > -	switch (isi->mtc_state =3D state) {
> > > +	ofono_modem_online_cb cb =3D isi->online_request.callback;
> > > +	struct ofono_error error =3D {
> > > +		(isi->online
> > > +			? mtc_state =3D=3D MTC_NORMAL
> > > +			: mtc_state !=3D MTC_NORMAL)
> > > +		? OFONO_ERROR_TYPE_NO_ERROR
> > > +		: OFONO_ERROR_TYPE_FAILURE,
> > > +	};
> > =

> > I can't parse this.
> =

> This is an intricate way to compare two boolean values:
> =

> ((!isi->online) =3D=3D (mtc_state !=3D MTC_NORMAL))
> 	? OFONO_ERROR_TYPE_NO_ERROR
> 	: OFONO_ERROR_TYPE_FAILURE;
> =

> i.e. if ISI online status equals to MTC state normal, then no error, =

> otherwise, error. C does not provide a *logical* XOR operator that would =

> simplify this.

It just isn't very readable.

Write that open, and I am able to parse it, so I think something like
this would be better:

bool not_online =3D isi->online !=3D TRUE;
bool not_normal =3D mtc_state !=3D MTC_NORMAL;

struct ofono_error error =3D {
	not_normal && not_online ? NO_ERROR : FAILURE;
};

Cheers,
Aki


--===============5063137594729189033==--

