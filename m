Content-Type: multipart/mixed; boundary="===============5997300034686553681=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH] qmi: remove request when it timeouts
Date: Thu, 26 Oct 2017 15:04:05 +0200
Message-ID: <13d9a774-2150-71e1-08e2-ee88556a2ca8@southpole.se>
In-Reply-To: <1509021874-14953-2-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5997300034686553681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

Just a few trivial fixups below.

On 10/26/2017 02:44 PM, Christophe Ronco wrote:
> When modem does not answer or answers slowly to a discovery request,
> a timeout occurs.
> In timeout callback, request should be removed from queues to avoid
> treating answer if it arrives later.
> ---
>   drivers/qmimodem/qmi.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index c538cb9..65263d2 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -1073,6 +1073,7 @@ struct discover_data {
>   	qmi_discover_func_t func;
>   	void *user_data;
>   	qmi_destroy_func_t destroy;
> +	uint8_t tid;

This should be uint16_t.

>   	guint timeout;
>   };
>   =

> @@ -1181,14 +1182,38 @@ static gboolean discover_reply(gpointer user_data)
>   {
>   	struct discover_data *data =3D user_data;
>   	struct qmi_device *device =3D data->device;
> +	unsigned int tid =3D (unsigned int)(data->tid);
You don't need the explicit cast here.

> +	GList *list;
> +	struct qmi_request *req =3D NULL;
>   =

>   	data->timeout =3D 0;
>   =

> +	/* remove request from queues */
> +	if (tid !=3D 0) {
> +		list =3D g_queue_find_custom(device->req_queue,
> +				GUINT_TO_POINTER(tid), __request_compare);
> +
> +		if (list) {
> +			req =3D list->data;
> +			g_queue_delete_link(device->req_queue, list);
> +		} else {
> +			list =3D g_queue_find_custom(device->control_queue,
> +				GUINT_TO_POINTER(tid), __request_compare);
> +
> +			if (list) {
> +				req =3D list->data;
> +				g_queue_delete_link(device->control_queue,
> +								list);
> +			}
> +		}
> +	}
> +
>   	if (data->func)
>   		data->func(device->version_count,
>   				device->version_list, data->user_data);
>   =

>   	__qmi_device_discovery_complete(data->device, &data->super);
> +	__request_free(req, NULL);
>   =

>   	return FALSE;
>   }
> @@ -1234,6 +1259,7 @@ bool qmi_device_discover(struct qmi_device *device,=
 qmi_discover_func_t func,
>   =

>   	hdr->type =3D 0x00;
>   	hdr->transaction =3D device->next_control_tid++;
> +	data->tid =3D hdr->transaction;
>   =

>   	__request_submit(device, req, hdr->transaction);
>   =


/Jonas


--===============5997300034686553681==--

