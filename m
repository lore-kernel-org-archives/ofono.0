Content-Type: multipart/mixed; boundary="===============2646391697565125626=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 11/23] struct tx_queue_entry: add fields and destructor
Date: Wed, 07 Jul 2010 16:24:29 -0700
Message-ID: <1278545069.2327.131.camel@localhost.localdomain>
In-Reply-To: <4C350810.6060203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2646391697565125626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-07-07 at 16:04 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> <snip>
> =

> ....

> >  	if (sms->txq) {
> > -		g_queue_foreach(sms->txq, (GFunc)g_free, NULL);
> > +		g_queue_foreach(sms->txq, tx_queue_entry_destroy_free, NULL);
> >  		g_queue_free(sms->txq);
> >  		sms->txq =3D NULL;
> >  	}
> =

> Can we simply unify the two functions and simply call it
> tx_queue_entry_free?  For symmetry renaming create_tx_queue_entry to
> tx_queue_entry_new would be nice.

Makes sense -- thought it cannot be done, but I realized
sms_msg_cancel() needs a _destroy_free(), not just a _destroy(), so that
settles that last one. Will do the _create() rename too.



--===============2646391697565125626==--

