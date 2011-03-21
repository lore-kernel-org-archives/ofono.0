Content-Type: multipart/mixed; boundary="===============5416938134179256594=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] netreg: add +COPS support for HFP emulator
Date: Mon, 21 Mar 2011 14:13:47 -0500
Message-ID: <4D87A36B.70000@gmail.com>
In-Reply-To: <1300718447-8033-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5416938134179256594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

> @@ -1968,6 +2024,13 @@ void ofono_netreg_register(struct ofono_netreg *ne=
treg)
>  	netreg->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
>  					OFONO_ATOM_TYPE_EMULATOR_HFP,
>  					emulator_hfp_watch, netreg, NULL);
> +
> +	hfp_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HF=
P);
> +
> +	if (hfp_atom && __ofono_atom_get_registered(hfp_atom))
> +		emulator_hfp_watch(hfp_atom,
> +					OFONO_ATOM_WATCH_CONDITION_REGISTERED,
> +					netreg);

There might be multiple HFP_EMULATOR atoms, so you should use
__ofono_modem_foreach_atom() here

Rest of the patch looks fine to me.

Regards,
-Denis

--===============5416938134179256594==--

