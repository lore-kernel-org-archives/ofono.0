Content-Type: multipart/mixed; boundary="===============7618826718549072310=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH v4 2/8] stk: Introduce BIP command handlers
Date: Fri, 10 Jun 2011 16:03:11 +0200
Message-ID: <4DF2241F.7050108@linux.intel.com>
In-Reply-To: <4DE6D949.3090001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7618826718549072310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 06/02/2011 02:28 AM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 05/20/2011 11:26 AM, Philippe Nunes wrote:
>> ---
>>   src/stk.c |  426 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>>   1 files changed, 425 insertions(+), 1 deletions(-)
>>
>
> This patch no longer applies.  Please rebase and resubmit.  Also, can I
> ask you to break this patch up into several, e.g. one for Open Channel,
> one for Close Channel, etc.  This will make it much easier for me to revi=
ew.
>

yes, sure.


>> diff --git a/src/stk.c b/src/stk.c
>> index 8214b65..fb376a6 100644
>> --- a/src/stk.c
>> +++ b/src/stk.c
>> @@ -41,6 +41,7 @@
>>   #include "smsutil.h"
>>   #include "stkutil.h"
>>   #include "stkagent.h"
>> +#include "gprs.h"
>>   #include "util.h"
>>
>>   static GSList *g_drivers =3D NULL;
>> @@ -79,6 +80,11 @@ struct ofono_stk {
>>
>>   	__ofono_sms_sim_download_cb_t sms_pp_cb;
>>   	void *sms_pp_userdata;
>> +	struct stk_channel channel;
>> +	struct stk_channel_data rx_buffer;
>> +	struct stk_channel_data tx_buffer;
>
> Are you sure you need these buffers?  At least the RX buffer can
> probably be ignored since you can always use the kernel socket buffer
> instead.  Copying from the kernel buffer into your own buffer just to
> copy it into SIM's buffer seems like busywork.
>

The idea of the Rx buffer is to introduce an intermediate buffer since =

it's up to the UICC to collect the received data with the proactive =

command 'Receive data'. But before that, we need to read the kernel =

buffer to determine the amount of data available and inform the UICC =

about this size.


> The TX buffer is arguable, you might want to use non-blocking IO, but in
> that case I would use a ring_buffer from GAtChat.

For STK, what is the added value of a ring buffer? The mechanism for STK =

is to store data in the TX buffer and once the PDU is complete, flush it =

by sending the data. So we can't store before the Tx buffer is empty.


>
>> +	gboolean link_on_demand;
>> +	struct ofono_gprs *gprs;
>>   };
>>
>>   struct envelope_op {
>> @@ -104,6 +110,13 @@ static void timers_update(struct ofono_stk *stk);
>>   		result.additional_len =3D sizeof(addn_info);	\
>>   		result.additional =3D addn_info;			\
>>
>> +/*
>> + * According the structure and coding of the Terminal response defined =
in
>> + * TS 102 223 section 6.8, the maximum number of bytes possible for the=
 channel
>> + * data object is 243
>> + */
>> +#define CHANNEL_DATA_OBJECT_MAX_LENGTH 243
>> +
>>   static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
>>   			ofono_stk_generic_cb_t cb)
>>   {
>> @@ -474,12 +487,43 @@ static void emit_menu_changed(struct ofono_stk *st=
k)
>>   	g_dbus_send_message(conn, signal);
>>   }
>>
>> +static void stk_close_channel(struct ofono_stk *stk)
>> +{
>> +	/*
>> +	 * TODO
>> +	 * Deactivate and remove PDP context
>> +	 * Send the Terminal Response once the PDP context is deactivated
>> +	 */
>> +
>> +	/* Temporary implementation */
>> +	g_free(stk->rx_buffer.data.array);
>> +	g_free(stk->tx_buffer.data.array);
>> +	stk->rx_buffer.data.array =3D NULL;
>> +	stk->tx_buffer.data.array =3D NULL;
>> +
>> +	stk->channel.id =3D 0;
>> +	stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
>> +
>> +	if (stk->pending_cmd&&
>
> Would this function ever be called if pending_cmd is NULL?

stk_close_channel may be called from the callback user_termination_cb. =

Therefore, the pending cmd is likely to be NULL once the Terminal =

response is sent.


>
>> +			stk->pending_cmd->type =3D=3D
>> +				STK_COMMAND_TYPE_CLOSE_CHANNEL)
>> +		send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
>> +}
>> +
>>   static void user_termination_cb(enum stk_agent_result result, void *us=
er_data)
>>   {
>>   	struct ofono_stk *stk =3D user_data;
>>
>> -	if (result =3D=3D STK_AGENT_RESULT_TERMINATE)
>> +	if (result !=3D STK_AGENT_RESULT_TERMINATE)
>> +		return;
>> +
>> +	if (stk->pending_cmd) {
>> +		stk->cancel_cmd(stk);
>
> You can't actually do this since the agent does not support calling
> stk_agent_request_cancel from within a callback.

OK, thank you for pointing this issue. But then I realize that I don't =

need to expressly release the stk session agent (through =

stk_agent_request_cancel). We just need to wait for the "End session" =

notification which is likely to be received as a result of the Terminal =

response "session terminated by user".

However I'm willing to keep the condition:
	=

	if (stk->channel.id)
		stk_close_channel(stk);

instead of introducing additional cases in your new switch case since =

for me, it's relevant to close the channel (if any) once the session is =

terminated (whatever is the proactive command).


Regards,

Philippe.

--===============7618826718549072310==--

