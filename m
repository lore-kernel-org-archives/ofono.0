Content-Type: multipart/mixed; boundary="===============6117414680653141711=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH v3 2/7] stk: Introduce BIP command handlers
Date: Mon, 16 May 2011 17:54:09 +0200
Message-ID: <BANLkTin0K_wovwFOsmkO2JUhODC+H=O2yw@mail.gmail.com>
In-Reply-To: <1305307324-19548-2-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6117414680653141711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 13 May 2011 19:21, Philippe Nunes <philippe.nunes@linux.intel.com> wro=
te:
> ---
> =C2=A0src/stk.c | =C2=A0425 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++-
> =C2=A01 files changed, 424 insertions(+), 1 deletions(-)
>
> diff --git a/src/stk.c b/src/stk.c
> index 8214b65..dec0439 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -41,6 +41,7 @@
> =C2=A0#include "smsutil.h"
> =C2=A0#include "stkutil.h"
> =C2=A0#include "stkagent.h"
> +#include "gprs.h"
> =C2=A0#include "util.h"
>
> =C2=A0static GSList *g_drivers =3D NULL;
> @@ -79,6 +80,11 @@ struct ofono_stk {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__ofono_sms_sim_download_cb_t sms_pp_cb;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void *sms_pp_userdata;
> + =C2=A0 =C2=A0 =C2=A0 struct stk_channel channel;
> + =C2=A0 =C2=A0 =C2=A0 struct stk_channel_data rx_buffer;
> + =C2=A0 =C2=A0 =C2=A0 struct stk_channel_data tx_buffer;
> + =C2=A0 =C2=A0 =C2=A0 gboolean link_on_demand;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_gprs *gprs;
> =C2=A0};
>
> =C2=A0struct envelope_op {
> @@ -104,6 +110,13 @@ static void timers_update(struct ofono_stk *stk);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result.additional_=
len =3D sizeof(addn_info); =C2=A0 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result.additional =
=3D addn_info; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\
>
> +/*
> + * According the structure and coding of the Terminal response defined in
> + * TS 102 223 section 6.8, the maximum number of bytes possible for the =
channel
> + * data object is 243
> + */
> +#define CHANNEL_DATA_OBJECT_MAX_LENGTH 243
> +
> =C2=A0static int stk_respond(struct ofono_stk *stk, struct stk_response *=
rsp,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ofono_stk_generic_cb_t cb)
> =C2=A0{
> @@ -474,12 +487,49 @@ static void emit_menu_changed(struct ofono_stk *stk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_dbus_send_message(conn, signal);
> =C2=A0}
>
> +static void stk_close_channel(struct ofono_stk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Deactivate and remove PDP context
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Send the Terminal Response once the PDP co=
ntext is deactivated
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Temporary implementation */
> + =C2=A0 =C2=A0 =C2=A0 g_free(stk->rx_buffer.data.array);
> + =C2=A0 =C2=A0 =C2=A0 g_free(stk->tx_buffer.data.array);
> + =C2=A0 =C2=A0 =C2=A0 stk->rx_buffer.data.array =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 stk->tx_buffer.data.array =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->channel.id =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SE=
RVICE_NOT_ACTIVATED;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk->pending_cmd &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 stk->pending_cmd->type =3D=3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STK_COMMAND_TYPE_CLOSE_CHANNEL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_SUCCESS);
> + =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Send Event cha=
nnel status
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> =C2=A0static void user_termination_cb(enum stk_agent_result result, void =
*user_data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_stk *stk =3D user_data;
>
> - =C2=A0 =C2=A0 =C2=A0 if (result =3D=3D STK_AGENT_RESULT_TERMINATE)
> + =C2=A0 =C2=A0 =C2=A0 if (result !=3D STK_AGENT_RESULT_TERMINATE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk->pending_cmd) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->cancel_cmd(stk);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send_simple_respon=
se(stk, STK_RESULT_TYPE_USER_TERMINATED);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk->channel.id)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk_close_channel(stk);
> =C2=A0}
>
> =C2=A0static void stk_alpha_id_set(struct ofono_stk *stk,
> @@ -510,6 +560,143 @@ static void stk_alpha_id_unset(struct ofono_stk *st=
k)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk_agent_request_cancel(stk->current_agent);
> =C2=A0}
>
> +
> +static void stk_open_channel(struct ofono_stk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const struct stk_command_open_channel *oc;
> + =C2=A0 =C2=A0 =C2=A0 struct stk_response rsp;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_error failure =3D { .type =3D OFONO_E=
RROR_TYPE_FAILURE };
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk->pending_cmd =3D=3D NULL ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->pending_cmd->type=
 !=3D STK_COMMAND_TYPE_OPEN_CHANNEL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 oc =3D &stk->pending_cmd->open_channel;
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(&rsp, 0, sizeof(rsp));
> + =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->rx_buffer.data.array =3D g_try_malloc(oc->buf=
_size);
> + =C2=A0 =C2=A0 =C2=A0 if (stk->rx_buffer.data.array =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D ST=
K_RESULT_TYPE_NOT_CAPABLE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 stk->tx_buffer.data.array =3D g_try_malloc(oc->buf=
_size);
> + =C2=A0 =C2=A0 =C2=A0 if (stk->tx_buffer.data.array =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D ST=
K_RESULT_TYPE_NOT_CAPABLE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 }

A minor nitpick: we tend to return one of the temporary error codes
when out of memory.

> +
> + =C2=A0 =C2=A0 =C2=A0 stk->rx_buffer.data.len =3D oc->buf_size;
> + =C2=A0 =C2=A0 =C2=A0 stk->tx_buffer.data.len =3D oc->buf_size;
> + =C2=A0 =C2=A0 =C2=A0 stk->link_on_demand =3D (stk->pending_cmd->qualifi=
er &
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STK_OPEN_CHANNEL_FLAG_IMMEDIATE) ? FALSE=
 : TRUE;
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Add a new primary PDP context based on the=
 provided settings
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Send the Terminal Response or wait until t=
he PDP context is activated
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* in case of immediate link establishment no=
t in background.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> +out:
> + =C2=A0 =C2=A0 =C2=A0 if (stk_respond(stk, &rsp, stk_command_cb))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk_command_cb(&failur=
e, stk);
> +}
> +
> +static void stk_send_data(struct ofono_stk *stk,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stk_common_byte_array data,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char qualifier)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct stk_response rsp;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_error failure =3D { .type =3D OFONO_E=
RROR_TYPE_FAILURE };
> + =C2=A0 =C2=A0 =C2=A0 unsigned int offset;
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(&rsp, 0, sizeof(rsp));
> + =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (data.len > stk->tx_buffer.data.len) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D ST=
K_RESULT_TYPE_BIP_ERROR;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (qualifier =3D=3D STK_SEND_DATA_STORE_DATA) {
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* check if the r=
equested number of bytes of empty space
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is available
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (data.len > stk->tx=
_buffer.tx_avail) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rsp.result.type =3D STK_RESULT_TYPE_BIP_ERROR;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D stk->tx_buf=
fer.data.len - stk->tx_buffer.tx_avail;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(stk->tx_buffer.=
data.array + offset, data.array,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.len);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->tx_buffer.tx_avai=
l -=3D data.len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.send_data.tx_avail=
 =3D stk->tx_buffer.tx_avail;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk->channel.status =3D=3D STK_CHANNEL_PACKET_=
DATA_SERVICE_NOT_ACTIVATED
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 && stk->link_on_demand =3D=3D TRUE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* activate the c=
ontext, update the channel status
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* once the conte=
xt is activated, send the data immediately
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and flush the =
tx buffer
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* send the data =
immediately, flush the tx buffer
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->tx_buffer.tx_avai=
l =3D stk->tx_buffer.data.len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.send_data.tx_avail=
 =3D stk->tx_buffer.data.len;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> +out:
> + =C2=A0 =C2=A0 =C2=A0 if (stk_respond(stk, &rsp, stk_command_cb))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk_command_cb(&failur=
e, stk);
> +}
> +
> +static void stk_receive_data(struct ofono_stk *stk, unsigned char data_l=
en)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct stk_response rsp;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_error failure =3D { .type =3D OFONO_E=
RROR_TYPE_FAILURE };
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(&rsp, 0, sizeof(rsp));
> + =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (stk->rx_buffer.rx_remaining =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D ST=
K_RESULT_TYPE_MISSING_INFO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (data_len > stk->rx_buffer.rx_remaining) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D ST=
K_RESULT_TYPE_MISSING_INFO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_len =3D stk->rx_b=
uffer.rx_remaining;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (data_len > CHANNEL_DATA_OBJECT_MAX_LENGTH)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_len =3D CHANNEL_D=
ATA_OBJECT_MAX_LENGTH;
> +
> + =C2=A0 =C2=A0 =C2=A0 rsp.receive_data.rx_data.array =3D stk->rx_buffer.=
data.array;
> + =C2=A0 =C2=A0 =C2=A0 rsp.receive_data.rx_data.len =3D data_len;
> + =C2=A0 =C2=A0 =C2=A0 stk->rx_buffer.rx_remaining -=3D data_len;
> + =C2=A0 =C2=A0 =C2=A0 rsp.receive_data.rx_remaining =3D stk->rx_buffer.r=
x_remaining;
> +
> +out:
> + =C2=A0 =C2=A0 =C2=A0 if (stk_respond(stk, &rsp, stk_command_cb))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk_command_cb(&failur=
e, stk);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (rsp.receive_data.rx_data.len && stk->rx_buffer=
.rx_remaining > 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(stk->rx_buffer=
.data.array, stk->rx_buffer.data.array +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data_len, stk->rx_buffer.rx_remaining);
> +}
> +
> =C2=A0static int duration_to_msecs(const struct stk_duration *duration)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int msecs =3D duration->interval;
> @@ -2589,6 +2776,217 @@ static gboolean handle_command_launch_browser(con=
st struct stk_command *cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
> =C2=A0}
>
> +
> +static void open_channel_cancel(struct ofono_stk *stk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 /* TODO */
> +}
> +
> +static void confirm_open_channel_cb(enum stk_agent_result result,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gboolean con=
firm,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *user_d=
ata)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk =3D user_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (result) {
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_TERMINATE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_USER_TERMINATED);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_TIMEOUT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 confirm =3D FALSE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fall through */
> +
> + =C2=A0 =C2=A0 =C2=A0 case STK_AGENT_RESULT_OK:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (confirm)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fall through */

According to 6.4.27 we should return STK_RESULT_TYPE_USER_REJECT if
the user does not accept the channel setup.

> +
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_simple_response(s=
tk, STK_RESULT_TYPE_TERMINAL_BUSY);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }

I think Jeevaka determined that this needs an additional info field.

Best regards

--===============6117414680653141711==--

