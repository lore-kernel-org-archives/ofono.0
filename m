Content-Type: multipart/mixed; boundary="===============6449077256739524440=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [PATCH 3/5] qmi: provide AvailableTechnologies in radio-settings
Date: Thu, 07 Sep 2017 14:50:39 +0200
Message-ID: <c640d600-61f0-1d2c-1473-1ce70b2a1990@kerlink.fr>
In-Reply-To: <20170907121136.13520-3-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6449077256739524440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,


On 09/07/2017 02:11 PM, Jonas Bonn wrote:
> This provides the list of available technologies in the radio-settings
> atom.  Note that this list is hard-coded and includes LTE unconditionally
> which is probably not correct for all QMI devices.
You might want to use QMI_DMS_GET_CAPS message from dms service to do =

that. This is already used in plugins/gobi.c (even if returned =

information seems to be used only for debug).
On an MC7304 (Sierra), I have:
root(a)klk-lpbs-0504B4:~ # qmicli -d /dev/cdc-wdm0 --dms-get-capabilities
[07 Sep 2017, 12:49:11] -Warning ** [/dev/cdc-wdm0] requested auto mode =

but no MBIM QMUX support available
[/dev/cdc-wdm0] Device capabilities retrieved:
         Max TX channel rate: '50000000'
         Max RX channel rate: '100000000'
                Data Service: 'non-simultaneous-cs-ps'
                         SIM: 'supported'
                    Networks: 'gsm, umts, lte'

Best Regards,

Christophe

> ---
>   drivers/qmimodem/radio-settings.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-s=
ettings.c
> index ed578f8..fecde82 100644
> --- a/drivers/qmimodem/radio-settings.c
> +++ b/drivers/qmimodem/radio-settings.c
> @@ -155,6 +155,19 @@ static void qmi_set_rat_mode(struct ofono_radio_sett=
ings *rs,
>   }
>   =

>   =

> +static void qmi_query_available_rats(struct ofono_radio_settings *rs,
> +			ofono_radio_settings_available_rats_query_cb_t cb,
> +			void *data)
> +{
> +	unsigned int available_rats;
> +
> +	available_rats =3D OFONO_RADIO_ACCESS_MODE_GSM
> +				| OFONO_RADIO_ACCESS_MODE_UMTS
> +				| OFONO_RADIO_ACCESS_MODE_LTE;
> +
> +	CALLBACK_WITH_SUCCESS(cb, available_rats, data);
> +}
> +
>   static void create_nas_cb(struct qmi_service *service, void *user_data)
>   {
>   	struct ofono_radio_settings *rs =3D user_data;
> @@ -219,6 +232,7 @@ static struct ofono_radio_settings_driver driver =3D {
>   	.remove		=3D qmi_radio_settings_remove,
>   	.set_rat_mode	=3D qmi_set_rat_mode,
>   	.query_rat_mode =3D qmi_query_rat_mode,
> +	.query_available_rats =3D qmi_query_available_rats,
>   };
>   =

>   void qmi_radio_settings_init(void)


--===============6449077256739524440==--

