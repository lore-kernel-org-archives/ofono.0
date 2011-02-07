Content-Type: multipart/mixed; boundary="===============7718704689473636058=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] stk: Partially handle Refresh command.
Date: Mon, 07 Feb 2011 13:56:36 -0600
Message-ID: <4D504E74.1000600@gmail.com>
In-Reply-To: <1296782434-11008-4-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7718704689473636058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> @@ -2030,6 +2042,59 @@ static gboolean handle_command_refresh(const struc=
t stk_command *cmd,
>  					cmd->refresh.icon_id.qualifier);
>  	DBG("Alpha ID: %s", cmd->refresh.alpha_id);
>  =

> +	sim_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
> +						OFONO_ATOM_TYPE_SIM);
> +	if (sim_atom)
> +		sim =3D __ofono_atom_get_data(sim_atom);
> +
> +	if (sim =3D=3D NULL) {
> +		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
> +		return TRUE;
> +	}
> +
> +	if (cmd->qualifier < 4) {
> +		int qualifier =3D stk->pending_cmd->qualifier;
> +		GSList *file_list =3D stk->pending_cmd->refresh.file_list;
> +
> +		/* Don't free the list yet */
> +		stk->pending_cmd->refresh.file_list =3D NULL;
> +
> +		/*
> +		 * Queue the TERMINAL RESPONSE before triggering potential
> +		 * file accesses.
> +		 */
> +		err =3D stk_respond(stk, rsp, stk_command_cb);
> +		if (err)
> +			stk_command_cb(&failure, stk);

So my question here is should we delay calling refresh until after our
terminal response has been accepted?

> +
> +		/* TODO: use the alphaId / icon */
> +		/* TODO: if AID is supplied, check its value */
> +		/* TODO: possibly check if a D-bus call is pending or
> +		 * an STK session ongoing. */
> +
> +		/* TODO: free some elements of the atom state */
> +
> +		switch (qualifier) {
> +		case 0:
> +			free_idle_mode_text(stk);
> +			__ofono_sim_refresh(sim, file_list, TRUE, TRUE);
> +			break;
> +		case 1:
> +			__ofono_sim_refresh(sim, file_list, FALSE, FALSE);
> +			break;
> +		case 2:
> +		case 3:
> +			free_idle_mode_text(stk);
> +			__ofono_sim_refresh(sim, file_list, FALSE, TRUE);
> +			break;
> +		}
> +
> +		g_slist_foreach(file_list, (GFunc) g_free, NULL);
> +		g_slist_free(file_list);
> +
> +		return FALSE;
> +	}
> +
>  	rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
>  	return TRUE;
>  }

Should we be handling the case where refresh is notified via
ofono_stk_proactive_command_handled_notify as well?

Regards,
-Denis

--===============7718704689473636058==--

