Content-Type: multipart/mixed; boundary="===============5621717828339803844=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/12] service: Process delivery_ind notification
Date: Tue, 28 Aug 2012 09:26:50 -0500
Message-ID: <503CD52A.7090002@gmail.com>
In-Reply-To: <1345813571-15775-10-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5621717828339803844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

On 08/24/2012 08:06 AM, Ronald Tessier wrote:
> ---
>   src/service.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++---
>   1 file changed, 107 insertions(+), 4 deletions(-)
>
> diff --git a/src/service.c b/src/service.c
> index b3ecc1e..44184cb 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -1300,6 +1300,104 @@ static void emit_service_removed(struct mms_servi=
ce *service)
>   				&service->path, DBUS_TYPE_INVALID);
>   }
>
> +static gboolean get_meta_by_msgid(struct mms_service *service,
> +						const char *msgid,
> +						char *uuid)
> +{
> +	GDir *dir;
> +	GKeyFile *meta;
> +	const char *file;
> +	const char *homedir;
> +	const char *service_id;
> +	char *service_path;
> +
> +	homedir =3D g_get_home_dir();
> +	if (homedir =3D=3D NULL)
> +		return FALSE;
> +
> +	service_id =3D service->identity;
> +
> +	service_path =3D g_strdup_printf("%s/.mms/%s/", homedir, service_id);
> +
> +	dir =3D g_dir_open(service_path, 0, NULL);
> +	g_free(service_path);
> +	if (dir =3D=3D NULL)
> +		return FALSE;
> +
> +	while ((file =3D g_dir_read_name(dir)) !=3D NULL) {
> +		char *id;
> +
> +		if (g_str_has_suffix(file, MMS_META_UUID_SUFFIX) =3D=3D FALSE)
> +			continue;
> +
> +		if (strlen(file) !=3D MMS_META_UUID_LEN +
> +						MMS_META_UUID_SUFFIX_LEN)
> +			continue;
> +
> +		strncpy(uuid, file, MMS_META_UUID_LEN);
> +		uuid[MMS_META_UUID_LEN] =3D 0;
> +
> +		meta =3D mms_store_meta_open(service_id, uuid);
> +		if (meta =3D=3D NULL)
> +			goto bail;
> +
> +		id =3D g_key_file_get_string(meta, "info", "id", NULL);
> +		if (id =3D=3D NULL) {
> +			mms_store_meta_close(service_id, uuid, meta, FALSE);
> +			continue;
> +		}
> +
> +		if (g_strcmp0(msgid, id) =3D=3D 0) {
> +			mms_store_meta_close(service_id, uuid, meta, FALSE);
> +			g_dir_close(dir);
> +			return TRUE;
> +		}
> +
> +		mms_store_meta_close(service_id, uuid, meta, FALSE);
> +	}
> +
> +bail:
> +	g_dir_close(dir);
> +
> +	return FALSE;
> +}
> +
> +static void process_delivery_ind_notification(struct mms_service *servic=
e,
> +						struct mms_message *di_msg)
> +{
> +	GKeyFile *meta;
> +	char uuid[MMS_META_UUID_LEN + 1];
> +	char *path;
> +	char *to;
> +
> +	if (get_meta_by_msgid(service, di_msg->di.msgid, uuid) =3D=3D FALSE)
> +		goto bail;
> +
> +	meta =3D mms_store_meta_open(service->identity, uuid);
> +	if (meta =3D=3D NULL)
> +		return;
> +
> +	to =3D g_strdup(di_msg->di.to);
> +
> +	mms_address_to_string(to);
> +
> +	g_key_file_set_string(meta, "delivery_status", to,
> +				delivery_status[di_msg->di.dr_status - 127]);
> +
> +	g_free(to);
> +
> +	mms_store_meta_close(service->identity, uuid, meta, TRUE);
> +
> +	path =3D g_strdup_printf("%s/%s/%s", MMS_PATH, service->identity, uuid);
> +
> +	g_free(path);
> +
> +bail:
> +	mms_store_remove(service->identity, di_msg->uuid);
> +
> +	mms_message_free(di_msg);
> +}
> +
>   static gboolean load_message_from_store(const char *service_id,
>   				const char *uuid, struct mms_message *msg)
>   {
> @@ -1485,6 +1583,7 @@ register_sr:
>   		}
>   	} else if (msg->type =3D=3D MMS_MESSAGE_TYPE_DELIVERY_IND) {
>   		request =3D NULL;
> +		process_delivery_ind_notification(service, msg);
>   	} else
>   		request =3D NULL;
>
> @@ -1514,15 +1613,17 @@ static void load_messages(struct mms_service *ser=
vice)
>   		return;
>
>   	while ((file =3D g_dir_read_name(dir)) !=3D NULL) {
> -		const size_t suffix_len =3D 7;
>   		char *uuid;
> +		size_t uuid_len;
>
> -		if (g_str_has_suffix(file, ".status") =3D=3D FALSE)
> +		if (g_str_has_suffix(file, MMS_META_UUID_SUFFIX) =3D=3D FALSE)
>   			continue;
> -		if (strlen(file) - suffix_len =3D=3D 0)
> +
> +		uuid_len =3D strlen(file) - MMS_META_UUID_SUFFIX_LEN;
> +		if (uuid_len =3D=3D 0)
>   			continue;
>
> -		uuid =3D g_strndup(file, strlen(file) - suffix_len);
> +		uuid =3D g_strndup(file, uuid_len);
>
>   		process_message_on_start(service, uuid);
>

This chunk should really be in a separate patch since it is related to =

the previous one.

> @@ -2401,6 +2502,8 @@ void mms_service_push_notify(struct mms_service *se=
rvice,
>
>   		mms_store_meta_close(service->identity, uuid, meta, TRUE);
>
> +		process_delivery_ind_notification(service, msg);
> +
>   		return;
>   	}
>

Regards,
-Denis

--===============5621717828339803844==--

