Content-Type: multipart/mixed; boundary="===============0411329650746321027=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix: Free modem name in ofono_modem_remove
Date: Wed, 21 Jul 2010 11:59:47 -0500
Message-ID: <4C472783.2080109@gmail.com>
In-Reply-To: <1279694474-10635-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0411329650746321027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

On 07/21/2010 01:41 AM, Zhenhua Zhang wrote:
> Avoid the memory leak of modem name.
> ---
>  src/modem.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> @@ -1495,6 +1495,7 @@ void ofono_modem_remove(struct ofono_modem *modem)
>  	if (modem->driver_type)
>  		g_free(modem->driver_type);
>  =

> +	g_free(modem->name);
>  	g_free(modem->path);
>  	g_free(modem);
>  }

Good catch.  Patch has been applied, thanks.

Regards,
-Denis

--===============0411329650746321027==--

