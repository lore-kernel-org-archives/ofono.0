Content-Type: multipart/mixed; boundary="===============5761916999179739067=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v3 1/4] GAtPPP: Add ACFC option support
Date: Tue, 28 Jun 2011 18:24:22 -0700
Message-ID: <1309310665.2208.29.camel@aeonflux>
In-Reply-To: <4E0A0977.8050801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5761916999179739067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > @@ -658,6 +703,11 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const c=
har *remote,
> >  	ipcp_set_server_info(ppp->ipcp, r, d1, d2);
> >  }
> >  =

> > +void g_at_ppp_set_acfc_enabled(GAtPPP *ppp)
> =

> I really do want the signature to be g_at_ppp_set_acfc_enabled(GAtPPP
> *ppp, gboolean enabled)
> =

> There are cases where we might re-use the PPP object with different
> parameters.

what is wrong with just g_at_ppp_set_acfc(GAtPPP *ppp, gboolean enabled)
as function name. Duplicating enabled in the function name and as
parameter seems to be bit odd.

Regards

Marcel



--===============5761916999179739067==--

