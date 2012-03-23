Content-Type: multipart/mixed; boundary="===============1834875557889438446=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 3/6] service: remove pdu without meta
Date: Fri, 23 Mar 2012 11:39:16 -0700
Message-ID: <1332527956.1870.45.camel@aeonflux>
In-Reply-To: <1332521141-31865-4-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1834875557889438446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sebastien,

>  src/service.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> =

> diff --git a/src/service.c b/src/service.c
> index 0161ec0..8dbee12 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -777,11 +777,17 @@ static DBusMessage *send_message(DBusConnection *co=
nn,
>  		return __mms_error_trans_failure(dbus_msg);
>  	}
>  =

> +	g_free(request->data_path);
> +
> +	request->data_path =3D g_strdup_printf("%s/.mms/%s/%s", g_get_home_dir(=
),
> +						service->identity, msg->uuid);
> +
>  	meta =3D mms_store_meta_open(service->identity, msg->uuid);
>  	if (meta =3D=3D NULL) {
>  		release_attachement_data(msg->attachments);
>  		mms_message_free(msg);
>  =

> +		unlink(request->data_path);
>  		mms_request_destroy(request);

Same here. That code keeps duplicating all over.

Regards

Marcel



--===============1834875557889438446==--

