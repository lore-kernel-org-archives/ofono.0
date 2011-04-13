Content-Type: multipart/mixed; boundary="===============1097557149423883383=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 6/6] stk: Introduce BIP command handlers
Date: Wed, 13 Apr 2011 16:02:57 +0200
Message-ID: <4DA5AD11.30902@linux.intel.com>
In-Reply-To: <4DA3E0CC.3030405@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1097557149423883383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04/12/2011 07:19 AM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 04/08/2011 11:33 AM, Philippe Nunes wrote:
>> ---
>>   src/stk.c |  506 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
>>   1 files changed, 484 insertions(+), 22 deletions(-)
>>
>> diff --git a/src/stk.c b/src/stk.c
>> index c86cbfb..e033df7 100644
>> --- a/src/stk.c
>> +++ b/src/stk.c
>> @@ -79,6 +79,10 @@ struct ofono_stk {
>>
>>   	__ofono_sms_sim_download_cb_t sms_pp_cb;
>>   	void *sms_pp_userdata;
>> +	struct stk_channel channel;
>> +	struct stk_channel_data rx_buffer;
>> +	struct stk_channel_data tx_buffer;
>> +	gboolean link_on_demand;
>>   };
>>
>>   struct envelope_op {
>> @@ -104,6 +108,13 @@ static void timers_update(struct ofono_stk *stk);
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
>> @@ -112,6 +123,9 @@ static int stk_respond(struct ofono_stk *stk, struct=
 stk_response *rsp,
>>
>>   	DBG("");
>>
>> +	if (stk->pending_cmd =3D=3D NULL)
>> +		return 0;
>> +
>
> This seems fishy, why do you need this?  Is this a bug you discovered or
> a behavior change necessitated by BIP support?

No, in fact, just looking to the code below (session_agent_notify), I =

found logical and more safe to add also this check in the function =

stk_respond:

if (stk->current_agent =3D=3D stk->session_agent && stk->respond_on_exit) {
	if (stk->pending_cmd)
		stk->cancel_cmd(stk);

	DBG("Sending Terminate response for session agent");
	send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
}

Now, I agree that if the flag 'respond_on_exit' is TRUE, it requires =

necessarily a pending command especially with the modification I did =

below (since the flag is set back to False just after the pending_cmd is =

set to NULL).
So, I can forget this check but logically we could remove also the check =

before calling stk->cancel_cmd.

>
>>   	if (stk->driver->terminal_response =3D=3D NULL)
>>   		return -ENOSYS;
>>
>> @@ -128,6 +142,7 @@ static int stk_respond(struct ofono_stk *stk, struct=
 stk_response *rsp,
>>   	stk_command_free(stk->pending_cmd);
>>   	stk->pending_cmd =3D NULL;
>>   	stk->cancel_cmd =3D NULL;
>> +	stk->respond_on_exit =3D FALSE;
>
> Same comment as above here
>
>>
>>   	stk->driver->terminal_response(stk, tlv_len, tlv, cb, stk);
>>
>> @@ -473,14 +488,48 @@ static void emit_menu_changed(struct ofono_stk *st=
k)
>>   	g_dbus_send_message(conn, signal);
>>   }
>>
>> +static void stk_close_channel(struct ofono_stk *stk)
>> +{
>> +	/*
>> +	 * TODO
>> +	 * Deactivate PDP context
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
>> +		stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_CLOSE_CHANNEL)
>
> doc/coding-style.txt M4


In this case, as it is not possible to indent the second line condition, =

should I indent one more the body?


>
>> +		send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
>> +	else {
>> +		/*
>> +		 * TODO
>> +		 * Send Event channel status
>> +		 */
>> +	}
>> +}
>> +
>>   static void user_termination_cb(enum stk_agent_result result, void *us=
er_data)
>>   {
>>   	struct ofono_stk *stk =3D user_data;
>>
>> -	if (result =3D=3D STK_AGENT_RESULT_TERMINATE) {
>> -		stk->respond_on_exit =3D FALSE;
>> +	if (result !=3D STK_AGENT_RESULT_TERMINATE)
>> +		return;
>> +
>> +	if (stk->pending_cmd) {
>>   		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
>> +		stk->cancel_cmd(stk);
>
> I don't think this will work out.  send_simple_responses NULLs out
> cancel_cmd...
>
> I'm guessing you're trying to guarantee that send_dtmf is properly
> canceled when the agent sends an EndSession error...

yes, that was the idea. I need to call the cancel function before =

sending the response...


>
>>   	}
>> +
>> +	if (stk->channel.id)
>> +		stk_close_channel(stk);
>>   }
>>
>>   static void stk_alpha_id_set(struct ofono_stk *stk,
>> @@ -511,6 +560,147 @@ static void stk_alpha_id_unset(struct ofono_stk *s=
tk)
>>   	stk_agent_request_cancel(stk->current_agent);
>>   }
>>
>> +
>> +static void stk_open_channel(struct ofono_stk *stk)
>> +{
>> +	const struct stk_command_open_channel *oc;
>> +	struct stk_response rsp;
>> +	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
>> +
>> +	if (stk->pending_cmd =3D=3D NULL ||
>> +		stk->pending_cmd->type !=3D STK_COMMAND_TYPE_OPEN_CHANNEL)
>> +		return;
>> +
>> +	oc =3D&stk->pending_cmd->open_channel;
>> +
>> +	memset(&rsp, 0, sizeof(rsp));
>> +	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
>> +
>> +	stk->rx_buffer.data.array =3D g_try_malloc(oc->buf_size);
>> +	if (stk->rx_buffer.data.array =3D=3D NULL) {
>> +		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
>> +		goto out;
>> +	}
>> +
>> +	stk->tx_buffer.data.array =3D g_try_malloc(oc->buf_size);
>> +	if (stk->tx_buffer.data.array =3D=3D NULL) {
>> +		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
>> +		goto out;
>> +	}
>> +
>> +	stk->rx_buffer.data.len =3D oc->buf_size;
>> +	stk->tx_buffer.data.len =3D oc->buf_size;
>> +	stk->link_on_demand =3D (stk->pending_cmd->qualifier&
>> +				STK_OPEN_CHANNEL_FLAG_IMMEDIATE) ? FALSE : TRUE;
>> +
>> +	/*
>> +	 * TODO
>> +	 * Setup the channel->  either create a new PDP context or
>> +	 * use a default one
>> +	 * Send the Terminal Response or wait until the PDP context is activat=
ed
>> +	 * in case of immediate link establishment not in background.
>> +	 */
>> +out:
>> +
>> +	if (stk_respond(stk,&rsp, stk_command_cb))
>> +		stk_command_cb(&failure, stk);
>> +}
>> +
>> +static void stk_send_data(struct ofono_stk *stk,
>> +				struct stk_common_byte_array data,
>> +				unsigned char qualifier)
>> +{
>> +	struct stk_response rsp;
>> +	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
>> +	unsigned int offset;
>> +
>> +	memset(&rsp, 0, sizeof(rsp));
>> +	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
>> +
>> +	if (data.len>  stk->tx_buffer.data.len) {
>> +		rsp.result.type =3D STK_RESULT_TYPE_BIP_ERROR;
>> +		goto out;
>> +	}
>> +
>> +	if (qualifier =3D=3D STK_SEND_DATA_STORE_DATA) {
>> +
>> +		/*
>> +		 * check if the requested number of bytes of empty space
>> +		 * is available
>> +		 */
>> +		if (data.len>  stk->tx_buffer.tx_avail) {
>> +			rsp.result.type =3D STK_RESULT_TYPE_BIP_ERROR;
>> +			goto out;
>> +		}
>> +
>> +		offset =3D stk->tx_buffer.data.len - stk->tx_buffer.tx_avail;
>> +		memcpy(stk->tx_buffer.data.array + offset, data.array,
>> +				data.len);
>> +
>> +		stk->tx_buffer.tx_avail -=3D data.len;
>> +		rsp.send_data.tx_avail =3D stk->tx_buffer.tx_avail;
>> +		goto out;
>> +	}
>> +
>> +	if (stk->channel.status =3D=3D STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACT=
IVATED
>> +			&&  stk->link_on_demand =3D=3D TRUE) {
>> +		/*
>> +		 * TODO
>> +		 * activate the context, update the channel status
>> +		 * once the context is activated, send the data immediately
>> +		 * and flush the tx buffer
>> +		 */
>> +	} else {
>> +		/*
>> +		 * TODO
>> +		 * send the data immediately, flush the tx buffer
>> +		 */
>> +		stk->tx_buffer.tx_avail =3D stk->tx_buffer.data.len;
>> +		rsp.send_data.tx_avail =3D stk->tx_buffer.data.len;
>> +	}
>> +
>> +out:
>> +
>> +	if (stk_respond(stk,&rsp, stk_command_cb))
>> +		stk_command_cb(&failure, stk);
>> +}
>> +
>> +static void stk_receive_data(struct ofono_stk *stk, unsigned char data_=
len)
>> +{
>> +	struct stk_response rsp;
>> +	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
>> +
>> +	memset(&rsp, 0, sizeof(rsp));
>> +	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
>> +
>> +	if (stk->rx_buffer.rx_remaining =3D=3D 0) {
>> +		rsp.result.type =3D STK_RESULT_TYPE_MISSING_INFO;
>> +		goto out;
>> +	}
>> +
>> +	if (data_len>  stk->rx_buffer.rx_remaining) {
>> +		rsp.result.type =3D STK_RESULT_TYPE_MISSING_INFO;
>> +		data_len =3D stk->rx_buffer.rx_remaining;
>> +	}
>> +
>> +	if (data_len>  CHANNEL_DATA_OBJECT_MAX_LENGTH)
>> +		data_len =3D CHANNEL_DATA_OBJECT_MAX_LENGTH;
>> +
>> +	rsp.receive_data.rx_data.array =3D stk->rx_buffer.data.array;
>> +	rsp.receive_data.rx_data.len =3D data_len;
>> +	stk->rx_buffer.rx_remaining -=3D data_len;
>> +	rsp.receive_data.rx_remaining =3D stk->rx_buffer.rx_remaining;
>> +
>> +out:
>> +	if (stk_respond(stk,&rsp, stk_command_cb))
>> +		stk_command_cb(&failure, stk);
>> +
>> +	if (rsp.receive_data.rx_data.len&&  stk->rx_buffer.rx_remaining>  0)
>> +		memmove(stk->rx_buffer.data.array, stk->rx_buffer.data.array +
>> +				data_len, stk->rx_buffer.rx_remaining);
>> +
>> +}
>> +
>>   static int duration_to_msecs(const struct stk_duration *duration)
>>   {
>>   	int msecs =3D duration->interval;
>> @@ -598,7 +788,6 @@ static void default_agent_notify(gpointer user_data)
>>
>>   	stk->default_agent =3D NULL;
>>   	stk->current_agent =3D stk->session_agent;
>> -	stk->respond_on_exit =3D FALSE;
>
> You really need to put these into a separate patch with a huge
> description of what you're trying to fix and why.  respond_on_exit is
> pretty much tricky to get right, and really has to be reviewed
> independently from BIP command handlers...

Indeed, in practice, this modification is coming from BIP handler =

implementation, but this is uncorrelated from BIP.
Here, the idea of this modification is to update the flag only once the =

Terminal response has been sent.
My understanding of this flag is to allow to send a Terminal response =

"Proactive UICC session terminated by the user" once the stk agent exits =

(user quits).

But this case still subsists even after the user confirms to setup a =

voice call or to setup a BIP channel. For such cases, we need to =

establish the link before returning the terminal response, which can =

take a while.

Actually, in the callback 'confirm_call_cb', the flag =

stk->respond_on_exit is set back to FALSE whereas the Terminal response =

is not already sent. Fact is that the user may exit the stk agent before =

the call is connected. In this case, no terminal response is sent, =

leading to a potential mismatch regarding the expected answer from SIM.

So I found more safe and logical to reinitialise this flag only in the =

function stk_respond after the terminal response is sent.

If you agree with this approach, I'm willing to submit a dedicated patch =

for that.

>
>>   }
>>
>>   static void session_agent_notify(gpointer user_data)
>> @@ -617,7 +806,6 @@ static void session_agent_notify(gpointer user_data)
>>
>>   	stk->session_agent =3D NULL;
>>   	stk->current_agent =3D stk->default_agent;
>> -	stk->respond_on_exit =3D FALSE;
>
> Same comment here
>
>>
>>   	if (stk->remove_agent_source) {
>>   		g_source_remove(stk->remove_agent_source);
>> @@ -1159,8 +1347,6 @@ static void request_selection_cb(enum stk_agent_re=
sult result, uint8_t id,
>>   {
>>   	struct ofono_stk *stk =3D user_data;
>>
>> -	stk->respond_on_exit =3D FALSE;
>> -
>
> And here
>
>>   	switch (result) {
>>   	case STK_AGENT_RESULT_OK:
>>   	{
>> @@ -1243,8 +1429,6 @@ static void display_text_cb(enum stk_agent_result =
result, void *user_data)
>>   	static unsigned char screen_busy_result[] =3D { 0x01 };
>>   	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAIL=
URE };
>>
>> -	stk->respond_on_exit =3D FALSE;
>> -
>
> And here
>
>>   	/*
>>   	 * There are four possible paths for DisplayText with immediate
>>   	 * response flag set:
>> @@ -1386,8 +1570,6 @@ static void request_confirmation_cb(enum stk_agent=
_result result,
>>   	struct stk_command_get_inkey *cmd =3D&stk->pending_cmd->get_inkey;
>>   	struct stk_response rsp;
>>
>> -	stk->respond_on_exit =3D FALSE;
>> -
>
> And here
>
>>   	switch (result) {
>>   	case STK_AGENT_RESULT_OK:
>>   		memset(&rsp, 0, sizeof(rsp));
>> @@ -1442,8 +1624,6 @@ static void request_key_cb(enum stk_agent_result r=
esult, char *string,
>>   	struct stk_command_get_inkey *cmd =3D&stk->pending_cmd->get_inkey;
>>   	struct stk_response rsp;
>>
>> -	stk->respond_on_exit =3D FALSE;
>> -
>
> And here
>
>>   	switch (result) {
>>   	case STK_AGENT_RESULT_OK:
>>   		memset(&rsp, 0, sizeof(rsp));
>> @@ -1560,8 +1740,6 @@ static void request_string_cb(enum stk_agent_resul=
t result, char *string,
>>   	gboolean packed =3D (qualifier&  (1<<  3)) !=3D 0;
>>   	struct stk_response rsp;
>>
>> -	stk->respond_on_exit =3D FALSE;
>> -
>>   	switch (result) {
>>   	case STK_AGENT_RESULT_OK:
>>   		memset(&rsp, 0, sizeof(rsp));
>> @@ -1699,8 +1877,6 @@ static void confirm_call_cb(enum stk_agent_result =
result, gboolean confirm,
>>   	struct stk_response rsp;
>>   	int err;
>>
>> -	stk->respond_on_exit =3D FALSE;
>> -
>>   	switch (result) {
>>   	case STK_AGENT_RESULT_TIMEOUT:
>>   		confirm =3D FALSE;
>> @@ -2300,8 +2476,6 @@ static void dtmf_sent_cb(int error, void *user_dat=
a)
>>   {
>>   	struct ofono_stk *stk =3D user_data;
>>
>> -	stk->respond_on_exit =3D FALSE;
>> -
>>   	stk_alpha_id_unset(stk);
>>
>>   	if (error =3D=3D ENOENT) {
>> @@ -2413,8 +2587,6 @@ static void play_tone_cb(enum stk_agent_result res=
ult, void *user_data)
>>   {
>>   	struct ofono_stk *stk =3D user_data;
>>
>> -	stk->respond_on_exit =3D FALSE;
>> -
>>   	switch (result) {
>>   	case STK_AGENT_RESULT_OK:
>>   	case STK_AGENT_RESULT_TIMEOUT:
>> @@ -2547,8 +2719,6 @@ static void confirm_launch_browser_cb(enum stk_age=
nt_result result,
>>   	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
>>   	struct stk_response rsp;
>>
>> -	stk->respond_on_exit =3D FALSE;
>> -
>
> And... you get the idea :)
>
>>   	switch (result) {
>>   	case STK_AGENT_RESULT_TIMEOUT:
>>   		confirm =3D FALSE;
>> @@ -2612,6 +2782,273 @@ static gboolean handle_command_launch_browser(co=
nst struct stk_command *cmd,
>>   	return FALSE;
>>   }
>>
>> +
>> +static void open_channel_cancel(struct ofono_stk *stk)
>> +{
>> +	/* TODO */
>> +}
>> +
>> +static void confirm_open_channel_cb(enum stk_agent_result result,
>> +					gboolean confirm,
>> +					void *user_data)
>> +{
>> +	struct ofono_stk *stk =3D user_data;
>> +
>> +	switch (result) {
>> +	case STK_AGENT_RESULT_TERMINATE:
>> +		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
>> +		return;
>> +
>> +	case STK_AGENT_RESULT_TIMEOUT:
>> +		confirm =3D FALSE;
>> +		/* Fall through */
>> +
>> +	case STK_AGENT_RESULT_OK:
>> +		if (confirm)
>> +			break;
>> +		/* Fall through */
>> +
>> +	default:
>> +		send_simple_response(stk, STK_RESULT_TYPE_TERMINAL_BUSY);
>> +		return;
>> +	}
>> +
>> +	stk_open_channel(stk);
>> +}
>> +
>> +static gboolean handle_command_open_channel(const struct stk_command *c=
md,
>> +						struct stk_response *rsp,
>> +						struct ofono_stk *stk)
>> +{
>> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
>> +	const struct stk_command_open_channel *oc =3D&cmd->open_channel;
>> +	struct ofono_atom *gprs_atom;
>> +	int err;
>> +
>> +	/* Check first if channel is available */
>> +	if (stk->channel.id) {
>> +		unsigned char addnl_info[1];
>> +
>> +		addnl_info[0] =3D STK_RESULT_ADDNL_BIP_PB_NO_CHANNEL_AVAIL;
>> +		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
>> +				addnl_info);
>> +		return TRUE;
>> +	}
>> +
>> +	gprs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
>> +	if (gprs_atom =3D=3D NULL || !__ofono_atom_get_registered(gprs_atom)) {
>> +		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
>> +		return TRUE;
>> +	}
>> +
>> +	stk->respond_on_exit =3D TRUE;
>> +	stk->cancel_cmd =3D open_channel_cancel;
>> +
>> +	/*
>> +	 * Don't ask for user confirmation if AID is a null data object
>> +	 * or is not provided
>> +	 */
>> +	if (oc->alpha_id&&  strlen(oc->alpha_id)>  0) {
>> +		char *alpha_id;
>> +
>> +		alpha_id =3D dbus_apply_text_attributes(oc->alpha_id,
>> +								&oc->text_attr);
>> +		if (alpha_id =3D=3D NULL) {
>> +			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
>> +			return TRUE;
>> +		}
>> +
>> +		err =3D stk_agent_confirm_open_channel(stk->current_agent,
>> +							alpha_id,
>> +							&oc->icon_id,
>> +							confirm_open_channel_cb,
>> +							stk, NULL,
>> +							stk->timeout * 1000);
>> +		g_free(alpha_id);
>> +
>> +		if (err<  0) {
>> +			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
>> +			return TRUE;
>> +		}
>> +
>> +		return FALSE;
>> +	}
>> +
>> +	stk_open_channel(stk);
>> +
>> +	return FALSE;
>> +}
>> +
>> +static gboolean handle_command_close_channel(const struct stk_command *=
cmd,
>> +						struct stk_response *rsp,
>> +						struct ofono_stk *stk)
>> +{
>> +	const struct stk_command_close_channel *cc =3D&cmd->close_channel;
>> +	int err;
>> +
>> +	/* Check if channel identifier is valid */
>> +	if (cmd->dst !=3D stk->channel.id) {
>> +		unsigned char addnl_info[1];
>> +
>> +		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_ID_NOT_VALID;
>> +		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
>> +					addnl_info);
>> +		return TRUE;
>> +	}
>> +
>> +	/*
>> +	 * Don't inform the user about the link closing phase if AID is
>> +	 * a null data object or is not provided
>> +	 */
>> +	if (cc->alpha_id&&  strlen(cc->alpha_id)>  0) {
>> +		char *alpha_id;
>> +
>> +		alpha_id =3D dbus_apply_text_attributes(cc->alpha_id,
>> +							&cc->text_attr);
>> +		if (alpha_id =3D=3D NULL) {
>> +			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
>> +			return TRUE;
>> +		}
>> +
>> +		err =3D stk_agent_display_action(stk->current_agent, alpha_id,
>> +							&cc->icon_id,
>> +							user_termination_cb,
>> +							stk, NULL);
>> +		g_free(alpha_id);
>> +
>> +		if (err<  0) {
>> +			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
>> +			return TRUE;
>> +		}
>
> This seems awfully close to what stk_alpha_id_set does.  Any reason why
> you're not using it? ...


Not really, I can indeed refer to stk_alpha_id_set to apply the text =

attributes and call properly stk_agent_display_action.

>
>> +	}
>> +
>> +	stk->respond_on_exit =3D TRUE;
>> +	stk->cancel_cmd =3D stk_request_cancel;
>> +
>> +	stk_close_channel(stk);
>> +
>> +	return FALSE;
>> +}
>> +
>> +static gboolean handle_command_receive_data(const struct stk_command *c=
md,
>> +						struct stk_response *rsp,
>> +						struct ofono_stk *stk)
>> +{
>> +	const struct stk_command_receive_data *rd =3D&cmd->receive_data;
>> +	int err;
>> +
>> +	/* Check if channel identifier is valid or already closed */
>> +	if (cmd->dst !=3D stk->channel.id) {
>> +		unsigned char addnl_info[1];
>> +
>> +		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_ID_NOT_VALID;
>> +		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
>> +					addnl_info);
>> +		return TRUE;
>> +	}
>> +
>> +	/*
>> +	 * Don't inform the user during data transfer if AID is
>> +	 * a null data object or is not provided
>> +	 */
>> +	if (rd->alpha_id&&  strlen(rd->alpha_id)>  0) {
>> +		char *alpha_id;
>> +
>> +		alpha_id =3D dbus_apply_text_attributes(rd->alpha_id,
>> +							&rd->text_attr);
>> +		if (alpha_id =3D=3D NULL) {
>> +			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
>> +			return TRUE;
>> +		}
>> +
>> +		err =3D stk_agent_display_action(stk->current_agent, alpha_id,
>> +							&rd->icon_id,
>> +							user_termination_cb,
>> +							stk, NULL);
>> +		g_free(alpha_id);
>> +
>> +		if (err<  0) {
>> +			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
>> +			return TRUE;
>> +		}
>
> ... Regardless, copy-pasting this much code is a bad idea.  You should
> really use a function.


yes, you're right.


>
>> +	}
>> +
>> +	stk->respond_on_exit =3D TRUE;
>> +	stk->cancel_cmd =3D stk_request_cancel;
>> +
>> +	stk_receive_data(stk, rd->data_len);
>> +
>> +	return FALSE;
>> +}
>> +
>> +static gboolean handle_command_send_data(const struct stk_command *cmd,
>> +						struct stk_response *rsp,
>> +						struct ofono_stk *stk)
>> +{
>> +	const struct stk_command_send_data *sd =3D&cmd->send_data;
>> +	int err;
>> +	unsigned char addnl_info[1];
>> +
>> +	/* Check if channel identifier is valid or already closed */
>> +	if (cmd->dst !=3D stk->channel.id) {
>> +		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_ID_NOT_VALID;
>> +		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
>> +					addnl_info);
>> +		return TRUE;
>> +	}
>> +
>> +	/* Check if the link was dropped */
>> +	if (stk->channel.status =3D=3D STK_CHANNEL_LINK_DROPPED) {
>> +		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_CLOSED;
>> +		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
>> +					addnl_info);
>> +		return TRUE;
>> +	}
>> +
>> +	/*
>> +	 * Don't inform the user during data transfer if AID is
>> +	 * a null data object or is not provided
>> +	 */
>> +	if (sd->alpha_id&&  strlen(sd->alpha_id)>  0) {
>> +		char *alpha_id;
>> +
>> +		alpha_id =3D dbus_apply_text_attributes(sd->alpha_id,
>> +							&sd->text_attr);
>> +		if (alpha_id =3D=3D NULL) {
>> +			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
>> +			return TRUE;
>> +		}
>> +
>> +		err =3D stk_agent_display_action(stk->current_agent, alpha_id,
>> +							&sd->icon_id,
>> +							user_termination_cb,
>> +							stk, NULL);
>> +		g_free(alpha_id);
>> +
>> +		if (err<  0) {
>> +			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
>> +			return TRUE;
>> +		}
>> +	}
>> +
>> +	stk->respond_on_exit =3D TRUE;
>> +	stk->cancel_cmd =3D stk_request_cancel;
>> +
>> +	stk_send_data(stk, sd->data, cmd->qualifier);
>> +
>> +	return FALSE;
>> +}
>> +
>> +static gboolean handle_command_get_channel_status(const struct stk_comm=
and *cmd,
>> +						struct stk_response *rsp,
>> +						struct ofono_stk *stk)
>> +{
>> +	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
>> +	rsp->channel_status.channel.id =3D stk->channel.id;
>> +	rsp->channel_status.channel.status =3D stk->channel.status;
>> +	return TRUE;
>> +}
>> +
>>   static void stk_proactive_command_cancel(struct ofono_stk *stk)
>>   {
>>   	if (stk->immediate_response)
>> @@ -2805,6 +3242,31 @@ void ofono_stk_proactive_command_notify(struct of=
ono_stk *stk,
>>   							&rsp, stk);
>>   		break;
>>
>> +	case STK_COMMAND_TYPE_OPEN_CHANNEL:
>> +		respond =3D handle_command_open_channel(stk->pending_cmd,
>> +							&rsp, stk);
>> +		break;
>> +
>> +	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
>> +		respond =3D handle_command_close_channel(stk->pending_cmd,
>> +							&rsp, stk);
>> +		break;
>> +
>> +	case STK_COMMAND_TYPE_RECEIVE_DATA:
>> +		respond =3D handle_command_receive_data(stk->pending_cmd,
>> +							&rsp, stk);
>> +		break;
>> +
>> +	case STK_COMMAND_TYPE_SEND_DATA:
>> +		respond =3D handle_command_send_data(stk->pending_cmd,
>> +							&rsp, stk);
>> +		break;
>> +
>> +	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
>> +		respond =3D handle_command_get_channel_status(stk->pending_cmd,
>> +							&rsp, stk);
>> +		break;
>> +
>>   	default:
>>   		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
>>   		break;
>
> Regards,
> -Denis
>


Regards,

Philippe.

--===============1097557149423883383==--

