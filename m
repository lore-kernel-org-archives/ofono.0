Content-Type: multipart/mixed; boundary="===============8491140443931702449=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Check modem device open failure
Date: Tue, 26 Apr 2011 14:53:59 -0500
Message-ID: <4DB722D7.7020206@gmail.com>
In-Reply-To: <1303808863-831-2-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8491140443931702449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 04/26/2011 04:07 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> disable gprs function if open modem device file failed, Otherwise, it
> will cause ofonod crash, due to gatchat is NULL.
> ---
>  plugins/huawei.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index 4051a93..1f69a8c 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -475,9 +475,10 @@ static void huawei_disconnect(gpointer user_data)
>  	data->modem =3D NULL;
>  =

>  	data->modem =3D open_device(modem, "Modem", "Modem: ");
> -	if (data->modem =3D=3D NULL)
> +	if (data->modem =3D=3D NULL) {
> +		ofono_error("open device failed!");
>  		return;
> -
> +	}
>  	g_at_chat_set_disconnect_function(data->modem,
>  						huawei_disconnect, modem);
>  =


I dropped this chunk from the patch, I didn't think it was adding
anything useful.

> @@ -681,8 +682,9 @@ static void huawei_post_online(struct ofono_modem *mo=
dem)
>  	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
>  						"atmodem", data->pcui);
>  =

> -	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> -			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
> +	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> +			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) &&
> +			data->modem !=3D NULL) {
>  		data->gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
>  						"atmodem", data->pcui);
>  =


This chunk has been applied with a slightly reworded commit message.
Thanks for that.

Regards,
-Denis

--===============8491140443931702449==--

