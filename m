Content-Type: multipart/mixed; boundary="===============0195862843265490793=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: Re: [PATCH] call-forwarding: fix for showing call forwarding states
Date: Fri, 18 Mar 2011 14:53:52 +0200
Message-ID: <1300452832.2707.78.camel@jussi-desktop>
In-Reply-To: <4D82221D.3070401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0195862843265490793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2011-03-17 at 17:00 +0200, Denis Kenzior wrote:
> Hi Jussi,
> =

> >>
> >> So correct me if I'm wrong, but I don't think we can do that.  the
> >> current cf_conditions implementation stores all conditions, which could
> >> be unrelated to voice; and if my interpretation of 22.004 is correct y=
ou
> >> can have something like this:
> >>
> >> Activate CFB for all services to Number 1
> >> Activate CFU for Data services to Number 2
> >>
> >> Which results in cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] not
> >> being NULL and you reporting CFB for voice incorrectly.
> >>
> >> You are probably safer using is_cfu_enabled() function.
> > =

> > As far as I know scenario you describe cannot happen with oFono. There
> > is no data related conditions in the call forwarding API. Sure, you can
> > set data forwarding on using SS API, but I don't see how data forwarding
> > states could be shown in call forwarding API when all states in API
> > start with word "voice". Also according to comments in code fax and data
> > are not supported. =

> >
> =

> It can.  oFono stores _all_ conditions in its lists.  However, it
> filters them when reporting the conditions in get_properties or signals.
>  This is why is_cfu_enabled function looks the way it does.  So a
> scenario like this is fully possible.  Not to mention that the CFs are
> queried for all services by default.

All right. I have no access to network that would support data
forwarding or my modem does not support it so I cannot verify this in
practice. But I think problem can be avoided by changing the line =


if (cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] =3D=3D NULL) {

to =


if (!is_cfu_enabled(cf, NULL)) {

Of course little bit optimization would be good to avoid second calling
of this method later in function. Moving the setting of status variable
above these and using it when checked if UNCONDITIONAL is on instead of
is_cfu_enabled seems to be working nicely.

Br,
-Jussi



--===============0195862843265490793==--

