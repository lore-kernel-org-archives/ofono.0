Content-Type: multipart/mixed; boundary="===============6729958514827347650=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5][RfC] Add functions to notify core of SIM
 insertion/removal/proactive command.
Date: Thu, 01 Apr 2010 10:47:56 -0500
Message-ID: <201004011047.56997.denkenz@gmail.com>
In-Reply-To: <1270011462-6831-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6729958514827347650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Make every plugin generate a sim inserted event on start.  For devices
> with removable SIM card, the event should be emitted after the
> plugin detects it.
> ---
> +unsigned int ofono_sim_add_removed_watch(struct ofono_sim *sim,
> +				ofono_sim_ready_notify_cb_t cb,
> +				void *data, ofono_destroy_func destroy);
> +
> +void ofono_sim_remove_removed_watch(struct ofono_sim *sim, unsigned int

So let us refactor the existing SIM ready events and the SIM removed events =

into a single set of watch functions with a state enum.

e.g. something like
enum ofono_sim_state {
	OFONO_SIM_STATE_NOT_PRESENT,
	OFONO_SIM_STATE_INSERTED,
	OFONO_SIM_STATE_READY,
};

>  id); +
>  int ofono_sim_get_ready(struct ofono_sim *sim);
> -void ofono_sim_set_ready(struct ofono_sim *sim);
> +
> +void ofono_sim_inserted(struct ofono_sim *sim);
> +void ofono_sim_removed(struct ofono_sim *sim);

Lets make these into a single function with a ofono_bool_t parameter.

> +void ofono_sim_proactive_command_notify(struct ofono_sim *sim,
> +		int length, const guint8 *pdu);

Can you send this part in a separate patch?  And this belongs on a separate =

stk atom.

> +void ofono_sim_inserted(struct ofono_sim *sim)
> +{
> +	sim->inserted =3D TRUE;
> +
> +	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
> +	 * The assumption here is that if sim manager is being initialized,
> +	 * then sim commands are implemented, and the sim manager is then
> +	 * responsible for checking the PIN, reading the IMSI and signaling
> +	 * SIM ready condition.
> +	 *
> +	 * The procedure according to 31.102 is roughly:
> +	 * Read EFecc
> +	 * Read EFli and EFpl
> +	 * SIM Pin check
> +	 * Request SIM phase (only in 51.011)
> +	 * Read EFust
> +	 * Read EFest
> +	 * Read IMSI
> +	 *
> +	 * At this point we signal the SIM ready condition and allow
> +	 * arbitrary files to be written or read, assuming their presence
> +	 * in the EFust
> +	 */
> +	sim_determine_phase(sim);
> +}

The only other issue here is that you have to wait for the sim atom to =

register before you start the initialization process.  =


> +void ofono_sim_proactive_command_notify(struct ofono_sim *sim,
> +		int length, const guint8 *pdu)
> +{
> +}
> +

This belongs on a separate stk atom.

Regards,
-Denis

--===============6729958514827347650==--

