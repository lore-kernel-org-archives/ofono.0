Content-Type: multipart/mixed; boundary="===============8997133918886204941=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 7/7] handsfree-audio: Enable wideband speech if defer
 is enabled
Date: Fri, 12 Apr 2013 18:16:35 -0500
Message-ID: <516895D3.2080103@gmail.com>
In-Reply-To: <1365622677-4824-7-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8997133918886204941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/10/2013 02:37 PM, Vinicius Costa Gomes wrote:
> From: Claudio Takahasi<claudio.takahasi@openbossa.org>
>
> Only enable support for wideband speech codecs, at this point mSBC, if
> the kernel supports defer setup.
> ---
>   src/handsfree-audio.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index a332f68..da8e100 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -66,6 +66,7 @@ static GSList *card_list =3D 0;
>   static guint sco_watch =3D 0;
>   static GSList *drivers =3D 0;
>   static ofono_bool_t has_wideband =3D FALSE;
> +static int defer_setup =3D 1;
>
>   static void send_new_connection(const char *card, int fd, uint8_t codec)
>   {
> @@ -159,7 +160,7 @@ static int sco_init(void)
>   {
>   	GIOChannel *sco_io;
>   	struct sockaddr_sco saddr;
> -	int sk, defer_setup =3D 1;
> +	int sk;
>
>   	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
>   								BTPROTO_SCO);
> @@ -177,9 +178,11 @@ static int sco_init(void)
>   	}
>
>   	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
> -				&defer_setup, sizeof(defer_setup))<  0)
> +				&defer_setup, sizeof(defer_setup))<  0) {
> +		defer_setup =3D 0;
>   		ofono_warn("Can't enable deferred setup: %s (%d)",
>   						strerror(errno), errno);
> +	}
>
>   	if (listen(sk, 5)<  0) {
>   		close(sk);
> @@ -656,6 +659,9 @@ static DBusMessage *am_agent_register(DBusConnection =
*conn,
>   			has_cvsd =3D TRUE;
>   		else if (codecs[i] !=3D HFP_CODEC_MSBC)
>   			return __ofono_error_invalid_args(msg);
> +
> +		if (defer_setup)
> +			has_wideband =3D TRUE;

This patch seems to have unintended side-effects and is in general hard =

to read.

How about something like:

if (has_wideband && !defer_setup)
	has_wideband =3D FALSE;

outside of the for loop.  Other ideas welcome as well.

>   	}
>
>   	if (has_cvsd =3D=3D FALSE) {

Regards,
-Denis

--===============8997133918886204941==--

