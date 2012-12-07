Content-Type: multipart/mixed; boundary="===============1770039781858637327=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/1] telit: stay 'online' until POST_SIM state reached
Date: Fri, 07 Dec 2012 07:22:33 +0100
Message-ID: <1354861353.2781.84.camel@jerome.southpole.se>
In-Reply-To: <50BEE1DB.10905@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1770039781858637327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 2012-12-04 at 23:55 -0600, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 12/04/2012 09:46 AM, Jonas Bonn wrote:
> > In offline state where CFUN=3D4, the Telit HE910 also powers down the S=
IM
> > card so AT commands that query the SIM will fail.  These failures result
> > in ofono not getting to POST_SIM state where it will export the GPRS
> > feature.

> =

> Does the HE910 have a proper CFUN mode where it does not turn off the =

> SIM?  You are making some nasty hacks because of it, and the other Telit =

> devices support this just fine.

No, the HE910 supports CFUN modes 0,1,4,5,7 where:
1: online
4: offline (airplane) mode with SIM powered off
0,5,7: online w/ power saving modes; SMS and phone calls are active in
these modes, but AT command handling seems to be turned off

See Telit Modules Software User Guide, 1vv0300784 rev 11, 2012-09-20,
section 3.6 (page 105) for a description of these modes.

> =

> >
> > This patch changes the Telit driver so it will not go immediately
> > to CFUN=3D4 after enable, but to wait for the post_sim state to be
> > reached before doing so.  In addition, the HE910 might send QSS: 0
> > unsolicited reports while in CFUN=3D4 state... this patch makes it so
> > that these are ignored until the modem is onlined and the actual
> > SIM state can be queried again.
> =

> Also remember the modem can be 'Online' even without a SIM, or in =

> pre-SIM state for e.g. emergency calls.  So much of the logic might break.

OK, I need to check what CFUN mode we need in order to be able to make
emergency calls.  I think 4 won't work... CFUN=3D4 is really 'airplane
mode' with antennas off.

My interpretation of modem 'enabled' in ofono is that it's 'airplane
mode'... is this not correct?

/Jonas


--===============1770039781858637327==--

