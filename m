Content-Type: multipart/mixed; boundary="===============6898245334373988513=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] main: Make -d option repeatable
Date: Tue, 04 Oct 2016 22:27:12 -0500
Message-ID: <57F47310.7090707@gmail.com>
In-Reply-To: <1475574714-3539-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6898245334373988513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/04/2016 04:51 AM, Slava Monich wrote:
> Concatenating the patterns makes more sense than using the last
> supplied value and leaking the previous allocated patterns.
> ---
>   src/main.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/src/main.c b/src/main.c
> index 46bb90b..b43bb4e 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -137,10 +137,19 @@ static gboolean option_version =3D FALSE;
>   static gboolean parse_debug(const char *key, const char *value,
>   					gpointer user_data, GError **error)
>   {
> -	if (value)
> -		option_debug =3D g_strdup(value);
> -	else
> +	if (value) {
> +		if (option_debug) {
> +			char *prev =3D option_debug;
> +
> +			option_debug =3D g_strconcat(prev, ",", value, NULL);
> +			g_free(prev);
> +		} else {
> +			option_debug =3D g_strdup(value);
> +		}
> +	} else {
> +		g_free(option_debug);
>   		option_debug =3D g_strdup("*");
> +	}
>
>   	return TRUE;
>   }
> @@ -262,5 +271,7 @@ cleanup:
>
>   	__ofono_log_cleanup();
>
> +	g_free(option_debug);
> +
>   	return 0;
>   }
>


--===============6898245334373988513==--

