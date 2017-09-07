Content-Type: multipart/mixed; boundary="===============4256207343536259622=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] qmi/discovery: remove useless code
Date: Thu, 07 Sep 2017 16:33:22 -0500
Message-ID: <b923eae8-bd6a-1556-5a60-66d55c1cb90a@gmail.com>
In-Reply-To: <20170907192306.18117-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4256207343536259622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 09/07/2017 02:23 PM, Alexander Couzens wrote:
> ---
>   drivers/qmimodem/qmi.c | 5 -----
>   1 file changed, 5 deletions(-)
> =

> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index c538cb978393..1af86aaccb08 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -1162,11 +1162,6 @@ static void discover_callback(uint16_t message, ui=
nt16_t length,
>   =

>   	service_list =3D ptr + *((uint8_t *) ptr) + 1;
>   =


Why don't you also take out that service_list assignment as well?

> -	for (i =3D 0; i < service_list->count; i++) {
> -		if (service_list->services[i].type =3D=3D QMI_SERVICE_CONTROL)
> -			continue;
> -	}
> -
>   done:
>   	device->version_list =3D list;
>   	device->version_count =3D count;
> =


Regards,
-Denis

--===============4256207343536259622==--

