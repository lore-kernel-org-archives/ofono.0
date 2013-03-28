Content-Type: multipart/mixed; boundary="===============2459007777139367924=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/5] handsfree-audio: Handle when .Connect() was already
 replied to
Date: Thu, 28 Mar 2013 09:41:01 -0500
Message-ID: <5154567D.9040308@gmail.com>
In-Reply-To: <1364429582-12518-5-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2459007777139367924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 03/27/2013 07:13 PM, Vinicius Costa Gomes wrote:
> In some cases, it is possible that when sco_connect_cb() is called
> the .Connect() message (stored in card->msg) is not valid anymore.

Can you tell me what cases these are?

My thinking is that we will treat the connect callback specially.

If the driver calls the callback function, then it is assumed that no =

further action is necessary.  If the driver calls connect_sco(), then we =

assume that the callback function will never be called.

> ---
>   src/handsfree-audio.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index 3f24a2a..841cc3f 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -242,16 +242,19 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOC=
ondition cond,
>   {
>   	struct ofono_handsfree_card *card =3D user_data;
>   	DBusMessage *reply;
> -	int sk;
> +	int sk, err;
>
>   	if (agent =3D=3D NULL) {
>   		/* There's no agent, so there's no one to reply to */
> -		reply =3D NULL;
> +		if (card->msg)
> +			dbus_message_unref(card->msg);
> +
> +		card->msg =3D NULL;
>   		goto done;
>   	}
>
>   	if (cond&  (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
> -		reply =3D __ofono_error_failed(card->msg);
> +		err =3D -EIO;
>   		goto done;
>   	}
>
> @@ -261,14 +264,19 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOC=
ondition cond,
>
>   	close(sk);
>
> -	reply =3D dbus_message_new_method_return(card->msg);
> +	err =3D 0;
>
>   done:
> -	if (reply)
> -		g_dbus_send_message(ofono_dbus_get_connection(), reply);
> +	/* Or the msg was already replied to, or the agent exited */
> +	if (card->msg =3D=3D NULL)
> +		return FALSE;
>
> -	dbus_message_unref(card->msg);
> -	card->msg =3D NULL;
> +	if (err<  0)
> +		reply =3D __ofono_error_failed(card->msg);
> +	else
> +		reply =3D dbus_message_new_method_return(card->msg);
> +
> +	__ofono_dbus_pending_reply(&card->msg, reply);
>
>   	return FALSE;
>   }

Regards,
-Denis

--===============2459007777139367924==--

