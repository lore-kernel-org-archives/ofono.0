Content-Type: multipart/mixed; boundary="===============5360625503178283348=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] MC7430: use qmimodem sim driver
Date: Tue, 03 Jan 2017 10:43:21 -0600
Message-ID: <0e2774d3-ca86-d82e-36e0-5a10bb43396a@gmail.com>
In-Reply-To: <20161228150402.15660-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5360625503178283348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 12/28/2016 09:03 AM, Christophe Ronco wrote:
> QMI modem sim-legacy driver uses a command not supported by MC7430 (QMI_D=
MS_GET_PIN_STATUS)
>
> plugins/udevng.c
>  QMI Sierra modems use sim driver.
> drivers/qmimodem/sim.c
>  In get_card_status_cb, call ofono_sim_register after ofono_sim_inserted_=
notify (as it is done in sim_legacy).
>  Otherwise process crash (sim->driver->query_facility_lock called and not=
 defined in this driver) with  MC7430 modem using this driver.

This seems to be caused by a bug in the core.  However, looking at =

src/sim.c ofono_sim_inserted_notify(), I see that the =

query_facility_lock call is guarded:

                 if (sim->driver->query_facility_lock) {
                         sim->driver->query_facility_lock(sim,
                                         OFONO_SIM_PASSWORD_PHSIM_PIN,
                                         sim_query_fac_imsilock_cb, sim);

                 } else {
                         sim_initialize(sim);
                 }

Are you using latest upstream code?  Any chance you can provide a backtrace?

> ---
>  drivers/qmimodem/sim.c | 3 +--
>  plugins/udevng.c       | 2 --

These need to be 2 separate commits.  See HACKING, 'Submitting patches' =

section.

>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
> index 197da509..fa7bef58 100644
> --- a/drivers/qmimodem/sim.c
> +++ b/drivers/qmimodem/sim.c
> @@ -403,8 +403,6 @@ static void get_card_status_cb(struct qmi_result *res=
ult, void *user_data)
>  	}
>
>  done:
> -	ofono_sim_register(sim);
> -
>  	switch (data->card_state) {
>  	case 0x00:	/* Absent */
>  	case 0x02:	/* Error */
> @@ -413,6 +411,7 @@ done:
>  		ofono_sim_inserted_notify(sim, TRUE);
>  		break;
>  	}
> +	ofono_sim_register(sim);

This seems to be working around a bug in the core (src/sim.c).  See above.

>  }
>
>  static void event_registration_cb(struct qmi_result *result, void *user_=
data)
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 933bf4fa..a2866b64 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -252,8 +252,6 @@ static gboolean setup_sierra(struct modem_info *modem)
>
>  	if (qmi !=3D NULL && net !=3D NULL) {
>  		ofono_modem_set_driver(modem->modem, "gobi");
> -		/* Fixup SIM interface for Sierra QMI devices */
> -		ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
>  		goto done;
>  	}
>
>

Regards,
-Denis

--===============5360625503178283348==--

