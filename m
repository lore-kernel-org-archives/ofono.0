Content-Type: multipart/mixed; boundary="===============0993019070054781634=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 11/23] struct tx_queue_entry: add fields and destructor
Date: Mon, 12 Jul 2010 13:17:00 -0700
Message-ID: <1278965820.2327.174.camel@localhost.localdomain>
In-Reply-To: <4C350E91.4070304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0993019070054781634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-07-07 at 16:32 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 07/07/2010 06:24 PM, Inaky Perez-Gonzalez wrote:
> > On Wed, 2010-07-07 at 16:04 -0700, Denis Kenzior wrote: =

> >> Hi Inaky,
> >>
> >> <snip>
> >>
> >> ....
> > =

> >>>  	if (sms->txq) {
> >>> -		g_queue_foreach(sms->txq, (GFunc)g_free, NULL);
> >>> +		g_queue_foreach(sms->txq, tx_queue_entry_destroy_free, NULL);
> >>>  		g_queue_free(sms->txq);
> >>>  		sms->txq =3D NULL;
> >>>  	}
> >>
> >> Can we simply unify the two functions and simply call it
> >> tx_queue_entry_free?  For symmetry renaming create_tx_queue_entry to
> >> tx_queue_entry_new would be nice.
> > =

> > Makes sense -- thought it cannot be done, but I realized
> > sms_msg_cancel() needs a _destroy_free(), not just a _destroy(), so that
> > settles that last one. Will do the _create() rename too. =

> =

> Good, can you resubmit this one separately soonish?  I'm touching this
> area of the code because of Andrew's changes for STK Send SMS command
> handling.

Sigh, your changes broke havoc on mine, as they completely change the
code flow. I started trying to integrate Friday after giving up on that
rebase (or not) issue and just applying commits as patches, but it is
almost like starting from scratch. =


Heads up, this means I'll have to retest the heck out of it and yet
another delay once I figure out how to reshape everything for the new
code flow. =



--===============0993019070054781634==--

