Content-Type: multipart/mixed; boundary="===============6138315517064776865=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stemodem: fix possible memory leak
Date: Mon, 07 Feb 2011 21:58:58 -0600
Message-ID: <4D50BF82.9060607@gmail.com>
In-Reply-To: <1297119772-17987-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6138315517064776865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 02/07/2011 05:02 PM, Jeevaka Badrappan wrote:
> ---
>  drivers/stemodem/voicecall.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
> index ca275cd..dd5d009 100644
> --- a/drivers/stemodem/voicecall.c
> +++ b/drivers/stemodem/voicecall.c
> @@ -491,6 +491,7 @@ static void ecav_notify(GAtResult *result, gpointer u=
ser_data)
>  =

>  		vd->local_release &=3D ~(1 << existing_call->id);
>  		vd->calls =3D g_slist_remove(vd->calls, l->data);
> +		g_free(existing_call);
>  		break;
>  	}
>  =


Sure looks like a leak to me.  Patch has been applied, thanks.

Regards,
-Denis

--===============6138315517064776865==--

