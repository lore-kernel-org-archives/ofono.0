Content-Type: multipart/mixed; boundary="===============1724921495114070551=="
MIME-Version: 1.0
From: Borwankar, Antara <antara.borwankar@intel.com>
Subject: RE: [PATCH 2/2] xmm7modem: enabling simtoolkit for xmm7modem
Date: Fri, 31 May 2019 05:25:07 +0000
Message-ID: <9BCC1739A7EADA4790E1FFF4123FB3268BB0FC01@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <1d974e87-77c3-7361-31b9-462fbc48e607@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1724921495114070551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Xmm modem send proactive command for set up menu only at sim initialization=
, also depending upon if stk is enabled. So before sim initialization we ha=
ve to make sure the stk is enabled otherwise proactive command is missed.

Regards
Antara

-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: Thursday, May 30, 2019 9:37 PM
To: Borwankar, Antara <antara.borwankar@intel.com>; ofono(a)ofono.org
Subject: Re: [PATCH 2/2] xmm7modem: enabling simtoolkit for xmm7modem

Hi Antara,

On 05/30/2019 04:25 AM, Antara Borwankar wrote:
> added code to create stk atom in xmm7modem plugin
> ---
>   plugins/xmm7xxx.c | 1 +
>   1 file changed, 1 insertion(+)
> =

> diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c index =

> 23a7d4e..da6622b 100644
> --- a/plugins/xmm7xxx.c
> +++ b/plugins/xmm7xxx.c
> @@ -1225,6 +1225,7 @@ static void xmm7xxx_pre_sim(struct ofono_modem *mod=
em)
>   	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
>   	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_XMM, "atmodem",
>   					data->chat);
> +	ofono_stk_create(modem, OFONO_VENDOR_XMM, "atmodem", data->chat);

Why pre_sim?  Generally the SIM needs to be initialized before any part of =
STK makes sense...  Also, that atom isn't really setup to be used when no S=
IM is inserted for example.

>   }
>   =

>   static void set_online_cb(gboolean ok, GAtResult *result, gpointer =

> user_data)
> =


Regards,
-Denis

--===============1724921495114070551==--

