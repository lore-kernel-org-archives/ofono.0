Content-Type: multipart/mixed; boundary="===============0220545317119072846=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH 3/3] Add: online and post_online methods to isimodem driver
Date: Tue, 25 May 2010 23:32:15 +0300
Message-ID: <201005252332.15624.remi@remlab.net>
In-Reply-To: <1274819061.3755.381.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0220545317119072846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le mardi 25 mai 2010 23:24:21 Aki Niemi, vous avez =C3=A9crit :
> > @@ -76,9 +81,33 @@ static void report_powered(struct isi_data *isi,
> > ofono_bool_t powered)
> > =

> >  		ofono_modem_set_powered(isi->modem, isi->reported =3D powered);
> >  =

> >  }
> > =

> > -static void set_power_by_mtc_state(struct isi_data *isi, int state)
> > +static void report_online(struct isi_data *isi, uint8_t mtc_state)
> > =

> >  {
> > =

> > -	switch (isi->mtc_state =3D state) {
> > +	ofono_modem_online_cb cb =3D isi->online_request.callback;
> > +	struct ofono_error error =3D {
> > +		(isi->online
> > +			? mtc_state =3D=3D MTC_NORMAL
> > +			: mtc_state !=3D MTC_NORMAL)
> > +		? OFONO_ERROR_TYPE_NO_ERROR
> > +		: OFONO_ERROR_TYPE_FAILURE,
> > +	};
> =

> I can't parse this.

This is an intricate way to compare two boolean values:

((!isi->online) =3D=3D (mtc_state !=3D MTC_NORMAL))
	? OFONO_ERROR_TYPE_NO_ERROR
	: OFONO_ERROR_TYPE_FAILURE;

i.e. if ISI online status equals to MTC state normal, then no error, =

otherwise, error. C does not provide a *logical* XOR operator that would =

simplify this.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/
http://fi.linkedin.com/in/remidenis

--===============0220545317119072846==--

