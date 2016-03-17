Content-Type: multipart/mixed; boundary="===============4199507953334727608=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/9] gprs: pri_activate_callback: optional msg reply
Date: Thu, 17 Mar 2016 12:41:04 -0500
Message-ID: <56EAEC30.4010701@gmail.com>
In-Reply-To: <1458234140-7936-5-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4199507953334727608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/17/2016 12:02 PM, Dragos Tatulea wrote:
> For automatic context activation there's no initial message to send a
> reply to.
> ---
>   src/gprs.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/src/gprs.c b/src/gprs.c
> index 9192e68..233ab1a 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -887,8 +887,10 @@ static void pri_activate_callback(const struct ofono=
_error *error, void *data)
>   	}
>
>   	ctx->active =3D TRUE;
> -	__ofono_dbus_pending_reply(&ctx->pending,
> -				dbus_message_new_method_return(ctx->pending));
> +
> +	if (ctx->pending)
> +		__ofono_dbus_pending_reply(&ctx->pending,
> +				bus_message_new_method_return(ctx->pending));

So this is a bit tricky.  While this is strictly okay to do right now, =

since pending is only used for Activate/Deactivate, I'd prefer that we =

make a separate callback for the read_settings case.  Even if it does =

mean a bit of code duplication.

>
>   	if (gc->settings->interface !=3D NULL) {
>   		pri_ifupdown(gc->settings->interface, TRUE);
>

Regards,
-Denis

--===============4199507953334727608==--

