Content-Type: multipart/mixed; boundary="===============8514181354355453724=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 11:26:16 -0500
Message-ID: <200909021126.16772.denkenz@gmail.com>
In-Reply-To: <200909021838.29834.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8514181354355453724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> Le mercredi 2 septembre 2009 18:00:22 Denis Kenzior, vous avez =C3=A9crit=
 :
> > Actually this one is missing from the API proposal.  Marcel already
> > wanted the context type (internet, mms, wap, etc) information.  I've
> > updated the proposed API in git.
>
> This is not going to work.
>
> Depending on the operator, you may have more than one "type" for a single
> context (e.g. WAP+MMS), or worse, multiple contexts of the same type (e.g.
> Internet with only Web and Internet with full IP).

Worst case we make the field completely freeform.  Right now we really only =

care about "internet" type for connman.

>
> > As discussed previously, we want oFono to manage this data, since it can
> > do this by using the IMSI.  So if you insert a different operator SIM
> > your APN settings are magically updated for that operator.
>
> I have a feeling this does not work either. If I upgrade my subscription,
> the APN may change while not the IMSI, no?

Yes, but then you will probably receive an SMS/OTA message with new connect=
ion =

details.  Which either oFono or some external application will apply to you=
r =

GPRS settings.

> > This really belong in the kernel.  Only the kernel can reliably know wh=
en
> > a network interface has been brought down and notify the interested
> > applications with the statistics.
>
> You're missing the point.
>
> Yes, any body can extract the statistics for a running context. But data
> counters are cumulating. To compute the sum properly, there are but two
> options:
> # Either the GPRS middleware requests kernel per-interface statistics rig=
ht
> before destroying the interface, and sums with the earlier total.
> # Or the modem does it internally.

I know why you want this, but I'm still against the counter being an oFono =

driver API.  There needs to be a proper kernel interface that signals the =

application when an interface has gone away with the rx/tx details.  This w=
ay =

we handle this generically for all modems without relying on some intrinsic =

hardware capabilities.

The rx/tx counter not being reported via PropertyChanged is also a bad idea =

since it breaks our API conventions.  I can deal with a one-time signal bei=
ng =

emitted when the interface has gone away though.

Regards,
-Denis

--===============8514181354355453724==--

