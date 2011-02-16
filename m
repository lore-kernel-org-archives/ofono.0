Content-Type: multipart/mixed; boundary="===============7388465462555964558=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 16/18] isimodem: sms updated with wgmodem2.5
Date: Wed, 16 Feb 2011 16:22:39 +0200
Message-ID: <AANLkTikD+LKAcNdbc33haZdBKVZ1q3xAikNK4y=M=5Bq@mail.gmail.com>
In-Reply-To: <3efcfc1e04fd1277a850cbebd7d84629241885ec.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7388465462555964558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/2/15 Andreas Westin <andreas.westin@stericsson.com>:
> From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
>
> ---
> =C2=A0drivers/isimodem/debug.c | =C2=A0 56 +++
> =C2=A0drivers/isimodem/debug.h | =C2=A0 =C2=A01 +
> =C2=A0drivers/isimodem/sms.c =C2=A0 | =C2=A0972 +++++++++++++++++++++++++=
++++++++++++++-------
> =C2=A0drivers/isimodem/sms.h =C2=A0 | =C2=A0 34 ++
> =C2=A04 files changed, 927 insertions(+), 136 deletions(-)
>
> diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
> index 33e4dcb..1fd2226 100644
> --- a/drivers/isimodem/debug.c
> +++ b/drivers/isimodem/debug.c
> @@ -53,6 +53,7 @@ const char *pn_resource_name(int value)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_(PN_GSS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_(PN_GPDS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_(PN_WRAN);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(PN_UICC);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return "PN_<UNKNOWN>";
> =C2=A0}
> @@ -218,6 +219,47 @@ const char *mce_rf_state_name(enum mce_rf_state valu=
e)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return "MCE_RF<UNKNOWN>";
> =C2=A0}
>
> +const char *uicc_message_id_name(enum uicc_message_id value)
> +{
> + =C2=A0 =C2=A0 =C2=A0 switch (value) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_IND);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_CARD_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_CARD_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_CARD_IND);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APPLICATION_REQ=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APPLICATION_RES=
P);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APPLICATION_IND=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_PIN_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_PIN_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_PIN_IND);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APPL_CMD_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APPL_CMD_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APPL_CMD_IND);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_CONNECTOR_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_CONNECTOR_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_CAT_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_CAT_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_CAT_IND);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APDU_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APDU_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APDU_RESET_IND);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_REFRESH_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_REFRESH_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_REFRESH_IND);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_SIMLOCK_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_SIMLOCK_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APDU_SAP_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APDU_SAP_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_APDU_SAP_IND);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_PWR_CTRL_REQ);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_PWR_CTRL_RESP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(UICC_PWR_CTRL_IND);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return "UICC_<UNKNOWN>";
> +}
> +

This UICC stuff seems to be leftovers form patch 8/18.

(snip)

> @@ -664,28 +1334,44 @@ static int isi_sms_probe(struct ofono_sms *sms, un=
signed int vendor,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sd =3D=3D NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;
>
> - =C2=A0 =C2=A0 =C2=A0 sd->params.absent =3D 0xFF;
> - =C2=A0 =C2=A0 =C2=A0 sd->params.alphalen =3D 1; /* Includes final UCS2-=
coded NUL */
> + =C2=A0 =C2=A0 =C2=A0 sd->sim_params.absent =3D 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 sd->sim_params.alphalen =3D 1; /* Includes final U=
CS2-coded NUL */
> +
> + =C2=A0 =C2=A0 =C2=A0 sd->usim_params.indicators =3D 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 sd->usim_params.alphalen =3D 0; /* Includes final =
UCS2-coded NUL */
> +
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sd->client =3D g_isi_client_create(modem, PN_S=
MS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sd->client =3D=3D NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto nomem;
>
> - =C2=A0 =C2=A0 =C2=A0 sd->sim =3D g_isi_client_create(modem, PN_SIM);
> + =C2=A0 =C2=A0 =C2=A0 sd->sim =3D g_isi_client_create(modem, PN_UICC);
> +

After this, the driver will no longer work with N900 or the isimodem plugin.

Cheers,
Aki

--===============7388465462555964558==--

