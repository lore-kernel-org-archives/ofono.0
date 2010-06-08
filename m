Content-Type: multipart/mixed; boundary="===============1377910617206562527=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [RFC patches 06/13] smutil.h: add missing header file dependencies
Date: Tue, 08 Jun 2010 22:04:40 +0000
Message-ID: <1276034947.2478.44.camel@localhost.localdomain>
In-Reply-To: <1275056356.4706.78.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1377910617206562527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-05-28 at 07:19 -0700, Marcel Holtmann wrote: =

> Hi Inaky,
> =

> > diff --git a/src/smsutil.h b/src/smsutil.h
> > index 469a49e..356ec5d 100644
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

> please leave the circular dependency protection out here. I really want
> it to fail if we go so crazy and would require it.

I personally NAK here, but if you guys don't like it, I'll just drop
this guy from the series. Not that critical.



--===============1377910617206562527==--

