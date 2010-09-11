Content-Type: multipart/mixed; boundary="===============5237374434564522348=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] Add support to enable/disable specific plugin
Date: Sat, 11 Sep 2010 12:42:37 +0200
Message-ID: <1284201757.20451.18.camel@aeonflux.t-mobile.de>
In-Reply-To: <1284195492-5424-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5237374434564522348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Support to load or not load specific plugin when ofono is started.
> E.g., use 'ofonod -P hfp' to disable hfp plugin.
> ---
>  src/main.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)

patch has been applied. I did all the hard work - just forgot to hook it
up properly ;)
 =

> -	__ofono_plugin_init(NULL, NULL);
> +	__ofono_plugin_init(option_plugin, option_noplugin);
> +
> +	g_free(option_plugin);
> +	g_free(option_noplugin);

Please also send a ConnMan patch to fix the memory leak that ConnMan has
here actually.

Regards

Marcel



--===============5237374434564522348==--

