Content-Type: multipart/mixed; boundary="===============2865233160556687914=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 13:37:43 -0700
Message-ID: <1251923864.1266.104.camel@localhost.localdomain>
In-Reply-To: <a32762a20909020842q1005da84s1a6816be5e103d2e@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2865233160556687914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> AFAIK, attach status of GPRS has both regulatory aspects to consider
> >> (some operators require always attached vs. some prohibit it) as well
> >> as power consumption issues (auto-attach might draw more power than
> >> on-demand, although there's an inverse effect on latency). These are
> >> issues you need to take into account, and higher layers in the stack
> >> definitely *need* to be aware of as well. Also, I don' t think oFono
> >> is the correct place for these decisions -> better expose a necessary
> >> API and let upper layers deal with it.
> >
> > I know you guys are coming from mobile phone perspective, but that one =
isn't
> > the only scenario.  We have netbooks/laptops with gprs data cards to co=
nsider
> > as well.  Hardcoding operator requirements is also not an option, since=
 SIM
> > cards can be changed.
> >
> > I fundamentally disagree that the logic should be in the higher layers.=
  oFono
> > has all the information to handle this, and can be hinted on what is
> > appropriate behavior easily enough.  oFono should simply store the auto=
-attach
> > preferences in its IMSI-indexed preference store.  The operator can boo=
tstrap
> > these preferences if required.
> =

> Operator requirements were only half of the story. You need to be able
> to disable auto-attach in low power conditions, and this logic
> definitely doesn't belong in oFono. This applies equally well to
> mobile phones as it does to laptops/netbooks.

this a different requirement. Where do you get your low power
information from? I would prefer that we add a plugin that gets informed
of this low power situation and then is able to adjust such things.

I am against exposing this in user application/UI API. I am with you
that such requirements have to be met, but not via the D-Bus API. So
these kind of policy details are device/manufacturer specific and having
a custom plugins that can be enabled by the integrator sounds best to me
if a config file is not flexible enough.

> >> In general, I appreciate the attempt to hide ugly details from
> >> applications, but unfortunately some things can't well be hidden.
> >> Another unrelated, but similar issue is network scanning. It just
> >> isn't going to work without us exposing it in the D-Bus API
> >> explicitly.
> >>
> >
> > Modem drivers will have some control over whether the scan is performed
> > automatically, but denying the capability for everyone is not the right=
 thing
> > to do either.
> =

> Agree, and I don't think that was what I was suggesting either.
> =

> >> The reason is simple, Nokia modems suspend GPRS when scanning (or
> >> registering), simply because the operation will take roughly three
> >> times as long with GPRS attached. You will find this feature in
> >> current phones, too.
> >
> > Then ideally you should have two scan modes, periodic and user initiate=
d.  For
> > periodic mode we don't care how long it takes.
> =

> +1

Sounds like a plan. So we do need an /etc/ofono/main.conf :)

Regards

Marcel



--===============2865233160556687914==--

