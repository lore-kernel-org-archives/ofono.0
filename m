Content-Type: multipart/mixed; boundary="===============7423506467846266520=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Fix release cid in gprs_deactive_for_remove
Date: Mon, 09 Aug 2010 09:11:29 -0500
Message-ID: <4C600C91.7000501@gmail.com>
In-Reply-To: <1281346091-24758-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7423506467846266520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

On 08/09/2010 04:28 AM, Zhenhua Zhang wrote:
> Similiar to pri_deactive_callback, we should release the context id in
> gprs_deactive_for_remove() as well.
> ---
>  src/gprs.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 8d807dd..2c5bb4e 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1262,6 +1262,9 @@ static void gprs_deactivate_for_remove(const struct=
 ofono_error *error,
>  		return;
>  	}
>  =

> +	gprs_cid_release(gprs, ctx->context.cid);
> +	ctx->context.cid =3D 0;
> +
>  	if (gprs->settings) {
>  		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
>  		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);

Great catch.  Patch has been applied, thanks.

Regards,
-Denis

--===============7423506467846266520==--

