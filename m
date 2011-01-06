Content-Type: multipart/mixed; boundary="===============6496019835378861716=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Thu, 06 Jan 2011 18:14:16 +0100
Message-ID: <AANLkTin=fqW4hXUifGraBuZkEQdvCRMC0=ZQ1Of4MNOi@mail.gmail.com>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948A9C123FBC@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6496019835378861716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From my understanding the ID in the core is an internal ID for oFono core=
, even if today we usually have a mapping 1 to 1 between oFono core ID and =
modems CID.
> Denis, Marcel could you confirm ?

Negative, to my understanding the CID is allocated in src/gprs.c and used
when activating/deactivating PDP contexts (PDN Connections):

<snip>
static gboolean assign_context(struct pri_context *ctx)
{
...
	ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);

<snip>
static void ...gprs_activate_primary(struct ofono_gprs_context *gc,
				const struct ofono_gprs_primary_context *ctx,
				ofono_gprs_context_up_cb_t cb, void *data)
{
	gcd->active_context =3D ctx->cid;


> If we try to do something else oFono core will be modem dependent and it'=
s really not a good idea.

It has been talk about standardizing the use of CID=3D0 for initial
PDN.If this comes
true this is no longer modem vendor dependent.

Regards,
Sjur

--===============6496019835378861716==--

