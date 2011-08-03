Content-Type: multipart/mixed; boundary="===============8234541503166932503=="
MIME-Version: 1.0
From: Mario Tokarz <mario@tokarz.eu>
Subject: Re: [PATCH 2/2] dunmodem: Add stub for gprs.
Date: Wed, 03 Aug 2011 15:05:43 +0200
Message-ID: <20110803130543.GA4819@lmuc323778>
In-Reply-To: <1312375716.3373.29.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8234541503166932503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel

On Wed, Aug 03, 2011 at 02:48:35PM +0200 , Marcel Holtmann wrote:
<snip>

> > +
> > +static int dun_gprs_probe(struct ofono_gprs *gprs,
> > +					unsigned int vendor, void *data)
> > +{
> > +	DBG("");
> > +
> > +	g_timeout_add(500, dun_gprs_finish_registration, gprs);
> > +
> > +	return 0;
> > +}
> =

> Why 500 milliseconds? Why not just g_timeout_add_seconds(0, ...) or
> g_idle_add().
> =


Thx, I'm resending.

Cheers,
Mario

--===============8234541503166932503==--

