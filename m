Content-Type: multipart/mixed; boundary="===============1193546592912913392=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 04/30] qmi: request_alloc has no meaningful failure
 path
Date: Wed, 28 Mar 2018 14:59:31 -0500
Message-ID: <57eb1632-6f04-460c-01bb-7fb1e7679756@gmail.com>
In-Reply-To: <20180328190016.28509-5-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1193546592912913392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/28/2018 01:59 PM, Jonas Bonn wrote:
> The only way request_alloc can fail is if one of the memory allocation
> routines fail to allocate memory.  However, Linux memory allocation
> doesn't really fail in this manner; memory can be overcommited and the
> out-of-memory reaper will take care of re-establishing the balance when
> excess memory is actually accessed.
> =

> Given this, request_alloc will never return anything other than success
> and the failure paths will never be exercised.

Right, we encourage the use of g_new instead of g_try_new...

> ---
>   drivers/qmimodem/qmi.c | 32 ++------------------------------
>   1 file changed, 2 insertions(+), 30 deletions(-)
> =

> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index 0c95dd18..85ed9ddc 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -171,9 +171,7 @@ static struct qmi_request *__request_alloc(struct qmi=
_device* device,
>   	struct qmi_message_hdr *msg;
>   	uint16_t headroom;
>   =

> -	req =3D g_try_new0(struct qmi_request, 1);
> -	if (!req)
> -		return NULL;
> +	req =3D calloc(1, sizeof(*req));

Why now g_new0?  What's your plan here, are you wanting to get rid of =

glib entirely?  If so, then we might as well start using ell for QMI, =

which is a long term goal anyway.

>   =

>   	if (service =3D=3D QMI_SERVICE_CONTROL)
>   		headroom =3D QMI_CONTROL_HDR_SIZE;

Regards,
-Denis

--===============1193546592912913392==--

