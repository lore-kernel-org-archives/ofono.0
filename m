Content-Type: multipart/mixed; boundary="===============1049596266133578368=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH v3 7/7] stk: Add support of the Setup event list proactive
 command
Date: Mon, 16 May 2011 19:00:24 +0200
Message-ID: <BANLkTimzGtPmbaFK33=9gRihRCSW-RoaUw@mail.gmail.com>
In-Reply-To: <1305307324-19548-7-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1049596266133578368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 13 May 2011 19:22, Philippe Nunes <philippe.nunes@linux.intel.com> wro=
te:
> ---
> =C2=A0src/stk.c | =C2=A0 90 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++++-------
> =C2=A01 files changed, 80 insertions(+), 10 deletions(-)
>
> diff --git a/src/stk.c b/src/stk.c
> index 5ff9441..7122477 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -85,6 +85,8 @@ struct ofono_stk {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_channel_data rx_buffer;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_channel_data tx_buffer;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gboolean link_on_demand;
> + =C2=A0 =C2=A0 =C2=A0 gboolean report_data_available;
> + =C2=A0 =C2=A0 =C2=A0 gboolean report_channel_status;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_gprs *gprs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_bearer_description bearer_desc;
> =C2=A0};
> @@ -489,6 +491,40 @@ static void emit_menu_changed(struct ofono_stk *stk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_dbus_send_message(conn, signal);
> =C2=A0}
>
> +static void event_download_envelope_cb(struct ofono_stk *stk, gboolean o=
k,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *data, int len)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!ok) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Event dow=
nload to UICC failed");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (len)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Event dow=
nload returned %i bytes of data",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len);
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("Event download =C2=A0to UICC reported no erro=
r");
> +}
> +
> +static void stk_send_channel_status_event(struct ofono_stk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct stk_envelope e;
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(&e, 0, sizeof(e));
> + =C2=A0 =C2=A0 =C2=A0 e.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD;
> + =C2=A0 =C2=A0 =C2=A0 e.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL;
> + =C2=A0 =C2=A0 =C2=A0 e.event_download.channel_status.channel.id =3D stk=
->channel.id;
> + =C2=A0 =C2=A0 =C2=A0 e.event_download.channel_status.channel.status =3D=
 stk->channel.status;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk->channel.status =3D=3D STK_CHANNEL_PACKET_=
DATA_SERVICE_ACTIVATED)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&e.event_downlo=
ad.channel_status.bearer_desc,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &stk->bearer_desc,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct stk_bearer_description));
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk_send_envelope(stk, &e, event_download_enve=
lope_cb, 0))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event_download_envelop=
e_cb(stk, FALSE, NULL, -1);
> +}
> +
> =C2=A0static void ofono_stk_remove_pdp_context_cb(int error, void *data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_stk *stk =3D data;
> @@ -503,12 +539,8 @@ static void ofono_stk_remove_pdp_context_cb(int erro=
r, void *data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
> - =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Send Event cha=
nnel status
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } else if (stk->report_channel_status)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk_send_channel_statu=
s_event(stk);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* free the buffers even in case of error */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(stk->rx_buffer.data.array);
> @@ -608,10 +640,8 @@ static void ofono_stk_activate_pdp_context_cb(int er=
ror, const char *interface,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stk->pending_cmd =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Send Event cha=
nnel status
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stk->report_channe=
l_status)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stk_send_channel_status_event(stk);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -3129,6 +3159,41 @@ static gboolean handle_command_get_channel_status(=
const struct stk_command *cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return TRUE;
> =C2=A0}
>
> +
> +static gboolean handle_command_setup_event_list(const struct stk_command=
 *cmd,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct stk_response *rsp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct ofono_stk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const struct stk_command_setup_event_list *sel =3D=
 &cmd->setup_event_list;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < sel->event_list.len; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (sel->event_lis=
t.list[i]) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case STK_EVENT_TYPE_DA=
TA_AVAILABLE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBG("Enable data available event");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stk->report_data_available =3D TRUE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case STK_EVENT_TYPE_CH=
ANNEL_STATUS:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBG("Enable channel status event");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stk->report_channel_status =3D TRUE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBG("Event type (%d) not supported",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sel->event_list.list[i]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return TRUE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (sel->event_list.len =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->report_data_avail=
able =3D FALSE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->report_channel_st=
atus =3D FALSE;
> + =C2=A0 =C2=A0 =C2=A0 }

These flags should probably be cleared unconditionally before the loop
above because "Any subsequent SET UP EVENT LIST command replaces the
current list of events..".

Best regards

--===============1049596266133578368==--

