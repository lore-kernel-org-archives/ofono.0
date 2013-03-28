Content-Type: multipart/mixed; boundary="===============3755926506723070571=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 3/3] huawei: Set property "AlwaysOnline" for CDMA
 modems
Date: Thu, 28 Mar 2013 09:54:42 -0500
Message-ID: <515459B2.5020801@gmail.com>
In-Reply-To: <20130328142245.GI29445@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3755926506723070571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Forest,

On 03/28/2013 09:22 AM, Forest Bond wrote:
> From: Forest Bond<forest.bond@rapidrollout.com>
>
> ---
>   plugins/huawei.c |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index 5d8875a..0621d5b 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -377,6 +377,9 @@ static void cfun_offline(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>   		return;
>   	}
>
> +	if (data->have_gsm =3D=3D FALSE&&  data->have_cdma =3D=3D TRUE)
> +		ofono_modem_set_boolean(modem, "AlwaysOnline", TRUE);
> +
>   	ofono_modem_set_powered(modem, TRUE);
>   }
>

Things don't seem to be this simple.  The Huawei driver sets the modem =

offline as part of the init procedure (grep for 'offline_command').  So =

once we enable the device, it is put into radio off mode.  With the =

changes you're proposing there will be no way to get it online ;)

Regards,
-Denis

--===============3755926506723070571==--

