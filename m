Content-Type: multipart/mixed; boundary="===============9186958968897389054=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/3] hfp_hf_bluez5: Register the SDP record with
 correct features
Date: Thu, 25 Apr 2013 03:41:04 -0500
Message-ID: <5178EC20.7000306@gmail.com>
In-Reply-To: <1366752112-8007-3-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9186958968897389054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/23/2013 04:21 PM, Vinicius Costa Gomes wrote:
> ---
>   plugins/hfp_hf_bluez5.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>

Patch has been applied, thanks.

> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index 826796f..06b6fd3 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -636,10 +636,15 @@ static const GDBusMethodTable profile_methods[] =3D=
 {
>
>   static void connect_handler(DBusConnection *conn, void *user_data)
>   {
> +	uint16_t features =3D HFP_SDP_HF_FEATURE_3WAY |
> +				HFP_SDP_HF_FEATURE_CLIP |
> +				HFP_SDP_HF_FEATURE_REMOTE_VOLUME_CONTROL |
> +				HFP_SDP_HF_FEATURE_WIDEBAND_SPEECH;
> +

Can we check whether the kernel supports wideband speech features here =

and not set this flag if it does not?

>   	DBG("Registering External Profile handler ...");
>
>   	bt_register_profile(conn, HFP_HS_UUID, HFP_VERSION_1_6, "hfp_hf",
> -					HFP_EXT_PROFILE_PATH, NULL, 0);
> +					HFP_EXT_PROFILE_PATH, NULL, features);
>   }
>
>   static gboolean has_hfp_ag_uuid(DBusMessageIter *array)

Regards,
-Denis

--===============9186958968897389054==--

