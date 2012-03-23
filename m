Content-Type: multipart/mixed; boundary="===============7769396547774009819=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 2/6] service: fixed possible meta with NULL uuid
Date: Fri, 23 Mar 2012 11:38:08 -0700
Message-ID: <1332527888.1870.44.camel@aeonflux>
In-Reply-To: <1332521141-31865-3-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7769396547774009819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sebastien,

> If mms_store_file fails.
> ---
>  src/service.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/src/service.c b/src/service.c
> index 3fdf4e0..0161ec0 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -767,6 +767,15 @@ static DBusMessage *send_message(DBusConnection *con=
n,
>  =

>  	msg->uuid =3D g_strdup(mms_store_file(service->identity,
>  						request->data_path));
> +	if (msg->uuid =3D=3D NULL) {
> +		release_attachement_data(msg->attachments);
> +		mms_message_free(msg);
> +
> +		unlink(request->data_path);
> +		mms_request_destroy(request);
> +
> +		return __mms_error_trans_failure(dbus_msg);
> +	}

I am seeing a lot of code duplication here. We need to unify this.

Regards

Marcel



--===============7769396547774009819==--

