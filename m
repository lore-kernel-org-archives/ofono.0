Content-Type: multipart/mixed; boundary="===============2612210613116360242=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [SMS D-Bus 02/19] sms: introduce message ID API
Date: Thu, 05 Aug 2010 10:18:39 -0700
Message-ID: <1281028719.19261.82.camel@localhost.localdomain>
In-Reply-To: <4C5AF075.4090109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2612210613116360242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-08-05 at 12:10 -0500, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 08/03/2010 06:50 PM, Inaky Perez-Gonzalez wrote:
> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > This adds a simple API to use for generating unique IDs for SMS
> > messages. Will be used by follow up commits.
> > =

> > The ID is not generic, but specifc to SMS messages (due to having to
> > dig inside 'struct sms') and thus generates directly 16-bit IDs.
> > ---
> >  src/smsutil.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  src/smsutil.h |    2 +
> >  2 files changed, 80 insertions(+), 0 deletions(-)
> > =

> > diff --git a/src/smsutil.c b/src/smsutil.c
> > index 22c70cf..b958ee0 100644
> > --- a/src/smsutil.c
> > +++ b/src/smsutil.c
> > @@ -3983,3 +3983,81 @@ char *ussd_decode(int dcs, int len, const unsign=
ed char *data)
> >  =

> >  	return utf8;
> >  }
> > +
> > +static
> > +int __sms_uuid_from_pdu(GChecksum *checksum, const struct sms *sms_pdu)
> =

> Since this is a static function, it is preferable not to prefix it with __

Will do

> > +{
> > +	const guint8 *buf;
> > +	size_t buf_len;
> > +
> > +	switch (sms_pdu->type) {
> > +	case SMS_TYPE_DELIVER:
> > +		buf =3D sms_pdu->deliver.ud;
> > +		buf_len =3D sms_pdu->deliver.udl;
> > +		break;
> > +	case SMS_TYPE_DELIVER_REPORT_ACK:
> > +		buf =3D sms_pdu->deliver_ack_report.ud;
> > +		buf_len =3D sms_pdu->deliver_ack_report.udl;
> > +		break;
> > +	case SMS_TYPE_DELIVER_REPORT_ERROR:
> > +		buf =3D sms_pdu->deliver_err_report.ud;
> > +		buf_len =3D sms_pdu->deliver_err_report.udl;
> > +		break;
> > +	case SMS_TYPE_STATUS_REPORT:
> > +		buf =3D sms_pdu->status_report.ud;
> > +		buf_len =3D sms_pdu->status_report.udl;
> > +		break;
> > +	case SMS_TYPE_SUBMIT:
> > +		buf =3D sms_pdu->submit.ud;
> > +		buf_len =3D sms_pdu->submit.udl;
> > +		break;
> > +	case SMS_TYPE_SUBMIT_REPORT_ACK:
> > +		buf =3D sms_pdu->submit_ack_report.ud;
> > +		buf_len =3D sms_pdu->submit_ack_report.udl;
> > +		break;
> > +	case SMS_TYPE_SUBMIT_REPORT_ERROR:
> > +		buf =3D sms_pdu->submit_err_report.ud;
> > +		buf_len =3D sms_pdu->submit_err_report.udl;
> > +		break;
> > +	case SMS_TYPE_COMMAND:
> > +		buf =3D sms_pdu->command.cd;
> > +		buf_len =3D sms_pdu->command.cdl;
> > +		break;
> =

> This part is wrong, the user-data (ud) is not the entirety of the PDU.
> It is just the message payload.  Hashing over it only is not enough.

So which other fields for each type in the union are to be taken into
account?

From our discussions, I was under the impression that we wanted to hash
only on the contents of the message and destination -- this actually led
to the problem of the same sender and data issue below...[more on it
below].

> > +	default:
> > +		return 1;
> =

> You might want to make this function return TRUE/FALSE...

Ok =


> > +	}
> > +	g_checksum_update(checksum, buf, buf_len);
> =

> An empty line before g_checksum_update()

k

> > +	return 0;
> > +}
> > +
> > +/**
> > + * Generate a UUID from an SMS PDU List
> > + *
> > + * @param sms_pdu_list GSlist containing 'struct sms' nodes to
> > + *     generate the UUID from.
> > + * @return 0 in error (no memory or serious code inconsistency in the
> > + *     input data structures), otherwise the SMS UUID.
> > + */
> > +guint16 sms_uuid_from_pdu_list(const GSList *sms_pdu_list)
> > +{
> > +	guint16 uuid =3D 0;
> > +	GChecksum *checksum;
> > +	const GSList *node;
> > +	gsize uuid_size =3D g_checksum_type_get_length(G_CHECKSUM_SHA256);
> > +	guint8 data[uuid_size];
> > +
> > +	checksum =3D g_checksum_new(G_CHECKSUM_SHA256);
> > +	if (checksum =3D=3D NULL)
> > +		goto error_new;
> > +	for (node =3D sms_pdu_list; node; node =3D node->next) {
> > +		struct sms *sms_pdu =3D node->data;
> > +		if (__sms_uuid_from_pdu(checksum, sms_pdu))
> > +			goto error_pdu;
> > +	}
> > +	g_checksum_get_digest(checksum, data, &uuid_size);
> > +	uuid =3D data[0] | data[1] << 8;
> =

> The current message id is 32 bits.  Why are we stopping at 16?  We could
> go all the way to 64 if needed...

Well, at the end what gets sent to the network is 16 bits right?

> Also, we need to take time and some random value into account.  Perhaps
> including time() output and a simple static counter into the hashing
> function would make it unique for those 'same sender, same contents
> messages'

So then we really don't care about being able to regenerate the hash ID
from the contents?

The design discussions we held about this involved being able to, with
the content of the message and destination number, generating a hash
that could be uniquely reproduced by rehashing it again. You had a
reason for it and I can't remember which one it was -- I should have
written it down. But that brought the problem of 'somebody sending the
same message to the same number' which yields the same ID.

However, if to fix that we are adding randomness in the form of time(),
why bother with the contents? let's just do a random ID from the ground
up and save us the pain of hashing.


--===============2612210613116360242==--

