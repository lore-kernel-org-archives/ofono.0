Content-Type: multipart/mixed; boundary="===============9116584475214341361=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [PATCH v3 2/2] huawei: add gprs context
Date: Tue, 10 Aug 2010 21:56:30 -0700
Message-ID: <1281502590.9561.141.camel@localhost.localdomain>
In-Reply-To: <87hbj8urpr.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9116584475214341361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-08-06 at 10:26 +0300, Kalle Valo wrote: =

> Inaky Perez-Gonzalez <inaky@linux.intel.com> writes:
> =

> > Hi Kale
> =

> Hola,
> =

> > On Thu, 2010-08-05 at 08:54 +0300, Kalle Valo wrote: =

> >>
> >> This is my setup:
> >> =

> >> ; from linux/Documentation/CodingStyle
> >> (defun c-lineup-arglist-tabs-only (ignored)
> >>   "Line up argument lists by tabs, not spaces"
> >>   (let* ((anchor (c-langelem-pos c-syntactic-element))
> >> 	 (column (c-langelem-2nd-pos c-syntactic-element))
> >> 	 (offset (- (1+ column) anchor))
> >> 	 (steps (floor offset c-basic-offset)))
> >>     (* (max steps 1)
> >>        c-basic-offset)))
> >
> > Thanks! Phew ... this is a handful of lisp! I don't understand anything
> > that is not basic anymore :)
> =

> It sure is. I just copied it from Linux CodingStyle document and it
> seems to work somehow.
> =

> > -- I gave it a whiz and one thing I saw was that
> >
> > struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
> > 						GSList *list,
> > 						unsigned int flags, unsigned msg_id,
> > 						ofono_sms_msg_stch_cb_t stch_cb,
> > 						void *data, ofono_destroy_func destroy)
> >
> > is being formatted as:
> >
> > struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
> > 					GSList *list,
> > 					unsigned int flags, unsigned msg_id,
> > 					ofono_sms_msg_stch_cb_t stch_cb,
> > 					void *data, ofono_destroy_func destroy)
> >
> > ie: one c-basic-offset less than it should -- I really can't figure out=
 where to poke.
> =

> That's my problem as well. Currently I just manually add one more tab to
> each line with M-i. If you find a way to fix this, please let me know.

I think I found it, seems to cut it; replace:

(steps (floor offset c-basic-offset)))

with

         (steps (floor (+ offset (- c-basic-offset 1)) c-basic-offset)))

Lisp nuts me out, but it is doing the:

steps =3D floor(offset/c-basic-offset);

with

steps =3D floor((offset + c-basic-offset - 1) / c-basic-offset);

thus making sure there is always one more tab except when the offset is
right on a tab boundary that we keep the same.

So far, so good -- probably it fails in some case, because this is
totally trial and error as unscientific as it can :)



--===============9116584475214341361==--

