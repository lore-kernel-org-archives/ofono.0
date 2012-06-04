Content-Type: multipart/mixed; boundary="===============0578302998289570178=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v0 3/3] dundee: Ignore DUN device if PAN is present
Date: Mon, 04 Jun 2012 16:14:35 +0200
Message-ID: <4FCCC2CB.2020601@monom.org>
In-Reply-To: <1338819092-28696-4-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0578302998289570178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04.06.2012 16:11, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> =

> ---
>  dundee/bluetooth.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> =

> diff --git a/dundee/bluetooth.c b/dundee/bluetooth.c
> index 5a913cc..8762f51 100644
> --- a/dundee/bluetooth.c
> +++ b/dundee/bluetooth.c
> @@ -141,6 +141,15 @@ static int bt_probe(GSList *uuids, const char *path,=
 const char *dev_addr,
>  =

>  	DBG("");
>  =

> +	for (; uuids; uuids =3D uuids->next) {
> +		const char *uuid =3D uuids->data;
> +
> +		if (g_strcmp0(uuid, NAP_UUID) =3D=3D 0) {
> +			ofono_info("Device %s supports DUN and PAN at the same time. DUN is i=
gnored", path);

argh, this line is a bit too long...

--===============0578302998289570178==--

