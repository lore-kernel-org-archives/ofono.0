Content-Type: multipart/mixed; boundary="===============7602727232422440110=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/12] hfpmodem: Support for +BSIR unsol. result codes
Date: Fri, 09 Sep 2011 00:48:50 -0500
Message-ID: <4E69A8C2.6060408@gmail.com>
In-Reply-To: <1316104483-13144-7-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7602727232422440110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 09/15/2011 11:34 AM, Mikel Astiz wrote:
> ---
>  drivers/hfpmodem/handsfree.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
> index 9b7b986..a3e7978 100644
> --- a/drivers/hfpmodem/handsfree.c
> +++ b/drivers/hfpmodem/handsfree.c
> @@ -43,6 +43,7 @@
>  =

>  struct hf_data {
>  	GAtChat *chat;
> +	unsigned int vendor;

If you're not planning to use the vendor member for anything then it is
better left out.

>  };
>  =

>  static gboolean hfp_handsfree_register(gpointer user_data)
> @@ -54,6 +55,19 @@ static gboolean hfp_handsfree_register(gpointer user_d=
ata)
>  	return FALSE;
>  }
>  =

> +static void bsir_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_handsfree *hf =3D user_data;
> +	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
> +	int value;
> +
> +	if (at_util_parse_reg_unsolicited(result, "+BSIR:", &value,
> +				NULL, NULL, NULL, hd->vendor) =3D=3D FALSE)
> +		return;
> +
> +	ofono_handsfree_set_inband_ringing(hf, (ofono_bool_t) value);
> +}
> +
>  static int hfp_handsfree_probe(struct ofono_handsfree *hf,
>  				unsigned int vendor, void *data)
>  {
> @@ -63,9 +77,12 @@ static int hfp_handsfree_probe(struct ofono_handsfree =
*hf,
>  	DBG("");
>  	hd =3D g_new0(struct hf_data, 1);
>  	hd->chat =3D g_at_chat_clone(info->chat);
> +	hd->vendor =3D vendor;
>  =

>  	ofono_handsfree_set_data(hf, hd);
>  =

> +	g_at_chat_register(hd->chat, "+BSIR:", bsir_notify, FALSE, hf, NULL);
> +

Just a minor nitpick, but I'd like this to be done in hfp_handsfree_register

>  	g_idle_add(hfp_handsfree_register, hf);
>  =

>  	return 0;

Regards,
-Denis

--===============7602727232422440110==--

