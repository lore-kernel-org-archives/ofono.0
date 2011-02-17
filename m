Content-Type: multipart/mixed; boundary="===============3319310195120767826=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/9] sim: Implement basic Refresh.
Date: Thu, 17 Feb 2011 15:03:01 -0600
Message-ID: <4D5D8D05.60403@gmail.com>
In-Reply-To: <1297756739-2958-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3319310195120767826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 02/15/2011 01:58 AM, Andrzej Zaborowski wrote:
> ---
>  src/ofono.h |    4 ++
>  src/sim.c   |  163 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+----
>  2 files changed, 155 insertions(+), 12 deletions(-)
> =


Patch has been applied, but some comments below:

> +	if (reinit_naa) {
> +		/* Force the sim state out of READY */
> +
> +		sim_free_main_state(sim);
> +
> +		sim->state =3D OFONO_SIM_STATE_INSERTED;
> +		for (l =3D sim->state_watches->items; l; l =3D l->next) {
> +			struct ofono_watchlist_item *item =3D l->data;
> +			notify =3D item->notify;
> +
> +			notify(sim->state, item->notify_data);
> +		}

I changed this to directly call the modem object and force it into
pre-sim state.  I think this is a bit more clear than your proposed
approach.

Another question here is whether we want to maintain two separate simfs
contexts.  One for the main state and one for the early state.  This
might make things a bit easier to implement for patch 3 in this series.

Regards,
-Denis

--===============3319310195120767826==--

