Content-Type: multipart/mixed; boundary="===============1299054765890883776=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH] doc: Add Location Services API
Date: Fri, 26 Nov 2010 18:20:39 +0200
Message-ID: <201011261820.39167.remi.denis-courmont@nokia.com>
In-Reply-To: <129600E5E5FB004392DDC3FB599660D70104DAF2A3@irsmsx504.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1299054765890883776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 23 November 2010 01:16:00 ext Joly, Frederic, you wrote:
> I just recheck the 23.032 (Universal GeoGraphical Area Description), and =
the
> number of ways to express a position with velocity and uncertainty may not
> make the API simple. Just have a look for instance the +CMOLR's XML DTD
> location_parameters. :) Moreover, GPS vendors and other positioning
> professionals would find more logical to propose to use the WGS 84 datum
> for instance which is widely used and leave the burden to map the position
> to 3GPP style...

I am afraid with enough time and products, we will find all possible =

combinations:
- modems that only talk 27.007 XML,
- modems that only talk raw binary,
- modems that support both,
- hopeless modems that do none.

Furthermore, the data flow can go in both directions:
AT+CPOS is engine->oFono->modem, AT+CPOSR is modem->oFono->engine.

I would think that oFono needs to hide the differences between modems, whic=
h =

mean it will need to convert in some cases. Thus oFono would need to be abl=
e =

to convert both ways in any case, right? This is going to be painful. The =

alternative consists of providing a *leaky* abstraction where oFono only =

returns and accepts the format(s) that the modem understands.

With that in mind, I tend to agree that binary seems like a nicer abstracti=
on =

for the positioning engine to use than XML. But if oFono has to implement =

conversion in both direction, it might be that we can provide both formats =

over D-Bus?

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============1299054765890883776==--

