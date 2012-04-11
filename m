Content-Type: multipart/mixed; boundary="===============4375399864565207876=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH v2] SpeedUp: enable online/offline
Date: Wed, 11 Apr 2012 07:17:46 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E18A91056@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <4F83E3DC.30203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4375399864565207876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > @@ -232,12 +236,122 @@ static int speedup_disable(struct ofono_modem
> *modem)
> >  	g_at_chat_cancel_all(data->aux);
> >  	g_at_chat_unregister_all(data->aux);
> >
> > +	/* Cleanup potential online enable polling */
> > +	if (data->online_poll_source > 0) {
> > +		g_source_remove(data->online_poll_source);
> > +		data->online_poll_source =3D 0;
> > +
> > +		g_free(data->online_cbd);
> > +		data->online_cbd =3D NULL;
> > +	}
> > +
> =

> This looks fine, but it is actually in the wrong place.  The core doesn't=
 allow
> concurrent online and disable operations.  This really belongs in
> speedup_remove so that you take care of the case where the modem is
> physically yanked out.

Ok, I see. In fact, I used Huawei plugin as example, so I will also fix it =
:)

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============4375399864565207876==--

