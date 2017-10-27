Content-Type: multipart/mixed; boundary="===============5751922724450385075=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Move atom registration to the end of
 ofono_sim_register
Date: Fri, 27 Oct 2017 08:56:23 -0500
Message-ID: <0e39cdc6-7c4b-c773-0019-69a4849c3527@gmail.com>
In-Reply-To: <1509110159-15652-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5751922724450385075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 10/27/2017 08:15 AM, Slava Monich wrote:
> The state needs to be checked prior to calling __ofono_atom_register
> because atom registration calls OFONO_ATOM_WATCH_CONDITION_REGISTERED
> callbacks each of which may call ofono_sim_inserted_notify. Should
> that happen, by the time __ofono_atom_register returns, ofono_sim
> will be in OFONO_SIM_STATE_INSERTED state and sim_initialize will
> be called twice if the initial state was OFONO_SIM_STATE_NOT_PRESENT.

Okay, can you tell me why you would have such a setup?  sim_inserted is =

generally either called from the modem driver or when an unsolicited =

notification occurs.  Not when the sim atom is registered.

> If nothing else, that results in memory leaks like this one (because
> IMSI will be queried twice, among other things):
> =

> =3D=3D3017=3D=3D 16 bytes in 1 blocks are definitely lost in loss record =
187 of 475
> =3D=3D3017=3D=3D    at 0x483F380: malloc (vg_replace_malloc.c:296)
> =3D=3D3017=3D=3D    by 0x4AFB0DF: g_malloc (gmem.c:94)
> =3D=3D3017=3D=3D    by 0x4B12185: g_strdup (gstrfuncs.c:363)
> =3D=3D3017=3D=3D    by 0xF79D3: sim_imsi_obtained (sim.c:1535)
> =3D=3D3017=3D=3D    by 0xF7BB3: sim_imsi_cb (sim.c:1594)
> =3D=3D3017=3D=3D    by 0x66C23: at_cimi_cb (sim.c:441)
> =3D=3D3017=3D=3D    by 0xA6B53: at_chat_finish_command (gatchat.c:459)
> =3D=3D3017=3D=3D    by 0xA6D9F: at_chat_handle_command_response (gatchat.=
c:521)
> =3D=3D3017=3D=3D    by 0xA70AF: have_line (gatchat.c:600)
> =3D=3D3017=3D=3D    by 0xA76DF: new_bytes (gatchat.c:759)
> =3D=3D3017=3D=3D    by 0xABACF: received_data (gatio.c:122)
> =3D=3D3017=3D=3D    by 0xAD093: watch_dispatch (gatmux.c:461)
> =3D=3D3017=3D=3D    by 0xAC5D3: dispatch_sources (gatmux.c:180)
> =3D=3D3017=3D=3D    by 0xAC98F: received_data (gatmux.c:265)
> =3D=3D3017=3D=3D    by 0x4AF606F: g_main_dispatch (gmain.c:3154)
> =3D=3D3017=3D=3D    by 0x4AF606F: g_main_context_dispatch (gmain.c:3769)
> =3D=3D3017=3D=3D    by 0x4AF631D: g_main_context_iterate.isra.4 (gmain.c:=
3840)
> =3D=3D3017=3D=3D    by 0x4AF658F: g_main_loop_run (gmain.c:4034)
> =3D=3D3017=3D=3D    by 0xBE8AF: main (main.c:261)
> ---
>   src/sim.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index 88c0421..155f421 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -3108,8 +3108,6 @@ void ofono_sim_register(struct ofono_sim *sim)
>   	sim->spn_watches =3D __ofono_watchlist_new(g_free);
>   	sim->simfs =3D sim_fs_new(sim, sim->driver);
>   =

> -	__ofono_atom_register(sim->atom, sim_unregister);
> -
>   	ofono_sim_add_state_watch(sim, sim_ready, sim, NULL);
>   =

>   	if (sim->state > OFONO_SIM_STATE_NOT_PRESENT)
> @@ -3118,6 +3116,8 @@ void ofono_sim_register(struct ofono_sim *sim)
>   	sim->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
>   					OFONO_ATOM_TYPE_EMULATOR_HFP,
>   					emulator_hfp_watch, sim, NULL);
> +
> +	__ofono_atom_register(sim->atom, sim_unregister);
>   }
>   =

>   void ofono_sim_remove(struct ofono_sim *sim)
> =


Anyhow, there's no harm in this patch, so applied.

Regards,
-Denis

--===============5751922724450385075==--

