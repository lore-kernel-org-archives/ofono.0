Content-Type: multipart/mixed; boundary="===============4380651521278821991=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/3] isimodem: Allow network registration automatically
Date: Fri, 05 Aug 2011 11:38:15 +0300
Message-ID: <CANzBvOSx7=cvwEj73xDAWG4oZ2AuN7epejm-nNuctL7h-qmyxA@mail.gmail.com>
In-Reply-To: <6B9DA0A3415B234191A1ADFA6275C51CB2423A@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4380651521278821991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Iiro,

2011/8/3  <iiro.kaihlaniemi@nokia.com>:
> diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/n=
etwork-registration.c
> index cc48579..ffcfab4 100644
> --- a/drivers/isimodem/network-registration.c
> +++ b/drivers/isimodem/network-registration.c
> @@ -946,6 +946,84 @@ error:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(cbd);
> =C2=A0}
>
> +static void cs_access_config_resp_cb(const GIsiMessage *msg, void *data)
> +{
> + =C2=A0 =C2=A0struct ofono_netreg *netreg =3D data;
> + =C2=A0 =C2=A0struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
> + =C2=A0 =C2=A0 =C2=A0 GIsiSubBlockIter iter;
> +
> + =C2=A0 =C2=A0DBG("");
> + =C2=A0 =C2=A0if (g_isi_msg_id(msg) !=3D NET_NW_ACCESS_CONF_RESP)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;

Indent with a single tab, no spaces allowed. This applies to the rest
of the patch as well.

> + =C2=A0 =C2=A0 =C2=A0 for (g_isi_sb_iter_init(&iter, msg, 2);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_isi_sb_iter_is_valid(&iter);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_isi_sb_iter_next(&iter))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t id =3D g_isi_s=
b_iter_get_id(&iter);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t mode;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("SB=3D%02X", id);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((id =3D=3D 0x55) |=
| (id =3D=3D 0x59))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_sb_iter_get_byte=
(&iter, &mode, 2);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Reg=
 %X", mode);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((id =3D=3D 0x=
56) || (id =3D=3D 0x5A))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_sb_iter_get_byte=
(&iter, &mode, 2);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Roa=
m %X", mode);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

These subblock IDs need to be added in network.h. I would also
recommend a switch statement here for more readability.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Unk=
nown subblock");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

Regarding the entire for and if blocks above and elsewhere in the
patch, the style in oFono is to attach curly brackets on the same line
as the for/if/while statement. Please take a look at
doc/coding-style.txt.

To catch style errors early, I would recommend also using the
checkpatch.pl script before submitting.

> +}
> +
> +static void cs_state_resp_cb(const GIsiMessage *msg, void *data)
> +{
> + =C2=A0 =C2=A0struct ofono_netreg *netreg =3D data;
> + =C2=A0 =C2=A0struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
> + =C2=A0 =C2=A0uint8_t code;
> +
> + =C2=A0 =C2=A0DBG("");
> + =C2=A0 =C2=A0if (g_isi_msg_id(msg) !=3D NET_CS_STATE_RESP)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> +
> + =C2=A0 =C2=A0if (!g_isi_msg_data_get_byte(msg, 0, &code))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> +
> + =C2=A0 =C2=A0if (code !=3D NET_CAUSE_OK)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("Failed with cause=3D%X", code);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0if (!g_isi_msg_data_get_byte(msg, 1, &code))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0DBG("CS STATE=3D%X", code);
> +
> + =C2=A0 =C2=A0if (code =3D=3D NET_CS_INACTIVE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("CS INACTIVE - DO POWER ON NOT IMPLEMENT=
ED!!!!!!");

No shouting please ;)

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 /* Enable registration and roaming */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint8_t req[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NET_NW_ACCESS_CONF_REQ, 0, 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Subblock 1 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x59, 4, 1, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Subblock 2 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x5A, 4, 1, 0,

Should really add these subblock IDs in network.h.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("CS ACTIVE - Check access config");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0g_isi_client_send(nd->client, req, sizeof(re=
q), cs_access_config_resp_cb, netreg, NULL);

Please take a look at coding style rule O2, and rather than putting
all this in an else statement, just return above if code =3D=3D
NET_CS_INACTIVE.

By the way, is CS access config ever set if when probing the CS state
is NET_CS_INACTIVE? Should we also subscribe to the equivalent
indication to drive this code?

> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> =C2=A0static void subscribe_indications(GIsiClient *cl, void *data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_isi_client_ind_subscribe(cl, NET_RSSI_IND, r=
ssi_ind_cb, data);
> @@ -994,6 +1072,11 @@ static void pn_modem_network_reachable_cb(const GIs=
iMessage *msg, void *data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_netreg *netreg =3D data;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct netreg_data *nd =3D ofono_netreg_get_da=
ta(netreg);
>
> + =C2=A0 =C2=A0const uint8_t req[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0NET_CS_STATE_REQ,
> + =C2=A0 =C2=A0};
> +
> +

Indent with tabs here.

Cheers,
Aki

--===============4380651521278821991==--

