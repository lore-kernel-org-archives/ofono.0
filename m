Content-Type: multipart/mixed; boundary="===============6202242167211564752=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH V2 3/8] hfpmodem: Send last call dialled request
Date: Fri, 03 Nov 2017 13:32:19 -0500
Message-ID: <119cf4b4-f2b2-9468-fd70-d455b209dd0f@gmail.com>
In-Reply-To: <20171031083939.4393-4-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6202242167211564752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 10/31/2017 03:39 AM, Philippe De Swert wrote:
> Handle the last call dialled request and send the required AT+BDLN command
> for bluetooth HFP profile.
> ---
>   drivers/hfpmodem/voicecall.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> =


Applied with an amendment, see below:

> diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
> index ffdf4b7b..fc5210bb 100644
> --- a/drivers/hfpmodem/voicecall.c
> +++ b/drivers/hfpmodem/voicecall.c
> @@ -404,6 +404,25 @@ static void hfp_dial(struct ofono_voicecall *vc,
>   	CALLBACK_WITH_FAILURE(cb, data);
>   }
>   =

> +static void hfp_dial_last(struct ofono_voicecall *vc, ofono_voicecall_cb=
_t cb,
> +			void *data)
> +{
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[256];
> +
> +	cbd->user =3D vc;
> +	snprintf(buf, sizeof(buf), "AT+BLDN");
> +
> +	if (g_at_chat_send(vd->chat, buf, none_prefix,

Since you don't need buf or snprintf here (you can simply send "AT+BLDN" =

instead of buf), I silently amended the commit to do that.

> +				atd_cb, cbd, g_free) > 0)
> +		return;
> +
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +
> +}

Regards,
-Denis

--===============6202242167211564752==--

