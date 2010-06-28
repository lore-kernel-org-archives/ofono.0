Content-Type: multipart/mixed; boundary="===============0717008828990708450=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [SMS D-Bus 03/23] smutil.h: add missing header file dependencies
Date: Mon, 28 Jun 2010 09:52:24 -0700
Message-ID: <1277743944.3006.2.camel@localhost.localdomain>
In-Reply-To: <1277509709.2330.146.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0717008828990708450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2010-06-26 at 01:48 +0200, Marcel Holtmann wrote: =

> Hi Inaky,
> =

> >  src/smsutil.h |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> > =

> > diff --git a/src/smsutil.h b/src/smsutil.h
> > index 66ef6f8..baa3eca 100644
> > --- a/src/smsutil.h
> > +++ b/src/smsutil.h
> > @@ -18,6 +18,14 @@
> >   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1=
301  USA
> >   *
> >   */
> > +#ifndef __smsutil_h__
> > +#define __smsutil_h__
> =

> for internal headers I don't want the circular inclusion protection. It
> buys us nothing. And leaving it out will warn us when we do circular
> inclusion. That is a clear indication that something is a bit too
> complicated if it is needed.

Yeah, I just forgot to drop it.



--===============0717008828990708450==--

