Content-Type: multipart/mixed; boundary="===============3989994410794768154=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [RFC patches 07/13] write_file: make transaction-safe
Date: Tue, 08 Jun 2010 22:38:48 +0000
Message-ID: <1276036994.2478.63.camel@localhost.localdomain>
In-Reply-To: <201005280943.47503.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3989994410794768154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-05-28 at 07:43 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > write_file(), as written wasn't transaction-safe; a crash bewtween a
> > file being open and the buffer being written before a safe close would
> > leave the file with a set of undetermined contents.
> > =

> > Modified to the file is written to a temporary file name; once
> > completed, it is renamed to the final name. This way, a crash in the
> > middle doesn't leave half-baked files.
> > +	/* Now that the file contents are written, rename to the real
> > +	 * file name; this way we are uniquely sure that the whole
> > +	 * thing is there. */
> =

> Again, prefer multiline comments to be in a certain format

I'll fix this and resubmit.

> > +	unlink(path);
> > +	/* conserve @r's value from 'write' */
> > +	if (link(tmp_path, path) =3D=3D -1)
> > +		r =3D -1;
> > +error_write:
> > +	unlink(tmp_path);
> > +error_mkstemp_full:
> > +error_create_dirs:
> > +	g_free(tmp_path);
> >  	g_free(path);
> >  	return r;
> >  }
> > =

> =

> And I get trouble applying your patch:
> Applying: write_file: make transaction-safe
> /home/denkenz/ofono-master/.git/rebase-apply/patch:13: trailing whitespac=
e.
> /* =

> /home/denkenz/ofono-master/.git/rebase-apply/patch:22: trailing whitespac=
e.
>  */ =

> /home/denkenz/ofono-master/.git/rebase-apply/patch:75: trailing whitespac=
e.

Ops, my bad. Ditto, I'll fix and resubmit.



--===============3989994410794768154==--

