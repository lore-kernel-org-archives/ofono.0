Content-Type: multipart/mixed; boundary="===============4049466629717159413=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 12/20] struct tx_queue_entry: add a destructor
Date: Mon, 26 Jul 2010 13:49:08 -0700
Message-ID: <1280177348.26204.177.camel@localhost.localdomain>
In-Reply-To: <4C4A2089.7030804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4049466629717159413==
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
> tx_queue_entry * here.  Casting the destructor in g_foo_foreach is
> acceptable.

Renamed to tx_queue_entry_destroy() -- kept destroy vs free, as it has a
clearer meaning as to what the function does.

> > +{
> > +	struct tx_queue_entry *entry =3D _entry;
> > +
> > +	if (entry->destroy)
> > +		entry->destroy(entry->data);
> =

> An empty line after if/while/for blocks please.  I will update the
> coding-style document with this rule shortly.

Done.



--===============4049466629717159413==--

