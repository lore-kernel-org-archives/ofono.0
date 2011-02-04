Content-Type: multipart/mixed; boundary="===============6871103092974591970=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: Re: [RFC] ifxmodem: integrating new kernel-space MUX driver
Date: Thu, 03 Feb 2011 16:06:33 -0800
Message-ID: <1296777993.5027.7.camel@think03>
In-Reply-To: <1296558001.1520.262.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6871103092974591970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> I am doing just a basic review here to get things going into the right
> direction.

I'll try to hash this out a bit, so maybe there won't many patch
re-submissions... =


> > +	gboolean use_ofono_mux;
> =

> This is the thing I'd rather not do. We can just have a second GPRS
> context driver. Not sure about the naming, but one could be "ifxmodem"
> and the other "ifxmodem-internal" or similar. Maybe someone comes up
> with some better names.

We had little internal discussion about this. We would like to use the
same gprs context driver instead, just as proposed. however, if you
insist on another gprs context driver ... Let me know what you think.

> > +	char if_name[IF_NAMESIZE];
> =

> This should not be needed. You can just reference the stack variable.

Ok.

> > +
> > +#define GSMIOC_ENABLE_NET       _IOW('G', 2, struct gsm_netconfig)
> > +#define GSMIOC_DISABLE_NET      _IO('G', 3)
> > +
> =

> This should be in drivers/ifxmodem/gsmmux.h and be a literal copy from
> what the kernel has. Check STE and how it does it for CAIF.

Ok, I'll pull gsmmux.h into patch submission. =


> >  	chat =3D g_at_chat_get_slave(gcd->chat);
> > @@ -475,6 +549,10 @@ static void ifx_gprs_context_remove(struct ofono_g=
prs_context *gc)
> >  		g_at_chat_resume(gcd->chat);
> >  	}
> >  =

> > +	if (gcd->state !=3D STATE_IDLE && gcd->use_ofono_mux =3D=3D FALSE) {
> > +		g_at_chat_resume(gcd->chat);
> > +	}
> > +
> =

> What is this trying to fix? Either it is a general bug or not. Seems
> more like a general bug that we tie rawip existence with the state.

It was just resuming chat when kernel mux was used.


> Check if remove() will be actually ever called without calling
> deactivate() first. It might be well that this is an oversight on my
> part.

I'll test this. =


> > +	int ret;
> =

> As a general rule I prefer err as variable name.

Sure.

> > +		ofono_error("Failed to get configuration on n_gsm multiplexer: %d", =
ret);
> > +		goto error;
> =

> You forgot to restore the line discipline here.

Right, I'll inject this into the patch in those places where we can have
error... and watch for re-base.

There is updated patch in the works for MUX itself, as you know, once
it's in the kernel, I'll resubmit updated patch. =


Thanks,
-- r.




--===============6871103092974591970==--

