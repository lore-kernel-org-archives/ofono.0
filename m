Content-Type: multipart/mixed; boundary="===============8155505062119902489=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [RFC patches 04/13] sms_assembly_add_fragment_backup: clarify how
 insertion spot is found
Date: Tue, 08 Jun 2010 22:10:24 +0000
Message-ID: <1276035291.2478.50.camel@localhost.localdomain>
In-Reply-To: <201005280927.20936.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8155505062119902489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-05-28 at 07:27 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > +		/* Iterate over the bitmap to find in which position
> > +		 * should the fragment be inserted -- basically we
> > +		 * walk each bit in the bitmap until the bit we care
> > +		 * about (offset:bit) and count which are stored --
> > +		 * that gives us in which position we have to insert. */
> =

> Patch has been applied.  However please keep your commit header to 50 =

> characters or less.  Also, the preferred style for multi-line comments is:
> /* <empty line>
>  * ... comment
>  */

Ops, sorry -- I'll go fix those and provide updates for it.


--===============8155505062119902489==--

