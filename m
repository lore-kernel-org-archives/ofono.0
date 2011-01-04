Content-Type: multipart/mixed; boundary="===============1617028039527813064=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Tue, 04 Jan 2011 00:05:05 -0800
Message-ID: <1294128305.5852.72.camel@aeonflux>
In-Reply-To: <1294125223.8212.59.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1617028039527813064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> > thinking about this a bit more and with the background that there is
> > already an existing public database, we might should just enable a
> > provision driver inside the oFono core.
> > =

> > Meaning that we can have multiple implementations of different databases
> > with just different priorities. Each nicely separated in their own
> > plugin and we don't bother the oFono core with where to get the data
> > from. So my idea would be that the oFono core just asks to provision a
> > new context. If a plugin feels responsible, then it does so. If not then
> > it stays empty.
> >
> > Running oFono on the desktop/netbook etc. it makes sense to use the
> > current mobile broadband provider database. However on a phone that is a
> > not so good database. And for you guys it would also be possible to
> > continue using a CSV based format.
> =

> This sounds very good to me. Making provisioning modular makes a lot of
> sense.
> =

> But I am not yet very familiar with oFono plugin architecture. Is there
> some pattern in oFono code I could follow when implementing this, or
> could you or someone provide some skeleton code how this should go?
> =

> In my patch (3/4) for gprs.c, I call get_operator_settings() (in
> operator-settings.c), which returns list of gprs_access_settings, that
> are then created as contexts. I assume now this  get_operator_settings()
> would somehow call registered provisioning modules, that similarly would
> return list of gprs_access_settings? Or should these plugins directly
> call some new gprs atom interface to create the contexts?

the oFono plugins work like kernel modules. They are pretty much
generic. Inside the init function you can a driver register function and
inside the exit function, you call the driver unregister function.

We need to discuss some more details here, but something along these
lines should do it:

struct ofono_gprs_provision_driver {
	const char *name,
	int priorty,
	int (*setup_context) (struct ofono_gprs_primary_context *context),
};

int ofono_gprs_provision_driver_register(const struct ofono_gprs_provision_=
driver *);
void ofono_gprs_provision_driver_unregister(const struct ofono_gprs_provisi=
on_driver *);

I am not 100% sure about the naming here, but something along these
lines seems to be the way to go.

Then your specific plugin would look like this:

static int setup_context(struct ofono_gprs_primary_context *context)
{
	...

	return 0;
}

static const ofono_gprs_provision_driver driver {
	.name =3D	"test",
	.setup_context =3D setup_context,
};

static int plugin_init(void)
{
	return ofono_gprs_provision_driver_register(&driver);
}

static void plugin_exit(void)
{
	ofono_gprs_provision_driver_unregister(&driver);
}

OFONO_PLUGIN_DEFINE(myplugin, "My provision plugin", VERSION,
	OFONO_PLUGIN_PRIORITY_DEFAULT, plugin_init, plugin_exit)

Regards

Marcel



--===============1617028039527813064==--

