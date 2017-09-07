Content-Type: multipart/mixed; boundary="===============8873465604012041101=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] qmi/discovery: include control service into service
 list
Date: Thu, 07 Sep 2017 16:34:39 -0500
Message-ID: <d3157799-44d0-c8da-d060-6655c3d97f84@gmail.com>
In-Reply-To: <20170907192306.18117-2-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8873465604012041101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 09/07/2017 02:23 PM, Alexander Couzens wrote:
> There is no need to exclude it. It helps debugging because
> the service is now logged.
> ---
>   drivers/qmimodem/qmi.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> =

> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index 1af86aaccb08..7ea22992f8f0 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -1136,15 +1136,12 @@ static void discover_callback(uint16_t message, u=
int16_t length,
>   		if (type =3D=3D QMI_SERVICE_CONTROL) {
>   			device->control_major =3D major;
>   			device->control_minor =3D minor;
> -			continue;
>   		}
>   =

> -		list[count].type =3D type;
> -		list[count].major =3D major;
> -		list[count].minor =3D minor;
> -		list[count].name =3D name;
> -
> -		count++;
> +		list[i].type =3D type;
> +		list[i].major =3D major;
> +		list[i].minor =3D minor;
> +		list[i].name =3D name;
>   =


We store the CONTROL service minor and major numbers and generally treat =

it specially.  If you care about logging it, why not just add an extra =

debug statement?

>   		if (name)
>   			__debug_device(device, "found service [%s %d.%d]",
> @@ -1154,6 +1151,8 @@ static void discover_callback(uint16_t message, uin=
t16_t length,
>   							type, major, minor);
>   	}
>   =

> +	count =3D service_list->count;
> +
>   	ptr =3D tlv_get(buffer, length, 0x10, &len);
>   	if (!ptr)
>   		goto done;
> =


Regards,
-Denis

--===============8873465604012041101==--

