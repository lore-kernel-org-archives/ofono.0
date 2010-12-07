Content-Type: multipart/mixed; boundary="===============3374962340595973274=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] sms: delete sent sms messages from backup
Date: Mon, 06 Dec 2010 20:31:00 -0600
Message-ID: <4CFD9C64.2030609@gmail.com>
In-Reply-To: <1290639202-12221-3-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3374962340595973274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 11/24/2010 04:53 PM, Kristen Carlson Accardi wrote:
> ---
>  src/sms.c     |    9 +++++++++
>  src/smsutil.c |   38 ++++++++++++++++++++++++++++++++++++++
>  src/smsutil.h |    4 ++++
>  3 files changed, 51 insertions(+), 0 deletions(-)
> =

> diff --git a/src/sms.c b/src/sms.c
> index 6eab0fa..f987946 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -769,6 +769,10 @@ static void tx_finished(const struct ofono_error *er=
ror, int mr, void *data)
>  		goto next_q;
>  	}
>  =

> +	sms_tx_backup_remove(sms->imsi, entry->id,
> +				ofono_uuid_to_str(&entry->uuid),
> +				entry->cur_pdu);
> +
>  	entry->cur_pdu +=3D 1;
>  	entry->retry =3D 0;
>  =

> @@ -813,8 +817,13 @@ next_q:
>  		message_set_state(sms, &entry->uuid, ms);
>  	}
>  =

> +	sms_tx_backup_destroy(sms->imsi, entry->id,
> +			ofono_uuid_to_str(&entry->uuid));
> +
>  	tx_queue_entry_destroy(entry);
>  =

> +	tx_counter--;
> +

I'm not sure this is going to work, e.g. start with tx_counter =3D=3D 0:

Queue -> tx_counter =3D 1, id =3D 0
Queue -> tx_counter =3D 2, id =3D 1,
Queue -> tx_counter =3D 3, id =3D 2,

Sent -> tx_counter =3D 2, (id of 0 sent)

Queue -> tx_counter =3D 3, id =3D 2

Now you have two messages with the same id and lost all guarantees on
the order...

Perhaps simply relying on always increasing tx_counter might be enough.
 It is unlikely anyone will ever send 4 billion SMSes ;)  Renaming the
directory during the restore operation might be an option as well.

>  	if (g_queue_peek_head(sms->txq)) {
>  		DBG("Scheduling next");
>  		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
> diff --git a/src/smsutil.c b/src/smsutil.c
> index 4904419..7a6b70a 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -3151,6 +3151,44 @@ gboolean sms_tx_store(const char *imsi, unsigned l=
ong id, const char *uuid,
>  	return TRUE;
>  }
>  =

> +void sms_tx_backup_destroy(const char *imsi, unsigned long id, const cha=
r *uuid)

The existing code tends to name this foo_backup_free rather than
backup_destroy.

> +{
> +	char *path;
> +	struct dirent **entries;
> +	int len;
> +
> +	path =3D g_strdup_printf(SMS_TX_BACKUP_PATH_DIR,
> +					imsi, id, uuid);
> +
> +	len =3D scandir(path, &entries, NULL, versionsort);

Rule M1 please

> +	while (len--) {
> +		struct dirent *dir =3D entries[len];
> +		char *file =3D g_strdup_printf("%s/%s", path, dir->d_name);
> +
> +		unlink(file);
> +
> +		g_free(file);
> +		g_free(entries[len]);
> +	}

Rule M1 please

> +	g_free(entries);
> +
> +	rmdir(path);
> +
> +	g_free(path);
> +}
> +
> +void sms_tx_backup_remove(const char *imsi, unsigned long id, const char=
 *uuid,
> +				guint8 seq)
> +{
> +	char *path;
> +
> +	path =3D g_strdup_printf(SMS_TX_BACKUP_PATH_FILE,
> +					imsi, id, uuid, seq);
> +	unlink(path);
> +
> +	g_free(path);
> +}
> +
>  static inline GSList *sms_list_append(GSList *l, const struct sms *in)
>  {
>  	struct sms *sms;
> diff --git a/src/smsutil.h b/src/smsutil.h
> index 5279489..2e2bae6 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -518,6 +518,10 @@ void status_report_assembly_expire(struct status_rep=
ort_assembly *assembly,
>  =

>  gboolean sms_tx_store(const char *imsi, unsigned long id, const char *uu=
id,
>  				struct sms *s, guint8 seq);
> +void sms_tx_backup_remove(const char *imsi, unsigned long id, const char=
 *uuid,
> +				guint8 seq);
> +void sms_tx_backup_destroy(const char *imsi, unsigned long id,
> +				const char *uuid);
>  =

>  GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
>  				gboolean use_16bit,

Regards,
-Denis

--===============3374962340595973274==--

