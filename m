Content-Type: multipart/mixed; boundary="===============6389584435993401114=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] Include datagram support to history API
Date: Mon, 27 Sep 2010 21:16:51 -0500
Message-ID: <4CA15013.9070009@gmail.com>
In-Reply-To: <1285606459-1297-2-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6389584435993401114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> --- a/src/history.c
> +++ b/src/history.c
> @@ -47,7 +47,15 @@ struct history_call_foreach_data {
>  struct history_sms_foreach_data {
>  	const struct ofono_uuid *uuid;
>  	const char *address;
> -	const char *text;
> +	union {
> +		const char *text;
> +		struct {
> +			const unsigned char *data;
> +			unsigned len;
> +			guint16 dst;
> +			guint16 src;

Are you overflowing the dst/src ports for the 16 bit case by any chance?
 With the 8bit port fix patch, we're actually using 24 bits to store
these values.  There might need to be a comment in the history API about
this.

Are 8 bit ports even used in practice?  If not, then might be that
shifting 8-bit values by 16 is better...

Other than that, I'm happy with this one.

Regards,
-Denis

--===============6389584435993401114==--

