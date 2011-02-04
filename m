Content-Type: multipart/mixed; boundary="===============2918900230726848246=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 5/7] sms: allow message submission to be cancelled
Date: Fri, 04 Feb 2011 16:58:33 +0100
Message-ID: <AANLkTik+jiES46R4MeV6uAh3NXauump6oSGOfbV5W9JC@mail.gmail.com>
In-Reply-To: <1296831764-6554-6-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2918900230726848246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 4 February 2011 16:02, Lucas De Marchi <lucas.demarchi@profusion.mobi>=
 wrote:
> Based on patch from Yang Gu <gyagp0@gmail.com>
> ---
> =C2=A0src/sms.c | =C2=A0 82 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A01 files changed, 82 insertions(+), 0 deletions(-)
>
> diff --git a/src/sms.c b/src/sms.c
> index 7db91cb..91b0a31 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -685,6 +685,8 @@ static gboolean tx_next(gpointer user_data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|| (entry->num_pdus - entry->cur_pdu) > 1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send_mms =3D 1;
>
> + =C2=A0 =C2=A0 =C2=A0 sms->tx_state =3D MESSAGE_STATE_PENDING;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sms->driver->submit(sms, pdu->pdu, pdu->pdu_le=
n, pdu->tpdu_len,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send_mms, tx_finished, sms);
>
> @@ -970,6 +972,85 @@ static DBusMessage *sms_get_messages(DBusConnection =
*conn, DBusMessage *msg,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return reply;
> =C2=A0}
>
> +static gboolean uuid_from_message_path(const char *path,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct ofono_uuid *uuid)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const char *uuidstr;
> +
> + =C2=A0 =C2=A0 =C2=A0 uuidstr =3D path + strlen(path) - OFONO_SHA1_UUID_=
LEN * 2;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (decode_hex_own_buf(uuidstr, -1, NULL, 0, uuid-=
>uuid) =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;

I think you need to at least check that strlen(path) >=3D
OFONO_SHA1_UUID_LEN * 2 or we might segfault.

> +
> + =C2=A0 =C2=A0 =C2=A0 return TRUE;
> +}
> +
> +static gint entry_compare_by_uuid(gconstpointer a, gconstpointer b)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const struct tx_queue_entry *entry =3D a;
> + =C2=A0 =C2=A0 =C2=A0 const char *uuid =3D b;
> +
> + =C2=A0 =C2=A0 =C2=A0 return memcmp(&entry->uuid, uuid, sizeof(entry->uu=
id));
> +}
> +
> +static DBusMessage *sms_cancel_message(DBusConnection *conn, DBusMessage=
 *msg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
oid *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_sms *sms =3D data;
> + =C2=A0 =C2=A0 =C2=A0 char *path;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_uuid uuid;
> + =C2=A0 =C2=A0 =C2=A0 GList *l;
> + =C2=A0 =C2=A0 =C2=A0 struct tx_queue_entry *entry;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (sms->pending)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_b=
usy(msg);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJ=
ECT_PATH, &path,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_IN=
VALID) =3D=3D FALSE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_i=
nvalid_args(msg);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (path[0] =3D=3D '\0')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_i=
nvalid_args(msg);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (uuid_from_message_path(path, &uuid) =3D=3D FAL=
SE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_i=
nvalid_args(msg);
> +
> + =C2=A0 =C2=A0 =C2=A0 l =3D g_queue_find_custom(sms->txq, uuid.uuid, ent=
ry_compare_by_uuid);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (l =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_f=
ailed(msg);

Maybe __ofono_error_not_found?

> +
> + =C2=A0 =C2=A0 =C2=A0 entry =3D l->data;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (entry =3D=3D g_queue_peek_head(sms->txq)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Fail if any pd=
u was already transmitted or if we are
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* waiting the an=
swer from driver.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (entry->cur_pdu > 0=
 ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sms->tx_stat=
e =3D=3D MESSAGE_STATE_PENDING)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return __ofono_error_failed(msg);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Make sure we d=
on't call tx_next() if there are no entries
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and that next =
entry doesn't have to wait a 'retry time'
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* from this one.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sms->tx_source) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_source_remove(sms->tx_source);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sms->tx_source =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (g_queue_get_length(sms->txq) > 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sms->tx_source =3D g_timeout_add(0, tx_n=
ext, sms);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 sms->tx_state =3D MESSAGE_STATE_CANCELLED;
> + =C2=A0 =C2=A0 =C2=A0 sms_tx_queue_remove_entry(sms, l);

As you mentioned on IRC we may need to call the "submitted" callback
with ok =3D=3D FALSE.

I also wonder if we need to check that (entry->flags &
OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) and update some property.

Best regards

--===============2918900230726848246==--

