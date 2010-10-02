Content-Type: multipart/mixed; boundary="===============5902418697729330100=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 1/4] sim: check if FD is enabled in the SIM-card
Date: Sat, 02 Oct 2010 08:22:38 +0200
Message-ID: <1286000558.4231.35.camel@aeonflux>
In-Reply-To: <1285949201-2994-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5902418697729330100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri Tikander,

> ---
>  drivers/atmodem/sim.c |   23 +++++++++++++++++++++
>  include/sim.h         |    3 ++
>  src/sim.c             |   52 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 78 insertions(+), 0 deletions(-)

these need to be split into two separate patches no matter what. First
one is adding a feature to the core. The other is implementing it in the
atom driver.

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index d0a7148..854ba08 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -831,6 +831,28 @@ error:
>  	CALLBACK_WITH_FAILURE(cb, -1, data);
>  }
>  =

> +static void at_barring_query_enabled(struct ofono_sim *sim,
> +				ofono_sim_locked_cb_t cb, void *data)
> +{
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[64];
> +
> +	if (!cbd)
> +		goto error;
> +
> +	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"FD\",2");
> +
> +	if (g_at_chat_send(sd->chat, buf, clck_prefix,
> +				at_lock_status_cb, cbd, g_free) > 0)
> +		return;
> +
> +error:
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, -1, data);
> +}
> +
>  static gboolean at_sim_register(gpointer user)
>  {
>  	struct ofono_sim *sim =3D user;
> @@ -898,6 +920,7 @@ static struct ofono_sim_driver driver =3D {
>  	.lock			=3D at_pin_enable,
>  	.change_passwd		=3D at_change_passwd,
>  	.query_locked		=3D at_pin_query_enabled,
> +	.query_call_barred	=3D at_barring_query_enabled,
>  };
>  =

>  void at_sim_init()
> diff --git a/include/sim.h b/include/sim.h
> index 42b19bd..e73a995 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -74,6 +74,7 @@ enum ofono_sim_cphs_phase {
>  enum ofono_sim_state {
>  	OFONO_SIM_STATE_NOT_PRESENT,
>  	OFONO_SIM_STATE_INSERTED,
> +	OFONO_SIM_STATE_FAILED,
>  	OFONO_SIM_STATE_READY,
>  };

I know that you guys talked with Denis about this, so I might be just
missing something here.

The requirement for minimum FDN support is really to power down the
modem and not leave it in pre_sim state for emergency calls?

Regards

Marcel



--===============5902418697729330100==--

