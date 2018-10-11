Content-Type: multipart/mixed; boundary="===============0795933991422380662=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 4/6] src/modem: notify lte driver before going online
Date: Thu, 11 Oct 2018 22:19:38 +0200
Message-ID: <8966c3c6-2a82-c0ae-bb59-6acb93bbd3c8@southpole.se>
In-Reply-To: <20181010065454.15232-5-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0795933991422380662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 10/10/18 08:54, Giacinto Cifelli wrote:
> ---
>   src/modem.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/src/modem.c b/src/modem.c
> index 9e254482..74dbe7ad 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -729,6 +729,8 @@ static void sim_state_watch(enum ofono_sim_state new_=
state, void *user)
>   	case OFONO_SIM_STATE_READY:
>   		modem_change_state(modem, MODEM_STATE_OFFLINE);
>   =

> +		ofono_lte_set_reg_info(modem);
> +

modem_change_state(...OFFLINE) results in the post_sim() implementation =

being called.=C2=A0 The drivers that implement the lte atom all call =

ofono_lte_create() there.

Your .._set_reg_info function checks for the existence of the atom and =

does some work.=C2=A0 As such, why not just merge the contents of =

ofono_lte_set_reg_info() into the at_lte_probe function instead... from =

there, it's more obvious what's going on.

/Jonas


>   		/* Modem is always online, proceed to online state. */
>   		if (modem_is_always_online(modem) =3D=3D TRUE)
>   			set_online(modem, TRUE);


--===============0795933991422380662==--

