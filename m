Content-Type: multipart/mixed; boundary="===============3860673008400528697=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 07/20] SMS: implement SHA256-based message IDs [incomplete]
Date: Fri, 30 Jul 2010 17:22:16 -0700
Message-ID: <1280535736.3982.19.camel@localhost.localdomain>
In-Reply-To: <4C51F4A8.4040603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3860673008400528697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-07-29 at 14:37 -0700, Denis Kenzior wrote: =

> On 07/29/2010 04:26 PM, Inaky Perez-Gonzalez wrote:
> > On Tue, 2010-07-27 at 10:03 -0700, Denis Kenzior wrote: =

> >> Hi Inaky,
> >>
> >>> -unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *l=
ist,
> >>> -					unsigned int flags,
> >>> +struct tx_queue_entry * __ofono_sms_txq_submit(struct ofono_sms *sms=
, GSList *list,
> >>> +					unsigned int flags, unsigned ref,
> >>>  					ofono_sms_txq_submit_cb_t cb,
> >>>  					void *data, ofono_destroy_func destroy);
> >>
> >> I disagree with this, you're modifying an ofono internal API function =
to
> >> return a structure which is opaque and cannot be manipulated.  I'd
> >> rather see you returning a struct sms_uuid...
> > =

> > I need a handle to operate on. The D-Bus wrappers need something they
> > can use to dispose of the structure (call tx_queue_entry_destroy() on
> > the error path) and to pass to sms_msg_cancel(). The structure is not
> > manipulated (except for accessing the UUID and #PDUs, which should
> > probably be coded out to a helper).
> > =

> > This could be solved by having at the entry point of those functions or
> > wrappers of a lookup function that looks for the UUID in the list of
> > messages, but that would be adding more code and wasting time for no
> > benefit. I disagree on adding unnecessary steps.
> > =

> =

> I need to look at this in detail.  Can you simply grab the tx_entry from
> the back of the queue for now?

Yes, that could be done, but it is way too dirty. Assumes *a lot* of
knowledge about internal implementation details. A no-no.

>   I'm really against modifying txq_submit right now.

In any case it has to be modified to add the state change callback. =


It has only *one* user asides from the SMS code and the changes don't
impact said user negatively at all, so it shouldn't be such a big deal.




--===============3860673008400528697==--

