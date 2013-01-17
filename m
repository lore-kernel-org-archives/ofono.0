Content-Type: multipart/mixed; boundary="===============7798093885401516145=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 4/8] hfpmodem: Add support for storing the supported
 codecs
Date: Thu, 17 Jan 2013 11:29:29 -0600
Message-ID: <50F834F9.4010409@gmail.com>
In-Reply-To: <1358435591-14757-5-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7798093885401516145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 01/17/2013 09:13 AM, Claudio Takahasi wrote:
> From: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
>
> As informing the AG of the supported codecs is part of the setup
> of the SLC, it makes sense to have this information inside the SLC
> establishment part.
>
> Now the hfp_slc_info structure has dynamic information, and so the
> hfp_slc_info_free() function is used.
> ---
>   drivers/hfpmodem/slc.c  | 14 +++++++++++++-
>   drivers/hfpmodem/slc.h  | 10 +++++++++-
>   plugins/hfp_hf_bluez4.c |  5 ++++-
>   plugins/phonesim.c      | 12 +++++++-----
>   4 files changed, 33 insertions(+), 8 deletions(-)

This patch needs to be broken up.  First it needs to implement the =

hfp_slc_info_free function, then update all existing plugins to use =

that.  Then introduce hfp_slc_info_init changes and whatever else.

>
> diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
> index 646befa..288afdd 100644
> --- a/drivers/hfpmodem/slc.c
> +++ b/drivers/hfpmodem/slc.c
> @@ -52,7 +52,8 @@ struct slc_establish_data {
>   	gpointer userdata;
>   };
>
> -void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version)
> +void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version,
> +						unsigned char *codecs, int len)
>   {
>   	info->ag_features =3D 0;
>   	info->ag_mpty_features =3D 0;
> @@ -72,11 +73,22 @@ void hfp_slc_info_init(struct hfp_slc_info *info, gui=
nt16 version)
>
>   	info->hf_features |=3D HFP_HF_FEATURE_CODEC_NEGOTIATION;
>
> +	info->codecs =3D g_memdup(codecs, len);
> +	info->codecs_len =3D len;
> +
>   done:
>   	memset(info->cind_val, 0, sizeof(info->cind_val));
>   	memset(info->cind_pos, 0, sizeof(info->cind_pos));
>   }
>
> +void hfp_slc_info_free(struct hfp_slc_info *info)
> +{
> +	g_free(info->codecs);
> +
> +	g_at_chat_unref(info->chat);
> +	info->chat =3D NULL;
> +}
> +
>   static void slc_establish_data_unref(gpointer userdata)
>   {
>   	struct slc_establish_data *sed =3D userdata;
> diff --git a/drivers/hfpmodem/slc.h b/drivers/hfpmodem/slc.h
> index b71ffe9..d7c90a2 100644
> --- a/drivers/hfpmodem/slc.h
> +++ b/drivers/hfpmodem/slc.h
> @@ -44,6 +44,11 @@ enum hfp_indicator {
>   	HFP_INDICATOR_LAST
>   };
>
> +enum hfp_codec {
> +	HFP_CODEC_CVSD =3D 0x01,
> +	HFP_CODEC_MSBC =3D 0x02,
> +};
> +
>   typedef void (*hfp_slc_cb_t)(void *userdata);
>
>   struct hfp_slc_info {
> @@ -53,9 +58,12 @@ struct hfp_slc_info {
>   	unsigned int hf_features;
>   	unsigned char cind_pos[HFP_INDICATOR_LAST];
>   	unsigned int cind_val[HFP_INDICATOR_LAST];
> +	unsigned char *codecs;
> +	int codecs_len;
>   };
>
> -void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version);
> +void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version,
> +					unsigned char *codecs, int len);
>   void hfp_slc_info_free(struct hfp_slc_info *info);
>
>   void hfp_slc_establish(struct hfp_slc_info *info, hfp_slc_cb_t connect_=
cb,
> diff --git a/plugins/hfp_hf_bluez4.c b/plugins/hfp_hf_bluez4.c
> index 450c183..f27b0e1 100644
> --- a/plugins/hfp_hf_bluez4.c
> +++ b/plugins/hfp_hf_bluez4.c
> @@ -165,12 +165,15 @@ static DBusMessage *hfp_agent_new_connection(DBusCo=
nnection *conn,
>   	struct ofono_modem *modem =3D data;
>   	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
>   	guint16 version;
> +	unsigned char codecs[1];
>
>   	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD,&fd,
>   				DBUS_TYPE_UINT16,&version, DBUS_TYPE_INVALID))
>   		return __ofono_error_invalid_args(msg);
>
> -	hfp_slc_info_init(&hfp_data->info, version);
> +	memset(&codecs, 0, sizeof(codecs));
> +	codecs[0] =3D HFP_CODEC_CVSD;
> +	hfp_slc_info_init(&hfp_data->info, version, codecs, 1);

Why do you need this info for HFP 1.5?

>
>   	err =3D service_level_connection(modem, fd);
>   	if (err<  0&&  err !=3D -EINPROGRESS)
> diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> index 26f96d0..63590a9 100644
> --- a/plugins/phonesim.c
> +++ b/plugins/phonesim.c
> @@ -885,8 +885,7 @@ static void slc_failed(gpointer userdata)
>
>   	ofono_modem_set_powered(modem, FALSE);
>
> -	g_at_chat_unref(info->chat);
> -	info->chat =3D NULL;
> +	hfp_slc_info_free(info);
>   }
>
>   static int localhfp_enable(struct ofono_modem *modem)
> @@ -896,6 +895,7 @@ static int localhfp_enable(struct ofono_modem *modem)
>   	GAtSyntax *syntax;
>   	GAtChat *chat;
>   	const char *address;
> +	unsigned char codecs[1];
>   	int sk, port;
>
>   	address =3D ofono_modem_get_string(modem, "Address");
> @@ -929,7 +929,10 @@ static int localhfp_enable(struct ofono_modem *modem)
>
>   	g_at_chat_set_disconnect_function(chat, slc_failed, modem);
>
> -	hfp_slc_info_init(info, HFP_VERSION_LATEST);
> +	memset(codecs, 0, sizeof(codecs));
> +	codecs[0] =3D HFP_CODEC_CVSD;
> +
> +	hfp_slc_info_init(info, HFP_VERSION_LATEST, codecs, 1);
>   	info->chat =3D chat;
>   	hfp_slc_establish(info, slc_established, slc_failed, modem);
>
> @@ -940,8 +943,7 @@ static int localhfp_disable(struct ofono_modem *modem)
>   {
>   	struct hfp_slc_info *info =3D ofono_modem_get_data(modem);
>
> -	g_at_chat_unref(info->chat);
> -	info->chat =3D NULL;
> +	hfp_slc_info_free(info);
>
>   	return 0;
>   }

Regards,
-Denis

--===============7798093885401516145==--

