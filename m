Content-Type: multipart/mixed; boundary="===============8000998361456870848=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugins: rm unecessary sleep from ril plugin
Date: Tue, 17 Nov 2015 20:51:09 -0600
Message-ID: <564BE79D.3010405@gmail.com>
In-Reply-To: <1447811280-12070-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8000998361456870848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 11/17/2015 07:48 PM, Tony Espy wrote:
> ---
>   plugins/ril.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/plugins/ril.c b/plugins/ril.c
> index 8ccf01a..7820be4 100644
> --- a/plugins/ril.c
> +++ b/plugins/ril.c
> @@ -145,7 +145,6 @@ static void ril_radio_state_changed(struct ril_msg *m=
essage, gpointer user_data)
>   			if (rd->ofono_online) {
>   				ofono_error("%s: radio self-powered off!",
>   						__func__);
> -				sleep(5);
>   				exit(1);

Are we removing the exit as well soon?

>   			}
>   			break;
>

Applied, thanks.

Regards,
-Denis

--===============8000998361456870848==--

