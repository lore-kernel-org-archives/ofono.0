Content-Type: multipart/mixed; boundary="===============5392653257981388451=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] modem: only unref pending if it is a powered pending
Date: Mon, 06 Dec 2010 20:57:27 -0600
Message-ID: <4CFDA297.4080005@gmail.com>
In-Reply-To: <1291412422-16976-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5392653257981388451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 12/03/2010 03:40 PM, Gustavo F. Padovan wrote:
> ---
>  src/modem.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/src/modem.c b/src/modem.c
> index 52e647b..ae427b3 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -804,7 +804,8 @@ void ofono_modem_set_powered(struct ofono_modem *mode=
m, ofono_bool_t powered)
>  		modem->timeout =3D 0;
>  	}
>  =

> -	if (modem->pending !=3D NULL) {
> +	if (modem->powered_pending !=3D modem->powered &&
> +						modem->pending !=3D NULL) {
>  		DBusMessage *reply;
>  =

>  		if (powered =3D=3D modem->powered_pending)

Patch has been applied, thanks.

Regards,
-Denis

--===============5392653257981388451==--

