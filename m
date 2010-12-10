Content-Type: multipart/mixed; boundary="===============5353769830640791462=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/3] Attach GPRS on demand
Date: Fri, 10 Dec 2010 09:27:13 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC030998@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <1291890453.4795.213.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5353769830640791462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

I somehow missed your other comments on this mail. More responses below.

> > Even if you can come up with an algorithm, testing it is =

> very very challenging. There are plenty of differences in =

> operator networks and it is very difficult to cover all =

> cases. Making sure that the algorithm works requires =

> extensive IOT and Field testing. We really don't want a case, =

> where oFono fails to re-attach for whatever reason. We also =

> don't want the case where oFono has not yet attempted to =

> re-attach (e.g. on a timer) and a PDP context activation =

> fails, even though GPRS would actually be available.
> =

> I don't think such an algorithm is hard. Either we are forbidden, then
> we wait until we switch to a new cell.

Mostly that would be just a waste of power. Some of the errors are PLMN or =
LA specific, so retrying at cell change would be redundant. A proper retry =
strategy would have to be based on the detach reason and any subsequent att=
ach failure causes. In general, activating the RF all the time, when no-one=
 has even requested a PDP context is simply bad idea. There are better uses=
 for the battery power.

And yes, coming up with an algorithm (whatever it is) is probably easy enou=
gh. Making sure it works with all the networks and modems out there is the =
hard part.

> Otherwise we will just retry to attach.

That's also tricky. What do you do if the attach attempt fails? Retry again=
? How often? Use some kind of backoff?

> > For the above reasons, retrying attach on PDP context =

> activation makes sense as a safe-guard, regardless of whether =

> we have a re-attach algorithm or not. We use on-demand attach =

> in pretty much all our products (except for certain operator =

> specific variants) precisely because it is certain to work. =

> No funny business. If there is GPRS service, you get a =

> connection. It is also an approach that should work with any =

> AT modem as well.
> =

> This is really not ConnMan's problem and I don't wanna make =

> it ConnMan's
> problem.
> I am really against just pushing this problem off to someone else.

No-one is proposing to. You're actually making this ConnMan's problem by mo=
nitoring the GPRS attach status. If ConnMan needs a trigger, it should be b=
ased on network registration status alone.

> And
> in ConnMan we have even less information to decide what happens when
> context activation fails.

Unfortunately, oFono cannot hide context activation failures from ConnMan. =
ConnMan will just have to cope, regardless of what we do with attach.

> The algorithm to handle such rare error
> conditions smoothly becomes more complicated than making this easier.

As far as I can see, the approach I'm proposing is simpler than the one you=
 and Denis are proposing.

> So I agree with Denis that we need to fix this inside oFono =

> and just try
> to intelligently re-attach.

As I already explained to Denis, it's not really a choise between one or th=
e other. Some opearators require autoattach, some require on-demand attach =
and some require a UI to change the mode. All of these should be supported.=
 So, by all means develop a re-attach algorith. It won't be easy to maturiz=
e, though. Using context activation requests as a triggers to retry attach =
simply makes a lot of sense as a safe-guard, even if we're in autoattach mo=
de. If anything, it removes one potential failure case.

Br,

	MikaL

--===============5353769830640791462==--

