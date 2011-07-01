Content-Type: multipart/mixed; boundary="===============3344119950318727530=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] bluetooth: fix not removing data when
 devices/adapters are removed
Date: Fri, 01 Jul 2011 03:21:32 -0500
Message-ID: <4E0D838C.9000304@gmail.com>
In-Reply-To: <1309504344-23058-3-git-send-email-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3344119950318727530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On 07/01/2011 02:12 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> =

> If an adapter or device is removed any data associate should be removed,
> otherwise the next time they appear/are created the drivers may not
> asssociate again.
> ---
>  plugins/bluetooth.c |   79 ++++++++++++++++++++++++++++++++++++---------=
-----
>  plugins/bluetooth.h |    4 +-
>  plugins/hfp_hf.c    |   30 ++++++++++++-------
>  3 files changed, 78 insertions(+), 35 deletions(-)

Patch looks good, just one quick question:

> @@ -443,25 +443,33 @@ free:
>  	return -ENOMEM;
>  }
>  =

> -static gboolean hfp_remove_each_modem(gpointer key, gpointer value,
> +static gboolean hfp_remove_modem(gpointer key, gpointer value,
>  					gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D value;
> +	const char *device =3D key;
> +	const char *prefix =3D user_data;
> +
> +	if (prefix && g_str_has_prefix(device, prefix) =3D=3D FALSE)
> +		return TRUE;

Are you sure you want to return TRUE here?  By my reading TRUE should be
removed only if the key should be removed.  That seems not to be what
you want...

>  =

>  	ofono_modem_remove(modem);
>  =

>  	return TRUE;
>  }
>  =


Regards,
-Denis

--===============3344119950318727530==--

