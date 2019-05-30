Content-Type: multipart/mixed; boundary="===============5076700156037853015=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] xmm7modem: enabling simtoolkit for xmm7modem
Date: Thu, 30 May 2019 11:06:35 -0500
Message-ID: <1d974e87-77c3-7361-31b9-462fbc48e607@gmail.com>
In-Reply-To: <1559208319-3719-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5076700156037853015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 05/30/2019 04:25 AM, Antara Borwankar wrote:
> added code to create stk atom in xmm7modem plugin
> ---
>   plugins/xmm7xxx.c | 1 +
>   1 file changed, 1 insertion(+)
> =

> diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
> index 23a7d4e..da6622b 100644
> --- a/plugins/xmm7xxx.c
> +++ b/plugins/xmm7xxx.c
> @@ -1225,6 +1225,7 @@ static void xmm7xxx_pre_sim(struct ofono_modem *mod=
em)
>   	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
>   	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_XMM, "atmodem",
>   					data->chat);
> +	ofono_stk_create(modem, OFONO_VENDOR_XMM, "atmodem", data->chat);

Why pre_sim?  Generally the SIM needs to be initialized before any part =

of STK makes sense...  Also, that atom isn't really setup to be used =

when no SIM is inserted for example.

>   }
>   =

>   static void set_online_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> =


Regards,
-Denis

--===============5076700156037853015==--

