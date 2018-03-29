Content-Type: multipart/mixed; boundary="===============1734766430921068468=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/12] qmi: assume version_list is up to date
Date: Thu, 29 Mar 2018 10:22:58 -0500
Message-ID: <535aef53-289a-e03e-6d87-6af28de909ef@gmail.com>
In-Reply-To: <20180329135801.5981-10-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1734766430921068468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/29/2018 08:57 AM, Jonas Bonn wrote:
> The way things are currently coded, the gobi plugin calls
> qmi_device_discover and does nothing else until it succeeds.  As such,
> we can safely assume that the version_list is set up when we go to
> create a service.

If you're making such a semantic change, you might want to add some =

documentation somewhere...

> ---
>   drivers/qmimodem/qmi.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> =

> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index c6e6df7c..be21a84d 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -2016,20 +2016,9 @@ static bool service_create(struct qmi_device *devi=
ce, bool shared,
>   	data->user_data =3D user_data;
>   	data->destroy =3D destroy;
>   =

> -	if (device->version_list) {
> -		service_create_discover(device->version_count,
> -						device->version_list, data);
> -		goto done;
> -	}
> -
> -	if (qmi_device_discover(device, service_create_discover, data, NULL))
> -		goto done;

Assumptions are bad.  Why don't we just fail in case =

device->version_list isn't valid?

> +	service_create_discover(device->version_count,
> +					device->version_list, data);
>   =

> -	g_free(data);
> -
> -	return false;
> -
> -done:
>   	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
>   	__qmi_device_discovery_started(device, &data->super);
>   =

> =


Regards,
-Denis

--===============1734766430921068468==--

