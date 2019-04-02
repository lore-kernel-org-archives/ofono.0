Content-Type: multipart/mixed; boundary="===============2141109085388171659=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] xmm7modem: handling of dual sim single active feature
Date: Tue, 02 Apr 2019 10:36:09 -0500
Message-ID: <421f874a-4b7d-2dd9-9b6b-4db95f89ebba@gmail.com>
In-Reply-To: <1554186242-31487-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2141109085388171659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 04/02/2019 01:24 AM, Antara Borwankar wrote:
> Handled DSSA use case for xmm7modem. Added driver function
> to switch between available card slots for SIM.
> =

> Only one SIM will be active at a given time. On calling this
> function the active SIM will be removed and the card slot made
> inactive and SIM in the other card slot will be made active.
> =

> Use case is similar to a SIM swap/change where one SIM is replaced
> another SIM in the same slot.
> ---
>   drivers/atmodem/sim.c | 124 +++++++++++++++++++++++++++++++++++++++++++=
++++++-
>   1 file changed, 123 insertions(+), 1 deletion(-)

I went ahead and applied this one with one minor amendment:

> +static void at_xcmscsc_test_cb(gboolean ok, GAtResult *result, gpointer =
user)
> +{
> +	struct ofono_sim *sim =3D user;
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +	GAtResultIter iter;
> +	int card_slot_count;
> +
> +	if (!ok)
> +		goto done;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+XCMSCSC:"))
> +		goto done;
> +
> +	g_at_result_iter_skip_next(&iter);
> +	g_at_result_iter_skip_next(&iter);
> +
> +	if (!g_at_result_iter_open_list(&iter))
> +		goto done;
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	if (!g_at_result_iter_next_number(&iter, &card_slot_count))
> +		goto done;
> +
> +	/* Set num slots */
> +	ofono_sim_set_card_slot_count(sim, card_slot_count+1);
> +
> +	/* enable reporting of MSIM remap status information
> +	   and enable automatic acceptance of MSIM Remap
> +	   acknowledgement. */
> +	g_at_chat_send(sd->chat, "AT+XCMSRS=3D2", none_prefix,
> +					NULL, NULL, NULL);
> +
> +	/* Query active card slot */
> +	g_at_chat_send(sd->chat, "AT+XCMSCSC?", xcmscsc_prefix,
> +				xcmscsc_query_cb, sim, NULL);
> +

I added a return here so as not to generate multiple CLCK queries

> +done:
> +	/* Query supported <fac>s */
> +	g_at_chat_send(sd->chat, "AT+CLCK=3D?", clck_prefix,
> +				at_clck_query_cb, sim, NULL);
> +}
> +
>   static int at_sim_probe(struct ofono_sim *sim, unsigned int vendor,
>   				void *data)
>   {

Regards,
-Denis

--===============2141109085388171659==--

