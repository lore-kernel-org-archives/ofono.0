Content-Type: multipart/mixed; boundary="===============8695892251643041902=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 12/20] struct tx_queue_entry: add a destructor
Date: Fri, 23 Jul 2010 16:11:02 -0700
Message-ID: <1279926662.26204.142.camel@localhost.localdomain>
In-Reply-To: <4C4A2089.7030804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8695892251643041902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-23 at 16:06 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > +
> > +/*
> > + * Destroy/release the contents of a 'struct tx_queue_entry'
> > + *
> > + * This releases resources allocated *inside* @entry and @entry
> > + * itself.
> > + */
> > +static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unus=
ed)
> =

> Can't this be simply tx_queue_entry_free?  And feel free to take struct

Sure, I'll rename that.

> tx_queue_entry * here.  Casting the destructor in g_foo_foreach is
> acceptable.

Heh, I'd rather have it like this: Repeat after me in a 1000-loop: casts
are evil and should be avoided for they muck the code by hiding warnings
when you change things and miss updating all the sites ... =


> > +{
> > +	struct tx_queue_entry *entry =3D _entry;
> > +
> > +	if (entry->destroy)
> > +		entry->destroy(entry->data);
> =

> An empty line after if/while/for blocks please.  I will update the
> coding-style document with this rule shortly.

Will do, thanks


--===============8695892251643041902==--

