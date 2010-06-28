Content-Type: multipart/mixed; boundary="===============4858793146779212693=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 02/23] util.h: Add BUILD_BUG_ON() and friends for
 compile-time assert checking
Date: Mon, 28 Jun 2010 09:49:52 -0700
Message-ID: <1277743792.3006.1.camel@localhost.localdomain>
In-Reply-To: <1277509604.2330.144.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4858793146779212693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hey Marcel

On Fri, 2010-06-25 at 16:46 -0700, Marcel Holtmann wrote: =

> Hi Inaky,
> =

> > These have been stolen from the Linux kernel source; come pretty handy
> > to make build-time consistency checks and thus avoid run-time
> > surprises.
> > ---
> >  src/util.h |   28 ++++++++++++++++++++++++++++
> >  1 files changed, 28 insertions(+), 0 deletions(-)
> =

> I still think that using include/bug.h is way better. And that way we
> could more easily sync this with ConnMan. Since this might come in handy
> for ConnMan as well.

I don't have a problem with it, but I am still waiting for Denis' take
on it.


--===============4858793146779212693==--

