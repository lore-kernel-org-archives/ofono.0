Content-Type: multipart/mixed; boundary="===============1032708301698351772=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: fix crash in case of invalid sim password type
Date: Mon, 07 Aug 2017 14:19:30 -0500
Message-ID: <ecbf6c15-96a2-adf9-97c0-2c83b6e2a842@gmail.com>
In-Reply-To: <1498636003-24999-2-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1032708301698351772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 06/28/2017 02:46 AM, Christophe Ronco wrote:
> Crash seen in sim_pin_query_cb if pin type is OFONO_SIM_PASSWORD_INVALID
> ---
>  src/sim.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/sim.c b/src/sim.c
> index ac5b6fd..aa4190f 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -145,6 +145,7 @@ static const char *const passwd_name[] =3D {
>  	[OFONO_SIM_PASSWORD_PHSP_PUK] =3D "servicepuk",
>  	[OFONO_SIM_PASSWORD_PHCORP_PIN] =3D "corp",
>  	[OFONO_SIM_PASSWORD_PHCORP_PUK] =3D "corppuk",
> +	[OFONO_SIM_PASSWORD_INVALID] =3D "invalid",

This seems wrong, the driver should not be reporting an invalid PIN type.

>  };
>
>  static void sim_own_numbers_update(struct ofono_sim *sim);
>

Regards,
-Denis

--===============1032708301698351772==--

