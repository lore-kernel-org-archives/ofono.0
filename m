Content-Type: multipart/mixed; boundary="===============6832556712235071726=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/3] sms: store pending tx pdus on disk
Date: Tue, 07 Dec 2010 15:26:42 +0200
Message-ID: <AANLkTin0HoaaTN_7K5QsCoS=-jL0yQMWc1R41T6fF=Ab@mail.gmail.com>
In-Reply-To: <1290639202-12221-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6832556712235071726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

2010/11/25 Kristen Carlson Accardi <kristen@linux.intel.com>:
> @@ -1923,6 +1928,8 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, G=
SList *list,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sms->ref =3D sms->ref + 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 entry->id =3D tx_counter++;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_queue_push_tail(sms->txq, entry);

Can't you use g_queue_get_length() here to get the position of the
newly pushed entry? That would make tx_counter unnecessary (and
anyway, it should probably be internal to each sms atom data instead
of a static variable).

> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (g_queue_get_length(sms->txq) =3D=3D 1)
> @@ -1931,6 +1938,16 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, =
GSList *list,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (uuid)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(uuid, &entr=
y->uuid, sizeof(*uuid));
>
> + =C2=A0 =C2=A0 =C2=A0 i =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (l =3D list; l; l =3D l->next) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sms *s =3D l->d=
ata;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sms_tx_store(sms->imsi=
, entry->id,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_uuid_to_str(&entry->uuid),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s, i);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cb(sms, &entry->uu=
id, data);
>
> diff --git a/src/smsutil.c b/src/smsutil.c
> index e6dbf5f..4904419 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -48,6 +48,10 @@
> =C2=A0#define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
> =C2=A0#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH "/%s-%s"
>
> +#define SMS_TX_BACKUP_PATH STORAGEDIR "/%s/tx_queue"
> +#define SMS_TX_BACKUP_PATH_DIR SMS_TX_BACKUP_PATH "/%lu-%s"
> +#define SMS_TX_BACKUP_PATH_FILE SMS_TX_BACKUP_PATH_DIR "/%03i"
> +
> =C2=A0#define SMS_ADDR_FMT "%24[0-9A-F]"
> =C2=A0#define SMS_MSGID_FMT "%40[0-9A-F]"
>
> @@ -3125,6 +3129,28 @@ void status_report_assembly_expire(struct status_r=
eport_assembly *assembly,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> +gboolean sms_tx_store(const char *imsi, unsigned long id, const char *uu=
id,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct sms *s, guint8 seq)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int len;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char buf[177];
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!imsi)

Need to explicitly compare to NULL here. A recently added convention, I adm=
it.

Cheers,
Aki

--===============6832556712235071726==--

