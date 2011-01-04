Content-Type: multipart/mixed; boundary="===============5388613183895094026=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Tue, 04 Jan 2011 10:42:27 +0200
Message-ID: <1294130547.8212.82.camel@jsaunama-desktop>
In-Reply-To: <1294128305.5852.72.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5388613183895094026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

> the oFono plugins work like kernel modules. They are pretty much
> generic. Inside the init function you can a driver register function and
> inside the exit function, you call the driver unregister function.

Right, that seems clear enough.

> static int setup_context(struct ofono_gprs_primary_context *context)
> {
> 	...
> =

> 	return 0;
> }
> =

> static const ofono_gprs_provision_driver driver {
> 	.name =3D	"test",
> 	.setup_context =3D setup_context,
> };

I guess that current struct ofono_gprs_primary_context* is not enough
for provisioning data, it is missing at least name, MMS proxy and server
information. Should those (and whatever might be needed in future) be
added into that struct, or should we define some =

struct ofono_gprs_provisioning_data {
	struct ofono_gprs_primary_context pri;
	char name[MAX_CONTEXT_NAME_LENGTH + 1];
	char message_proxy[MAX_MESSAGE_PROXY_LENGTH + 1];
	char message_center[MAX_MESSAGE_CENTER_LENGTH + 1];	=

}
struct pri_context in gprs.c contains everything, but has extra
gprs-internal stuff.  =


Also setup_context() needs ofono_gprs_context_type as in-parameter.


And a question about the priorities, if there is more than one
provisioning plugin: would plugins be called in priority order, and
after first returns something, rest would not be called?

--Jukka



--===============5388613183895094026==--

