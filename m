Content-Type: multipart/mixed; boundary="===============5136062282284295429=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4 3/6] xmm7xxx: add sim-auth driver to xmm7xxx plugin
Date: Thu, 12 Oct 2017 09:53:42 -0500
Message-ID: <b0ee2345-df40-6232-12b6-adbc49b945e0@gmail.com>
In-Reply-To: <1507764139-12915-3-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5136062282284295429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/11/2017 06:22 PM, James Prestwood wrote:
> ---
>   plugins/xmm7xxx.c | 3 +++
>   1 file changed, 3 insertions(+)
> =

> diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
> index 5cb843b..ff0cb4c 100644
> --- a/plugins/xmm7xxx.c
> +++ b/plugins/xmm7xxx.c
> @@ -49,6 +49,7 @@
>   #include <ofono/stk.h>
>   #include <ofono/lte.h>
>   #include <ofono/ims.h>
> +#include <ofono/sim-auth.h>
>   =

>   #include <drivers/atmodem/atutil.h>
>   #include <drivers/atmodem/vendor.h>
> @@ -61,6 +62,7 @@ struct xmm7xxx_data {
>   	struct ofono_sim *sim;
>   	ofono_bool_t have_sim;
>   	ofono_bool_t sms_phonebook_added;
> +	struct ofono_sim_auth *sim_auth;

No need to make this a member variable.  Just treat it like the other =

atoms.  'sim' atom is nearly always special.

>   };
>   =

>   static void xmm7xxx_debug(const char *str, void *user_data)
> @@ -286,6 +288,7 @@ static void xmm7xxx_pre_sim(struct ofono_modem *modem)
>   	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
>   	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_IFX, "atmodem",
>   					data->chat);
> +	data->sim_auth =3D ofono_sim_auth_create(modem, 0, "atmodem", data->cha=
t);

This belongs in post_sim.  If the SIM is PIN locked, then the =

application discovery will fail.

>   }
>   =

>   static void set_online_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> =


Regards,
-Denis

--===============5136062282284295429==--

