Content-Type: multipart/mixed; boundary="===============7946477520971909528=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [SMS D-Bus 03/19] sms: implement SHA256-based message IDs
 [incomplete]
Date: Thu, 05 Aug 2010 11:17:16 -0700
Message-ID: <1281032236.19261.105.camel@localhost.localdomain>
In-Reply-To: <4C5AF2E2.2090009@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7946477520971909528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-08-05 at 12:20 -0500, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 08/03/2010 06:50 PM, Inaky Perez-Gonzalez wrote:
> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > This patch removes the sequential SMS message identification gig and
> > replaces it with a 16-bit hash cookie based off message contents.
> > =

> > FIXME: [incomplete] need to figure out how to do so that identical
> > messages sent to different or the same numbers also have a different
> > ID.
> > ---
> >  src/ofono.h |    9 +++++----
> >  src/sms.c   |   55 +++++++++++++++++++++++----------------------------=
----
> >  src/stk.c   |    5 +++--
> >  3 files changed, 31 insertions(+), 38 deletions(-)
> > =

> > diff --git a/src/ofono.h b/src/ofono.h
> > index aaa01d9..b73797b 100644
> > --- a/src/ofono.h
> > +++ b/src/ofono.h
> > @@ -185,10 +185,11 @@ enum ofono_sms_submit_flag {
> >  =

> >  typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
> >  =

> > -unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *lis=
t,
> > -					unsigned int flags,
> > -					ofono_sms_txq_submit_cb_t cb,
> > -					void *data, ofono_destroy_func destroy);
> > +struct tx_queue_entry *__ofono_sms_txq_submit(
> > +	struct ofono_sms *sms, GSList *list,
> > +	unsigned int flags, unsigned ref,
> > +	ofono_sms_txq_submit_cb_t cb,
> > +	void *data, ofono_destroy_func destroy);
> =

> As I said before, please don't mess with this function.

Once we settle on the ref / msg_id part, that one will sort out by
itself.

On later commits, the callback has to change in order to be able to
implement PropertChanged signals. Unless you have a better way to do it
that doesn't involve poking with 'struct tx_queue_entry' internals. A
helper to set the callback after the fact is another option, but it is
way dirtier.

Likewise with the return value (msg id vs the struct itself). You
suggested poking at the head of the queue upon return. That is peeking
on internals and you have adamantly (and rightfully) argued against it
in other cases.

> >  =

> >  #include <ofono/sim.h>
> >  #include <ofono/stk.h>
> > diff --git a/src/sms.c b/src/sms.c
> > index 35364db..39d4a32 100644
> > --- a/src/sms.c
> > +++ b/src/sms.c
> > @@ -55,7 +55,6 @@ struct ofono_sms {
> >  	DBusMessage *pending;
> >  	struct ofono_phone_number sca;
> >  	struct sms_assembly *assembly;
> > -	unsigned int next_msg_id;
> >  	guint ref;
> >  	GQueue *txq;
> >  	gint tx_source;
> > @@ -589,7 +588,8 @@ static DBusMessage *sms_send_message(DBusConnection=
 *conn, DBusMessage *msg,
> >  	int ref_offset;
> >  	struct ofono_modem *modem;
> >  	unsigned int flags;
> > -	unsigned int msg_id;
> > +	guint16 msg_id;
> > +	struct tx_queue_entry *sms_msg;
> >  =

> >  	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
> >  					DBUS_TYPE_STRING, &text,
> > @@ -605,24 +605,19 @@ static DBusMessage *sms_send_message(DBusConnecti=
on *conn, DBusMessage *msg,
> >  	if (!msg_list)
> >  		return __ofono_error_invalid_format(msg);
> >  =

> > -	set_ref_and_to(msg_list, sms->ref, ref_offset, to);
> > -	DBG("ref: %d, offset: %d", sms->ref, ref_offset);
> > -
> > -	if (ref_offset !=3D 0) {
> > -		if (sms->ref =3D=3D 65536)
> > -			sms->ref =3D 1;
> > -		else
> > -			sms->ref =3D sms->ref + 1;
> > -	}
> > +	msg_id =3D sms_uuid_from_pdu_list(msg_list);
> =

> You're calculating the ID before setting the ref and to? That is pretty
> silly ;)

the ref was supposed to be generated off the msg ID according to your
initial design decisions, so this is following spec. We need to clarify
this (and this touches with the other email). =


> > +	set_ref_and_to(msg_list, msg_id, ref_offset, to);
> > +	DBG("SMS ID: 0x%04x", msg_id);
> >  =

> >  	flags =3D OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY;
> >  	flags |=3D OFONO_SMS_SUBMIT_FLAG_RETRY;
> >  	if (sms->use_delivery_reports)
> >  		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;
> >  =

> > -	msg_id =3D __ofono_sms_txq_submit(sms, msg_list, flags, send_message_=
cb,
> > -						dbus_message_ref(msg),
> > -						send_message_destroy);
> > +	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags, msg_id,
> > +					 send_message_cb,
> > +					 dbus_message_ref(msg),
> > +					 send_message_destroy);
> =

> Make the ID calculation happen inside tx_queue_entry_new.  That function
> already converts all the SMS objects into a PDU.  So simply hashing the
> PDUs there would be very easy.

Ok, holding until we confirm what relationship there will be between ref
and msg_id.



--===============7946477520971909528==--

