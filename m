Content-Type: multipart/mixed; boundary="===============0042371308709224916=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] include: Add ofono_modem_get_voicecall
Date: Mon, 02 Jul 2018 10:34:07 -0500
Message-ID: <9ffd8d08-0ca9-00f7-f49e-7c482039bd86@gmail.com>
In-Reply-To: <1530280660-3212-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0042371308709224916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 06/29/2018 08:57 AM, Slava Monich wrote:
> ---
>   include/modem.h | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/include/modem.h b/include/modem.h
> index 005a42e..bed46c2 100644
> --- a/include/modem.h
> +++ b/include/modem.h
> @@ -31,6 +31,7 @@ extern "C" {
>   struct ofono_modem;
>   struct ofono_gprs;
>   struct ofono_sim;
> +struct ofono_voicecall;
>   =

>   enum ofono_modem_type {
>   	OFONO_MODEM_TYPE_HARDWARE =3D 0,
> @@ -84,6 +85,7 @@ void ofono_modem_remove_interface(struct ofono_modem *m=
odem,
>   const char *ofono_modem_get_path(struct ofono_modem *modem);
>   struct ofono_sim *ofono_modem_get_sim(struct ofono_modem *modem);
>   struct ofono_gprs *ofono_modem_get_gprs(struct ofono_modem *modem);
> +struct ofono_voicecall *ofono_modem_get_voicecall(struct ofono_modem *mo=
dem);
>   =

>   void ofono_modem_set_data(struct ofono_modem *modem, void *data);
>   void *ofono_modem_get_data(struct ofono_modem *modem);
> =


I went ahead and applied this one.  But if we need any more of these I =

would seriously consider exposing __ofono_atom_find to the public API =

instead.

Regards,
-Denis

--===============0042371308709224916==--

