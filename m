Content-Type: multipart/mixed; boundary="===============7881967332737538423=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 4/4] sim: Get IMSI if sim state is
 OFONO_SIM_STATE_INSERTED
Date: Sun, 27 Nov 2011 06:08:24 -0600
Message-ID: <4ED22838.6050708@gmail.com>
In-Reply-To: <1321872845-24754-5-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7881967332737538423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 11/21/2011 04:54 AM, Guillaume Zajac wrote:
> In case of CDAM modem sim can be embedded so that at AT+CPIN? query
> answer is +CME ERROR: 10 sim not inserted.
> We have to ignore this error and try to initialize the sim to
> retrieve the IMSI.
> ---
>  src/sim.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index d1d55c5..2c6fbe2 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -2406,6 +2406,8 @@ checkdone:
>  		sim_initialize_after_pin(sim);
>  		break;
>  	default:
> +		if (sim->state =3D=3D OFONO_SIM_STATE_INSERTED)
> +			sim_initialize_after_pin(sim);

I'm almost certain this will break the GSM state machine.

What is meant by an 'embedded' SIM here?  Are you saying that the IMSI
query succeeds even if the SIM is not present?  If so, are you sure it
isn't a timing / race condition issue?

>  		break;
>  	}
>  }

Regards,
-Denis

--===============7881967332737538423==--

