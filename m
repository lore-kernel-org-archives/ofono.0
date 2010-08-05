Content-Type: multipart/mixed; boundary="===============0141519216052628719=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 02/19] sms: introduce message ID API
Date: Thu, 05 Aug 2010 12:10:13 -0500
Message-ID: <4C5AF075.4090109@gmail.com>
In-Reply-To: <bd8631bab66aae8b4ac756782cd44fbc87116d0e.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0141519216052628719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 08/03/2010 06:50 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> This adds a simple API to use for generating unique IDs for SMS
> messages. Will be used by follow up commits.
> =

> The ID is not generic, but specifc to SMS messages (due to having to
> dig inside 'struct sms') and thus generates directly 16-bit IDs.
> ---
>  src/smsutil.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/smsutil.h |    2 +
>  2 files changed, 80 insertions(+), 0 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index 22c70cf..b958ee0 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -3983,3 +3983,81 @@ char *ussd_decode(int dcs, int len, const unsigned=
 char *data)
>  =

>  	return utf8;
>  }
> +
> +static
> +int __sms_uuid_from_pdu(GChecksum *checksum, const struct sms *sms_pdu)

Since this is a static function, it is preferable not to prefix it with __

> +{
> +	const guint8 *buf;
> +	size_t buf_len;
> +
> +	switch (sms_pdu->type) {
> +	case SMS_TYPE_DELIVER:
> +		buf =3D sms_pdu->deliver.ud;
> +		buf_len =3D sms_pdu->deliver.udl;
> +		break;
> +	case SMS_TYPE_DELIVER_REPORT_ACK:
> +		buf =3D sms_pdu->deliver_ack_report.ud;
> +		buf_len =3D sms_pdu->deliver_ack_report.udl;
> +		break;
> +	case SMS_TYPE_DELIVER_REPORT_ERROR:
> +		buf =3D sms_pdu->deliver_err_report.ud;
> +		buf_len =3D sms_pdu->deliver_err_report.udl;
> +		break;
> +	case SMS_TYPE_STATUS_REPORT:
> +		buf =3D sms_pdu->status_report.ud;
> +		buf_len =3D sms_pdu->status_report.udl;
> +		break;
> +	case SMS_TYPE_SUBMIT:
> +		buf =3D sms_pdu->submit.ud;
> +		buf_len =3D sms_pdu->submit.udl;
> +		break;
> +	case SMS_TYPE_SUBMIT_REPORT_ACK:
> +		buf =3D sms_pdu->submit_ack_report.ud;
> +		buf_len =3D sms_pdu->submit_ack_report.udl;
> +		break;
> +	case SMS_TYPE_SUBMIT_REPORT_ERROR:
> +		buf =3D sms_pdu->submit_err_report.ud;
> +		buf_len =3D sms_pdu->submit_err_report.udl;
> +		break;
> +	case SMS_TYPE_COMMAND:
> +		buf =3D sms_pdu->command.cd;
> +		buf_len =3D sms_pdu->command.cdl;
> +		break;

This part is wrong, the user-data (ud) is not the entirety of the PDU.
It is just the message payload.  Hashing over it only is not enough.

> +	default:
> +		return 1;

You might want to make this function return TRUE/FALSE...

> +	}
> +	g_checksum_update(checksum, buf, buf_len);

An empty line before g_checksum_update()
> +	return 0;
> +}
> +
> +/**
> + * Generate a UUID from an SMS PDU List
> + *
> + * @param sms_pdu_list GSlist containing 'struct sms' nodes to
> + *     generate the UUID from.
> + * @return 0 in error (no memory or serious code inconsistency in the
> + *     input data structures), otherwise the SMS UUID.
> + */
> +guint16 sms_uuid_from_pdu_list(const GSList *sms_pdu_list)
> +{
> +	guint16 uuid =3D 0;
> +	GChecksum *checksum;
> +	const GSList *node;
> +	gsize uuid_size =3D g_checksum_type_get_length(G_CHECKSUM_SHA256);
> +	guint8 data[uuid_size];
> +
> +	checksum =3D g_checksum_new(G_CHECKSUM_SHA256);
> +	if (checksum =3D=3D NULL)
> +		goto error_new;
> +	for (node =3D sms_pdu_list; node; node =3D node->next) {
> +		struct sms *sms_pdu =3D node->data;
> +		if (__sms_uuid_from_pdu(checksum, sms_pdu))
> +			goto error_pdu;
> +	}
> +	g_checksum_get_digest(checksum, data, &uuid_size);
> +	uuid =3D data[0] | data[1] << 8;

The current message id is 32 bits.  Why are we stopping@16?  We could
go all the way to 64 if needed...

Also, we need to take time and some random value into account.  Perhaps
including time() output and a simple static counter into the hashing
function would make it unique for those 'same sender, same contents
messages'

> +error_pdu:
> +	g_checksum_free(checksum);
> +error_new:
> +	return uuid;
> +}
> diff --git a/src/smsutil.h b/src/smsutil.h
> index ca64b18..66486b7 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -547,3 +547,5 @@ GSList *cbs_optimize_ranges(GSList *ranges);
>  gboolean cbs_topic_in_range(unsigned int topic, GSList *ranges);
>  =

>  char *ussd_decode(int dcs, int len, const unsigned char *data);
> +
> +guint16 sms_uuid_from_pdu_list(const GSList *sms_pdu_list);

Regards,
-Denis

--===============0141519216052628719==--

