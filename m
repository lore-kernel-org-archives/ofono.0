Content-Type: multipart/mixed; boundary="===============0130123357509737957=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 10:28:52 -0500
Message-ID: <200909021028.52347.denkenz@gmail.com>
In-Reply-To: <a32762a20909020534r5d169e36id3ddbb981ca9d187@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0130123357509737957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > We are not going to expose Attach() or Detach() method. As explained
> > there are global anyway and so pointless to expose. This can be handled
> > in the background without bothering the higher level application with
> > these details.
>
> AFAIK, attach status of GPRS has both regulatory aspects to consider
> (some operators require always attached vs. some prohibit it) as well
> as power consumption issues (auto-attach might draw more power than
> on-demand, although there's an inverse effect on latency). These are
> issues you need to take into account, and higher layers in the stack
> definitely *need* to be aware of as well. Also, I don' t think oFono
> is the correct place for these decisions -> better expose a necessary
> API and let upper layers deal with it.

I know you guys are coming from mobile phone perspective, but that one isn'=
t =

the only scenario.  We have netbooks/laptops with gprs data cards to consid=
er =

as well.  Hardcoding operator requirements is also not an option, since SIM =

cards can be changed.

I fundamentally disagree that the logic should be in the higher layers.  oF=
ono =

has all the information to handle this, and can be hinted on what is =

appropriate behavior easily enough.  oFono should simply store the auto-att=
ach =

preferences in its IMSI-indexed preference store.  The operator can bootstr=
ap =

these preferences if required.

>
> In general, I appreciate the attempt to hide ugly details from
> applications, but unfortunately some things can't well be hidden.
> Another unrelated, but similar issue is network scanning. It just
> isn't going to work without us exposing it in the D-Bus API
> explicitly.
>

Modem drivers will have some control over whether the scan is performed =

automatically, but denying the capability for everyone is not the right thi=
ng =

to do either.

> The reason is simple, Nokia modems suspend GPRS when scanning (or
> registering), simply because the operation will take roughly three
> times as long with GPRS attached. You will find this feature in
> current phones, too.

Then ideally you should have two scan modes, periodic and user initiated.  =
For =

periodic mode we don't care how long it takes. =


Regards,
-Denis

--===============0130123357509737957==--

