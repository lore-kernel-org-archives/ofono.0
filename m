Content-Type: multipart/mixed; boundary="===============0182523867502712339=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v1 2/2] service: handle error while receiving messages
Date: Wed, 11 Apr 2012 20:31:27 +0200
Message-ID: <1334169087.16897.128.camel@aeonflux>
In-Reply-To: <1333720967-17878-3-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0182523867502712339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

>  src/service.c |   94 ++++++++++++++++++++++++++++++++++++++++++++-------=
-----
>  1 files changed, 74 insertions(+), 20 deletions(-)
> =

> diff --git a/src/service.c b/src/service.c
> index 851db34..c3fc0c6 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -55,6 +55,7 @@
>  #define CONTENT_TYPE_APP_SMIL "Content-Type: \"application/smil\";charse=
t=3Dutf-8"
> =

>  #define MAX_ATTACHMENTS_NUMBER 25
> +#define MAX_ATTEMPTS 3
> =

>  #define uninitialized_var(x) x =3D x
> =

> @@ -98,6 +99,7 @@ struct mms_request {
>  	gsize data_size;
>  	int fd;
>  	guint16 status;
> +	guint16 attempt;
>  	struct mms_service *service;
>  	mms_request_result_cb_t result_cb;
>  	struct mms_message *msg;
> @@ -526,6 +528,8 @@ static struct mms_request *create_request(enum mms_re=
quest_type type,
> =

>  	request->status =3D 0;
> =

> +	request->attempt =3D 0;
> +
>  	return request;
>  }
> =

> @@ -1656,17 +1660,22 @@ int mms_service_set_bearer_handler(struct mms_ser=
vice *service,
>  	return 0;
>  }
> =

> -static void deactivate_bearer(struct mms_service *service)
> +static inline gboolean bearer_is_active(struct mms_service *service)
>  {
> -	DBG("service %p", service);
> -
>  	if (service->bearer_setup =3D=3D TRUE)
> -		return;
> -
> -	if (service->bearer_active =3D=3D FALSE)
> -		return;
> +		return FALSE;
> =

>  	if (service->bearer_handler =3D=3D NULL)
> +		return FALSE;
> +
> +	return service->bearer_active;
> +}
> +
> +static void deactivate_bearer(struct mms_service *service)
> +{
> +	DBG("service %p", service);
> +
> +	if (bearer_is_active(service) =3D=3D FALSE)
>  		return;
> =

>  	DBG("service %p", service);
> @@ -1798,16 +1807,42 @@ exit:
>  	munmap(pdu, len);
>  }
> =

> +static gboolean mms_requeue_request(struct mms_request *request)
> +{
> +	request->attempt +=3D 1;
> +
> +	if (request->attempt =3D=3D MAX_ATTEMPTS)
> +		return FALSE;
> +
> +	if (request->type =3D=3D MMS_REQUEST_TYPE_GET) {
> +		request->fd =3D open(request->data_path, O_WRONLY | O_TRUNC,
> +							S_IWUSR | S_IRUSR);
> +		if (request->fd < 0)
> +			return FALSE;
> +	}
> +
> +	g_queue_push_tail(request->service->request_queue, request);
> +
> +	return TRUE;
> +}
> +
>  static gboolean web_get_cb(GWebResult *result, gpointer user_data)
>  {
>  	gsize written;
>  	gsize chunk_size;
>  	struct mms_request *request =3D user_data;
> -	struct mms_service *service;
>  	const guint8 *chunk;
> =

> -	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE)
> -		goto error;
> +	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE) {
> +		mms_error("Fail to get data chunk");
> +
> +		close(request->fd);
> +
> +		if (mms_requeue_request(request) =3D=3D FALSE)
> +			unlink(request->data_path);
> +
> +		goto exit;
> +	}
> =

>  	if (chunk_size =3D=3D 0) {
>  		close(request->fd);
> @@ -1826,26 +1861,35 @@ static gboolean web_get_cb(GWebResult *result, gp=
ointer user_data)
> =

>  	if (written !=3D chunk_size) {
>  		mms_error("only %zd/%zd bytes written\n", written, chunk_size);
> -		goto error;
> +
> +		close(request->fd);
> +		unlink(request->data_path);
> +
> +		goto complete;
>  	}
> =


same here. I do not like this. Please make clean and small changes that
are not re-factoring major pieces. If re-factoring seems to be needed,
please separate them out so they can be reviewed.

Regards

Marcel



--===============0182523867502712339==--

