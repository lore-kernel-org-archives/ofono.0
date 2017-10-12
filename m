Content-Type: multipart/mixed; boundary="===============8189095133065223357=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4 4/6] phonesim: Added sim-auth to phonesim plugin
Date: Thu, 12 Oct 2017 09:54:20 -0500
Message-ID: <074c32d8-2c73-5966-061f-ab9dfbb90561@gmail.com>
In-Reply-To: <1507764139-12915-4-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8189095133065223357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/11/2017 06:22 PM, James Prestwood wrote:
> ---
>   plugins/phonesim.c | 4 ++++
>   1 file changed, 4 insertions(+)
> =

> diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> index 16bccd5..345c41e 100644
> --- a/plugins/phonesim.c
> +++ b/plugins/phonesim.c
> @@ -61,6 +61,7 @@
>   #include <ofono/gnss.h>
>   #include <ofono/handsfree.h>
>   #include <ofono/siri.h>
> +#include <ofono/sim-auth.h>
>   =

>   #include <drivers/atmodem/vendor.h>
>   #include <drivers/atmodem/atutil.h>
> @@ -84,6 +85,7 @@ struct phonesim_data {
>   	unsigned int hfp_watch;
>   	int batt_level;
>   	struct ofono_sim *sim;
> +	struct ofono_sim_auth *sim_auth;

No need to track this...

>   };
>   =

>   struct gprs_context_data {
> @@ -839,6 +841,8 @@ static void phonesim_pre_sim(struct ofono_modem *mode=
m)
>   		ofono_voicecall_create(modem, 0, "calypsomodem", data->chat);
>   	else
>   		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
> +
> +	data->sim_auth =3D ofono_sim_auth_create(modem, 0, "atmodem", data->cha=
t);

Put this inside post_sim.

>   }
>   =

>   static void phonesim_post_sim(struct ofono_modem *modem)
> =


Regards,
-Denis

--===============8189095133065223357==--

