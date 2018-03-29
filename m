Content-Type: multipart/mixed; boundary="===============5788841735502262431=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/12] qmi: unify common request header setup
Date: Thu, 29 Mar 2018 10:10:25 -0500
Message-ID: <153bd4b9-998b-a41a-37c2-654cda2f788f@gmail.com>
In-Reply-To: <20180329135801.5981-4-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5788841735502262431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/29/2018 08:57 AM, Jonas Bonn wrote:
> The service and control requests differ slightly in their headers, but
> this difference is minor enough that we can handle it in a common
> request allocation routine.  This patch unifies the header setup for the
> two request types.
> ---
>   drivers/qmimodem/qmi.c | 62 ++++++++++++++++++++++---------------------=
-------
>   1 file changed, 27 insertions(+), 35 deletions(-)
> =

> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index b60e0c0b..e39befc4 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -159,7 +159,8 @@ void qmi_free(void *ptr)
>   	free(ptr);
>   }
>   =

> -static struct qmi_request *__request_alloc(uint8_t service,
> +static struct qmi_request *__request_alloc(struct qmi_device* device,
> +				uint8_t service,
>   				uint8_t client, uint16_t message,
>   				const void *data,
>   				uint16_t length, qmi_message_func_t func,
> @@ -211,6 +212,23 @@ static struct qmi_request *__request_alloc(uint8_t s=
ervice,
>   =

>   	*head =3D req->buf + QMI_MUX_HDR_SIZE;
>   =

> +	if (service =3D=3D QMI_SERVICE_CONTROL) {
> +		struct qmi_control_hdr* hdr;
> +
> +		hdr =3D req->buf + QMI_MUX_HDR_SIZE;
> +		hdr->type =3D 0x00;
> +		hdr->transaction =3D device->next_control_tid++;
> +		if (device->next_control_tid =3D=3D 0)
> +			device->next_control_tid =3D 1;
> +	} else {
> +		struct qmi_service_hdr* hdr;
> +		hdr =3D req->buf + QMI_MUX_HDR_SIZE;
> +		hdr->type =3D 0x00;
> +		hdr->transaction =3D device->next_service_tid++;
> +		if (device->next_service_tid < 256)
> +			device->next_service_tid =3D 256;
> +	}
> +

I don't think this really belongs here.  You should be able to allocate =

a request without side-effecting the transaction ids and free it later =

(e.g. if something fails.)  If you want to unify this then maybe this =

should be part of __request_submit instead.

Also, somewhat unrelated, but it looks like qmi_service_hdr.transaction =

is not byte-swapped to LE properly.

Regards,
-Denis

--===============5788841735502262431==--

