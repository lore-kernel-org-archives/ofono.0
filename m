Content-Type: multipart/mixed; boundary="===============7685499947279667564=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: showing lock state with call meter
Date: Fri, 25 Feb 2011 11:58:44 -0600
Message-ID: <4D67EDD4.2040507@gmail.com>
In-Reply-To: <1298640016-25471-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7685499947279667564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 02/25/2011 07:20 AM, Jussi Kangas wrote:
> ---
> =

> Hi,
> =

> Here is the fixed patch for enabling the showing of pin2 blocked =

> situation in SIM API when lock state changes after using call meter
> API.
> =

> Br,
> Jussi =

> =

>  include/sim.h    |    2 ++
>  src/call-meter.c |   19 +++++++++++++++++++
>  src/sim.c        |   46 +++++++++++++++++++++++++++++++---------------
>  3 files changed, 52 insertions(+), 15 deletions(-)
> =


I applied this patch, but broke it up into three separate commits:

9007bf63927b7008129a7704a8fd0649fed67065
c5b321e768a9f36ba55dc9ce39d8f28c527a57eb
07c7308581c921ad1ff70903c8534ac01e62b549

Few more comments below:

>  =

>  checkdone:
> -	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
> +	switch (pin_type) {
> +	case OFONO_SIM_PASSWORD_SIM_PIN2:
> +	case OFONO_SIM_PASSWORD_SIM_PUK2:
> +		if (sim->state =3D=3D OFONO_SIM_STATE_READY)
> +			break;
> +	case OFONO_SIM_PASSWORD_NONE:
>  		sim_initialize_after_pin(sim);
> +		break;

If we correctly enter PIN2 or unblock PIN2, do we go back to the READY
state?  If so, we might want to avoid running the initialization
procedure above.

> +	default:
> +		break;
> +	}
>  }

Regards,
-Denis

--===============7685499947279667564==--

