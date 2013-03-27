Content-Type: multipart/mixed; boundary="===============5839760595311118750=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] hfp_hf_bluez5: Add a card driver for HFP 1.6
Date: Tue, 26 Mar 2013 23:43:36 -0500
Message-ID: <515278F8.2010807@gmail.com>
In-Reply-To: <1364249122-18332-4-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5839760595311118750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 03/25/2013 05:05 PM, Vinicius Costa Gomes wrote:
> This is just the skeleton of a Handsfree Audio Card for the HF side of
> HFP 1.6.
> ---
>   plugins/hfp_hf_bluez5.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index ff8afba..89b60c8 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -60,6 +60,8 @@
>
>   #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
>
> +#define HFP16_HF_DRIVER		"hfp16-hf-driver"
> +
>   struct hfp {
>   	struct hfp_slc_info info;
>   	DBusMessage *msg;
> @@ -310,6 +312,31 @@ static struct ofono_modem_driver hfp_driver =3D {
>   	.post_sim	=3D hfp_post_sim,
>   };
>
> +static int hfp16_card_probe(struct ofono_handsfree_card *card,
> +					unsigned int vendor, void *data)
> +{
> +	return 0;
> +}
> +
> +static void hfp16_card_remove(struct ofono_handsfree_card *card)
> +{
> +
> +}
> +
> +static int hfp16_card_connect(struct ofono_handsfree_card *card,
> +					ofono_handsfree_card_connect_cb_t cb,
> +					void *data)
> +{
> +	return -ENOSYS;

This function should be declared to return void to be consistent with =

everything else.  Whoops.  My fault.  I fixed it upstream.

> +}
> +
> +static struct ofono_handsfree_card_driver hfp16_hf_driver =3D {
> +	.name		=3D HFP16_HF_DRIVER,
> +	.probe		=3D hfp16_card_probe,
> +	.remove		=3D hfp16_card_remove,
> +	.connect	=3D hfp16_card_connect,
> +};
> +
>   static ofono_bool_t device_path_compare(struct ofono_modem *modem,
>   					void *userdata)
>   {
> @@ -616,6 +643,13 @@ static int hfp_init(void)
>   		return -EIO;
>   	}
>
> +	err =3D ofono_handsfree_card_driver_register(&hfp16_hf_driver);
> +	if (err<  0) {
> +		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
> +						BLUEZ_PROFILE_INTERFACE);
> +		return err;
> +	}
> +
>   	err =3D ofono_modem_driver_register(&hfp_driver);
>   	if (err<  0) {
>   		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
> @@ -647,6 +681,9 @@ static void hfp_exit(void)
>   	bt_unregister_profile(conn, HFP_EXT_PROFILE_PATH);
>   	g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
>   						BLUEZ_PROFILE_INTERFACE);
> +
> +	ofono_handsfree_card_driver_unregister(&hfp16_hf_driver);
> +
>   	ofono_modem_driver_unregister(&hfp_driver);
>   	g_dbus_client_unref(bluez);
>

Regards,
-Denis

--===============5839760595311118750==--

