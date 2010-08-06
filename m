Content-Type: multipart/mixed; boundary="===============1859631375185734286=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v3 2/2] huawei: add gprs context
Date: Fri, 06 Aug 2010 10:26:40 +0300
Message-ID: <87hbj8urpr.fsf@potku.valot.fi>
In-Reply-To: <1281029391.19261.92.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1859631375185734286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Inaky Perez-Gonzalez <inaky@linux.intel.com> writes:

> Hi Kale

Hola,

> On Thu, 2010-08-05 at 08:54 +0300, Kalle Valo wrote: =

>>
>> This is my setup:
>> =

>> ; from linux/Documentation/CodingStyle
>> (defun c-lineup-arglist-tabs-only (ignored)
>>   "Line up argument lists by tabs, not spaces"
>>   (let* ((anchor (c-langelem-pos c-syntactic-element))
>> 	 (column (c-langelem-2nd-pos c-syntactic-element))
>> 	 (offset (- (1+ column) anchor))
>> 	 (steps (floor offset c-basic-offset)))
>>     (* (max steps 1)
>>        c-basic-offset)))
>
> Thanks! Phew ... this is a handful of lisp! I don't understand anything
> that is not basic anymore :)

It sure is. I just copied it from Linux CodingStyle document and it
seems to work somehow.

> -- I gave it a whiz and one thing I saw was that
>
> struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
> 						GSList *list,
> 						unsigned int flags, unsigned msg_id,
> 						ofono_sms_msg_stch_cb_t stch_cb,
> 						void *data, ofono_destroy_func destroy)
>
> is being formatted as:
>
> struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
> 					GSList *list,
> 					unsigned int flags, unsigned msg_id,
> 					ofono_sms_msg_stch_cb_t stch_cb,
> 					void *data, ofono_destroy_func destroy)
>
> ie: one c-basic-offset less than it should -- I really can't figure out w=
here to poke.

That's my problem as well. Currently I just manually add one more tab to
each line with M-i. If you find a way to fix this, please let me know.

-- =

Kalle Valo

--===============1859631375185734286==--

