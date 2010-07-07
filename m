Content-Type: multipart/mixed; boundary="===============5173587488741234172=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 11/23] struct tx_queue_entry: add fields and destructor
Date: Wed, 07 Jul 2010 18:04:48 -0500
Message-ID: <4C350810.6060203@gmail.com>
In-Reply-To: <fe704ca9ffff079649a522ab344d0318a9e4b879.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5173587488741234172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

<snip>

> +
> +/*
> + * Destroy/release the contents of a 'struct tx_queue_entry'
> + *
> + * This *only* releases resources allocated *inside* @entry. The
> + * caller still has to explicitly free @entry (if needed) itself.
> + */
> +static void tx_queue_entry_destroy(struct tx_queue_entry *entry)
> +{
> +	g_free(entry->pdus);
> +}
> +
> +static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unused)
> +{
> +	struct tx_queue_entry *entry =3D _entry;
> +	tx_queue_entry_destroy(entry);
> +	g_free(entry);
> +}
> +

>  static void tx_finished(const struct ofono_error *error, int mr, void *d=
ata)
>  {
>  	struct ofono_sms *sms =3D data;
> @@ -320,7 +340,7 @@ static void tx_finished(const struct ofono_error *err=
or, int mr, void *data)
>  					time(NULL),
>  					OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED);
>  =

> -		g_free(entry->pdus);
> +		tx_queue_entry_destroy(entry);
>  		g_free(entry);

It seems we can use tx_queue_entry_destroy_free here...

>  =

>  		if (g_queue_peek_head(sms->txq)) {
> @@ -353,7 +373,7 @@ static void tx_finished(const struct ofono_error *err=
or, int mr, void *data)
>  					time(NULL),
>  					OFONO_HISTORY_SMS_STATUS_SUBMITTED);
>  =

> -	g_free(entry->pdus);
> +	tx_queue_entry_destroy(entry);
>  	g_free(entry);

Same comment as above.

>  =

>  	if (g_queue_peek_head(sms->txq)) {
> @@ -987,7 +1007,7 @@ static void sms_remove(struct ofono_atom *atom)
>  	}
>  =

>  	if (sms->txq) {
> -		g_queue_foreach(sms->txq, (GFunc)g_free, NULL);
> +		g_queue_foreach(sms->txq, tx_queue_entry_destroy_free, NULL);
>  		g_queue_free(sms->txq);
>  		sms->txq =3D NULL;
>  	}

Can we simply unify the two functions and simply call it
tx_queue_entry_free?  For symmetry renaming create_tx_queue_entry to
tx_queue_entry_new would be nice.

Regards,
-Denis

--===============5173587488741234172==--

