Content-Type: multipart/mixed; boundary="===============6474559914800329658=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v0] Read EF_ICCID property of SIM
Date: Tue, 27 Apr 2010 08:36:31 +0200
Message-ID: <20100427063631.GA14818@gumpy.localdomain>
In-Reply-To: <201004261211.54532.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6474559914800329658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +
> > +	extract_bcd_number(data, len, number);
> > +	number[OFONO_MAX_ICCID_LENGTH] =3D '\0';
> > +	sim->iccid =3D g_strdup(number);
> > +
> > +	DBG("ICCID %s", sim->iccid);
> > +}
> > +
> =

> You might want to emit the property changed signal with the new ICCID val=
ue =

> here.

I had already the property update code there but there was some
problem with dbus. I figured that it wasn't setup correctly yet. I'll
look into that.

> >  static void sim_efphase_read_cb(const struct ofono_error *error,
> >  				const unsigned char *data, int len, void *user)
> >  {
> > @@ -1320,6 +1341,9 @@ static void sim_determine_phase(struct ofono_sim
> >  *sim)
> > =

> >  static void sim_initialize(struct ofono_sim *sim)
> >  {
> > +	sim->driver->read_file_transparent(sim, SIM_EF_ICCID_FILEID, 0, 10,
> > +					   sim_iccid_read_cb, sim);
> > +
> =

> Please use the sim file queue like EFpl does, no need to invent your own =

> solution.  =


I used the ofono_sim_read function but that didn't work. On the
terminal I saw only:

CRSM=3D192,12258 =


With read_file_transparent it is:

ofonod[2048]: Control:> AT+CRSM=3D176,12258,0,0,10\r
ofonod[2048]: Control:< \r\r\n+CRSM: 144,0,"989422024754212460F6"\r\n\r\nOK=
\r\n

> The phase check is a very specific case because we cache SIM files by =

> phase of the SIM, so it needs to be known / guessed before the rest of si=
m file =

> queue runs.

Thanks for the info. I'll update the patch.

daniel

--===============6474559914800329658==--

