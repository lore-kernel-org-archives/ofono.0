Content-Type: multipart/mixed; boundary="===============5341869119693536683=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: [PATCH] qmi: track discovery tasks so clean up is possible
Date: Wed, 29 Mar 2017 12:52:46 +0100
Message-ID: <5d82876b-75f0-6ff0-29f1-3af89133382e@gmail.com>
In-Reply-To: <20170328192531.25233-1-denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5341869119693536683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I realised last night that I was not freeing the user_data memory.

I would propose to modify your code to cover both discovery and shutdown. U=
nify struct discover_data and struct shutdown_data into struct callback_dat=
a with a union for the func. And then add the shutdown callback to the same=
 queue.

It should also be possible to merge your struct discovery into the new stru=
ct callback_data, so that we don't have to allocate two structures for each=
 callback.

Will I modify your patch with that?

Lukasz


On 28/03/17 20:25, Denis Kenzior wrote:
> There are various device & service discovery tasks that are initiated
> based on a qmi_device object.  qmi_device object does not currently
> keep track of these tasks.  Unfortunately the qmi_device object can
> go away at any time, and these tasks can become orphaned.
> =

> The result of this can lead to crashes.  E.g. a discovery task timeout fi=
res
> after the qmi_device object has been destroyed.  Since the object is no
> longer valid, any accesses to it will likely result in a SEGFAULT.
> =

> This patch attempts to track all discovery tasks on the qmi_device
> object itself, so that they can be cleaned up properly.  This patch does
> not handle the qmi_device_shutdown functionality.
> ---
>  drivers/qmimodem/qmi.c | 149 ++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 124 insertions(+), 25 deletions(-)
> =

> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index 39fbb19..9b80455 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -43,6 +43,11 @@
>  typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
>  					const void *buffer, void *user_data);
>  =

> +struct discovery {
> +	void *discover_data;
> +	qmi_destroy_func_t destroy;
> +};
> +
>  struct qmi_device {
>  	int ref_count;
>  	int fd;
> @@ -53,6 +58,7 @@ struct qmi_device {
>  	GQueue *req_queue;
>  	GQueue *control_queue;
>  	GQueue *service_queue;
> +	GQueue *discovery_queue;
>  	uint8_t next_control_tid;
>  	uint16_t next_service_tid;
>  	qmi_debug_func_t debug_func;
> @@ -213,6 +219,24 @@ static gint __request_compare(gconstpointer a, gcons=
tpointer b)
>  	return req->tid - tid;
>  }
>  =

> +static void __discovery_free(gpointer data, gpointer user_data)
> +{
> +	struct discovery *d =3D data;
> +	qmi_destroy_func_t destroy =3D d->destroy;
> +
> +	destroy(d->discover_data);
> +}
> +
> +static gint __discovery_compare(gconstpointer a, gconstpointer b)
> +{
> +	const struct discovery *d =3D a;
> +
> +	if (d->discover_data =3D=3D b)
> +		return 0;
> +
> +	return 1;
> +}
> +
>  static void __notify_free(gpointer data, gpointer user_data)
>  {
>  	struct qmi_notify *notify =3D data;
> @@ -844,6 +868,37 @@ static void read_watch_destroy(gpointer user_data)
>  	device->read_watch =3D 0;
>  }
>  =

> +static void __qmi_device_discovery_started(struct qmi_device *device,
> +						void *discover_data,
> +						qmi_destroy_func_t destroy)
> +{
> +	struct discovery *d;
> +
> +	d =3D g_new0(struct discovery, 1);
> +	d->discover_data =3D discover_data;
> +	d->destroy =3D destroy;
> +
> +	g_queue_push_tail(device->discovery_queue, d);
> +}
> +
> +static void __qmi_device_discovery_complete(struct qmi_device *device,
> +						void *discover_data)
> +{
> +	GList *list;
> +	struct discovery *d;
> +
> +	list =3D g_queue_find_custom(device->req_queue,
> +				discover_data, __discovery_compare);
> +	if (!list)
> +		return;
> +
> +	d =3D list->data;
> +	g_queue_delete_link(device->discovery_queue, list);
> +
> +	d->destroy(d->discover_data);
> +	__discovery_free(d, NULL);
> +}
> +
>  static void service_destroy(gpointer data)
>  {
>  	struct qmi_service *service =3D data;
> @@ -897,6 +952,7 @@ struct qmi_device *qmi_device_new(int fd)
>  	device->req_queue =3D g_queue_new();
>  	device->control_queue =3D g_queue_new();
>  	device->service_queue =3D g_queue_new();
> +	device->discovery_queue =3D g_queue_new();
>  =

>  	device->service_list =3D g_hash_table_new_full(g_direct_hash,
>  					g_direct_equal, NULL, service_destroy);
> @@ -933,6 +989,9 @@ void qmi_device_unref(struct qmi_device *device)
>  	g_queue_foreach(device->req_queue, __request_free, NULL);
>  	g_queue_free(device->req_queue);
>  =

> +	g_queue_foreach(device->discovery_queue, __discovery_free, NULL);
> +	g_queue_free(device->discovery_queue);
> +
>  	if (device->write_watch > 0)
>  		g_source_remove(device->write_watch);
>  =

> @@ -1000,6 +1059,21 @@ struct discover_data {
>  	guint timeout;
>  };
>  =

> +static void discover_data_free(gpointer user_data)
> +{
> +	struct discover_data *data =3D user_data;
> +
> +	if (data->timeout) {
> +		g_source_remove(data->timeout);
> +		data->timeout =3D 0;
> +	}
> +
> +	if (data->destroy)
> +		data->destroy(data->user_data);
> +
> +	g_free(data);
> +}
> +
>  static void discover_callback(uint16_t message, uint16_t length,
>  					const void *buffer, void *user_data)
>  {
> @@ -1013,8 +1087,6 @@ static void discover_callback(uint16_t message, uin=
t16_t length,
>  	uint8_t count;
>  	unsigned int i;
>  =

> -	g_source_remove(data->timeout);
> -
>  	count =3D 0;
>  	list =3D NULL;
>  =

> @@ -1085,10 +1157,7 @@ done:
>  	if (data->func)
>  		data->func(count, list, data->user_data);
>  =

> -	if (data->destroy)
> -		data->destroy(data->user_data);
> -
> -	g_free(data);
> +	__qmi_device_discovery_complete(data->device, data);
>  }
>  =

>  static gboolean discover_reply(gpointer user_data)
> @@ -1102,10 +1171,7 @@ static gboolean discover_reply(gpointer user_data)
>  		data->func(device->version_count,
>  				device->version_list, data->user_data);
>  =

> -	if (data->destroy)
> -		data->destroy(data->user_data);
> -
> -	g_free(data);
> +	__qmi_device_discovery_complete(data->device, data);
>  =

>  	return FALSE;
>  }
> @@ -1132,7 +1198,9 @@ bool qmi_device_discover(struct qmi_device *device,=
 qmi_discover_func_t func,
>  	data->destroy =3D destroy;
>  =

>  	if (device->version_list) {
> -		g_timeout_add_seconds(0, discover_reply, data);
> +		data->timeout =3D g_timeout_add_seconds(0, discover_reply, data);
> +		__qmi_device_discovery_started(device, data,
> +							discover_data_free);
>  		return true;
>  	}
>  =

> @@ -1153,6 +1221,7 @@ bool qmi_device_discover(struct qmi_device *device,=
 qmi_discover_func_t func,
>  	__request_submit(device, req, hdr->transaction);
>  =

>  	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
> +	__qmi_device_discovery_started(device, data, discover_data_free);
>  =

>  	return true;
>  }
> @@ -1714,16 +1783,29 @@ struct service_create_data {
>  	guint timeout;
>  };
>  =

> -static gboolean service_create_reply(gpointer user_data)
> +static void service_create_data_free(gpointer user_data)
>  {
>  	struct service_create_data *data =3D user_data;
>  =

> -	data->func(NULL, data->user_data);
> +	if (data->timeout) {
> +		g_source_remove(data->timeout);
> +		data->timeout =3D 0;
> +	}
>  =

>  	if (data->destroy)
>  		data->destroy(data->user_data);
>  =

>  	g_free(data);
> +}
> +
> +static gboolean service_create_reply(gpointer user_data)
> +{
> +	struct service_create_data *data =3D user_data;
> +
> +	data->timeout =3D 0;
> +	data->func(NULL, data->user_data);
> +
> +	__qmi_device_discovery_complete(data->device, data);
>  =

>  	return FALSE;
>  }
> @@ -1739,8 +1821,6 @@ static void service_create_callback(uint16_t messag=
e, uint16_t length,
>  	uint16_t len;
>  	unsigned int hash_id;
>  =

> -	g_source_remove(data->timeout);
> -
>  	result_code =3D tlv_get(buffer, length, 0x02, &len);
>  	if (!result_code)
>  		goto done;
> @@ -1782,13 +1862,9 @@ static void service_create_callback(uint16_t messa=
ge, uint16_t length,
>  =

>  done:
>  	data->func(service, data->user_data);
> -
>  	qmi_service_unref(service);
>  =

> -	if (data->destroy)
> -		data->destroy(data->user_data);
> -
> -	g_free(data);
> +	__qmi_device_discovery_complete(data->device, data);
>  }
>  =

>  static void service_create_discover(uint8_t count,
> @@ -1819,7 +1895,10 @@ static void service_create_discover(uint8_t count,
>  		if (data->timeout > 0)
>  			g_source_remove(data->timeout);
>  =

> -		g_timeout_add_seconds(0, service_create_reply, data);
> +		data->timeout =3D g_timeout_add_seconds(0,
> +						service_create_reply, data);
> +		__qmi_device_discovery_started(device, data,
> +						service_create_data_free);
>  		return;
>  	}
>  =

> @@ -1864,6 +1943,8 @@ static bool service_create(struct qmi_device *devic=
e, bool shared,
>  =

>  done:
>  	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
> +	__qmi_device_discovery_started(device, data,
> +						service_create_data_free);
>  =

>  	return true;
>  }
> @@ -1883,16 +1964,21 @@ bool qmi_service_create(struct qmi_device *device,
>  =

>  struct service_create_shared_data {
>  	struct qmi_service *service;
> +	struct qmi_device *device;
>  	qmi_create_func_t func;
>  	void *user_data;
>  	qmi_destroy_func_t destroy;
> +	guint timeout;
>  };
>  =

> -static gboolean service_create_shared_reply(gpointer user_data)
> +static void service_create_shared_data_free(gpointer user_data)
>  {
>  	struct service_create_shared_data *data =3D user_data;
>  =

> -	data->func(data->service, data->user_data);
> +	if (data->timeout) {
> +		g_source_remove(data->timeout);
> +		data->timeout =3D 0;
> +	}
>  =

>  	qmi_service_unref(data->service);
>  =

> @@ -1900,6 +1986,16 @@ static gboolean service_create_shared_reply(gpoint=
er user_data)
>  		data->destroy(data->user_data);
>  =

>  	g_free(data);
> +}
> +
> +static gboolean service_create_shared_reply(gpointer user_data)
> +{
> +	struct service_create_shared_data *data =3D user_data;
> +
> +	data->timeout =3D 0;
> +	data->func(data->service, data->user_data);
> +
> +	__qmi_device_discovery_complete(data->device, data);
>  =

>  	return FALSE;
>  }
> @@ -1927,12 +2023,15 @@ bool qmi_service_create_shared(struct qmi_device =
*device,
>  			return false;
>  =

>  		data->service =3D qmi_service_ref(service);
> -
> +		data->device =3D device;
>  		data->func =3D func;
>  		data->user_data =3D user_data;
>  		data->destroy =3D destroy;
>  =

> -		g_timeout_add(0, service_create_shared_reply, data);
> +		data->timeout =3D g_timeout_add(0,
> +					service_create_shared_reply, data);
> +		__qmi_device_discovery_started(device, data,
> +					service_create_shared_data_free);
>  =

>  		return 0;
>  	}
>=20

--===============5341869119693536683==--

