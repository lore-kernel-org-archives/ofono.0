Content-Type: multipart/mixed; boundary="===============2514653453531727978=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 0/5] ppp: error path fixes
Date: Fri, 26 Mar 2010 21:39:17 -0700
Message-ID: <20100326213917.3c464d64@kcaccard-MOBL3>
In-Reply-To: <1269656940.11714.190.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2514653453531727978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Mar 2010 19:29:00 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Kristen,
> =

> > Here are some patches which fix some issues with the error paths in
> > the PPP control protocol code.
> > =

> > Kristen Carlson Accardi (5):
> >   ppp: fix segfault in pppcp_send_code_reject()
> >   ppp: comment fix
> >   ppp: send Protocol-Reject
> >   ppp: use common code to get options from pppcp packet data
> >   ppp: handle Config-Reject
> > =

> >  gatchat/ppp.c     |   29 ++++++---
> >  gatchat/ppp.h     |    1 +
> >  gatchat/ppp_cp.c  |  179 +++++++++++++++++++++++++++++++++++++++------=
-------
> >  gatchat/ppp_cp.h  |    2 +
> >  gatchat/ppp_lcp.c |    5 ++
> >  5 files changed, 161 insertions(+), 55 deletions(-)
> =

> all five patches have been applied.
> =

> Also I pushed the support for NBNS options upstream. With these changes
> I don't see the endless loop anymore.

Great, I'm glad that worked.

> =

> Problem is still that we can't leave the CHAP secrets empty. For
> networks where the username and password are not in use, we should be
> able to leave them empty.

Even after applying the auth patches I sent yesterday?  I was able to
duplicate this problem and the patches I sent yesterday fixed it.  But
since you asked for a resend, maybe you tested without apply the right
patch first?  Let me know if this problem is resolved for you, or if
you are still having an issue.

--===============2514653453531727978==--

