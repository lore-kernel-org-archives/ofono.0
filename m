Content-Type: multipart/mixed; boundary="===============6177343874749886376=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] sms: restore pending tx messages from backup
Date: Mon, 06 Dec 2010 20:43:49 -0600
Message-ID: <4CFD9F65.6030104@gmail.com>
In-Reply-To: <1290639202-12221-4-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6177343874749886376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 11/24/2010 04:53 PM, Kristen Carlson Accardi wrote:
> ---
>  src/ofono.h   |    1 +
>  src/sms.c     |   38 +++++++++++++++++++
>  src/smsutil.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/smsutil.h |    6 +++
>  4 files changed, 161 insertions(+), 0 deletions(-)
> =

> diff --git a/src/ofono.h b/src/ofono.h
> index d1a4bdc..4777f70 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -241,6 +241,7 @@ enum ofono_sms_submit_flag {
>  	OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY =3D	0x2,
>  	OFONO_SMS_SUBMIT_FLAG_RETRY =3D		0x4,
>  	OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS =3D	0x8,
> +	OFONO_SMS_SUBMIT_FLAG_REUSE_UUID =3D	0x10,
>  };
>  =

>  typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
> diff --git a/src/sms.c b/src/sms.c
> index f987946..be710b1 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -1814,6 +1814,40 @@ static void bearer_init_callback(const struct ofon=
o_error *error, void *data)
>  		ofono_error("Error bootstrapping SMS Bearer Preference");
>  }
>  =

> +static void sms_restore_tx_queue(struct ofono_sms *sms)
> +{
> +	GQueue *backupq;
> +	unsigned int flags;
> +	struct txq_backup_entry *entry;
> +	struct ofono_uuid ofono_uuid;
> +
> +	DBG("");
> +
> +	flags =3D OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY;
> +	flags |=3D OFONO_SMS_SUBMIT_FLAG_RETRY;
> +	flags |=3D OFONO_SMS_SUBMIT_FLAG_REUSE_UUID;
> +
> +	if (sms->use_delivery_reports)
> +		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;

As I mentioned before, you should be restoring this information.
Assuming that it is the same for all messages on the tx queue is a
really bad idea.

> +
> +	backupq =3D sms_tx_queue_load(sms->imsi);
> +
> +	while ((entry =3D g_queue_pop_head(backupq))) {
> +		decode_hex_own_buf(entry->uuid, -1, NULL, 0, ofono_uuid.uuid);
> +
> +		__ofono_sms_txq_submit(sms, entry->msg_list, flags,
> +					&ofono_uuid, NULL, NULL);

Using sms_txq_submit is a bad idea.  This one will re-calculate the UUID
which gets tossed out later.  I suggest creating the tx_queue entries 'raw'.

> +
> +		g_slist_foreach(entry->msg_list, (GFunc)g_free, NULL);
> +		g_slist_free(entry->msg_list);
> +
> +		g_free(entry->uuid);
> +		g_free(entry);
> +	}
> +
> +	g_queue_free(backupq);
> +}
> +
>  /*
>   * Indicate oFono that a SMS driver is ready for operation
>   *

<snip>

Regards,
-Denis

--===============6177343874749886376==--

