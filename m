Content-Type: multipart/mixed; boundary="===============3605019602715066479=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 12/20] struct tx_queue_entry: add a destructor
Date: Fri, 23 Jul 2010 18:06:49 -0500
Message-ID: <4C4A2089.7030804@gmail.com>
In-Reply-To: <796fef7f2a9f6c407513467dc76247ad7886fced.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3605019602715066479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> +
> +/*
> + * Destroy/release the contents of a 'struct tx_queue_entry'
> + *
> + * This releases resources allocated *inside* @entry and @entry
> + * itself.
> + */
> +static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unused)

Can't this be simply tx_queue_entry_free?  And feel free to take struct
tx_queue_entry * here.  Casting the destructor in g_foo_foreach is
acceptable.

> +{
> +	struct tx_queue_entry *entry =3D _entry;
> +
> +	if (entry->destroy)
> +		entry->destroy(entry->data);

An empty line after if/while/for blocks please.  I will update the
coding-style document with this rule shortly.

> +	g_free(entry->pdus);
> +	g_free(entry);
> +}
> +

Regards,
-Denis

--===============3605019602715066479==--

