Content-Type: multipart/mixed; boundary="===============7387323909561686990=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC 1/1] GPRS Provisioning Plugin.
Date: Mon, 11 Jul 2011 11:11:39 +0300
Message-ID: <201107111111.39453.remi.denis-courmont@nokia.com>
In-Reply-To: <4E174B26.3080004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7387323909561686990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 08 July 2011 21:23:34 ext Denis Kenzior, you wrote:
> Hi Oleg,
> =

> <snip>
> =

> > +static int gprs_provision(const char *mcc, const char *mnc,
> > +				const char *spn,
> > +				struct ofono_gprs_provision_data **settings,
> > +				int *count)
> > +{
> > +	int i;
> > +	struct parser_data *data;
> > +	*settings =3D NULL;
> > +
> > +	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'",
> > +			mcc, mnc, spn);
> > +
> > +	data =3D g_try_new0(struct parser_data, 1);
> > +	if (data =3D=3D NULL)
> > +		return -ENOMEM;
> > +
> > +	lookup_apn(mcc, mnc, NULL, data);
> =

> What I wonder is what is the overhead of the XML parser right now (e.g.
> how long it takes on reasonable embedded hardware).  If this takes a
> while, then it might be better to pre-parse the mobile-provider-info db
> during plugin initialization and not every time gprs_provision is
> called.  Otherwise we run the risk of hanging the daemon while the
> provision settings are being looked up.

Provisioning should be a fairly rare occurence. Preparsing the table into =

memory might be a waste of both CPU and memory in the common circumstances.=
..

If you suspect the parser is slow (I doubt it, but I have not checked), the=
n =

it might be better to just do it in a separate thread in the rare cases tha=
t =

you actually do need the data.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============7387323909561686990==--

