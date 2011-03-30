Content-Type: multipart/mixed; boundary="===============5420667881302963500=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 3/6] stk: Introduce BIP command handlers
Date: Wed, 30 Mar 2011 14:57:59 +0200
Message-ID: <4D9328D7.4090205@linux.intel.com>
In-Reply-To: <AANLkTi=J6wq1r6M2h1GV4LGAFXeZ+KLoNMN1tHNKp5dV@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5420667881302963500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 03/30/2011 12:08 PM, Andrzej Zaborowski wrote:
> Hi Philippe,
>
> I understand that this is a stub but I have some comments just for refere=
nce.
>
> On 22 March 2011 13:51, Philippe Nunes<philippe.nunes@linux.intel.com> =
 wrote:
>> ---
>>   src/stk.c |  307 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   1 files changed, 307 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/stk.c b/src/stk.c
>> index 68b6240..d224360 100644
>> --- a/src/stk.c
>> +++ b/src/stk.c
>> @@ -79,6 +79,9 @@ struct ofono_stk {
>>
>>         __ofono_sms_sim_download_cb_t sms_pp_cb;
>>         void *sms_pp_userdata;
>> +       struct stk_channel channel;
>> +       struct stk_channel_data rx_buffer;
>> +       struct stk_channel_data tx_buffer;
>>   };
>>
>>   struct envelope_op {
>> @@ -2548,6 +2551,285 @@ static gboolean handle_command_launch_browser(co=
nst struct stk_command *cmd,
>>         return FALSE;
>>   }
>>
>> +static void confirm_open_channel_cb(enum stk_agent_result result,
>> +                                       gboolean confirm,
>> +                                       void *user_data)
>> +{
>> +       struct ofono_stk *stk =3D user_data;
>> +       unsigned char no_cause[] =3D { 0x00 };
>> +       struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAIL=
URE };
>> +       struct stk_response rsp;
>> +
>> +       stk->respond_on_exit =3D FALSE;
>> +
>> +       switch (result) {
>> +       case STK_AGENT_RESULT_TERMINATE:
>> +               send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATE=
D);
>> +               return;
>> +
>> +       case STK_AGENT_RESULT_TIMEOUT:
>> +               confirm =3D FALSE;
>> +               /* Fall through */
>> +
>> +       case STK_AGENT_RESULT_OK:
>> +               if (confirm)
>> +                       break;
>> +               /* Fall through */
>> +
>> +       default:
>> +               memset(&rsp, 0, sizeof(rsp));
>> +               ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_TERMINAL_BU=
SY,
>> +                                       no_cause);
>> +
>> +               if (stk_respond(stk,&rsp, stk_command_cb))
>> +                       stk_command_cb(&failure, stk);
>> +
>> +               return;
>> +       }
>> +
>> +       /*
>> +        * TODO
>> +        * setup the channel
>> +        */
>> +
>> +       /* For now, return  "Command beyond terminal's capabilities" */
>> +       send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
>> +}
>> +
>> +static gboolean handle_command_open_channel(const struct stk_command *c=
md,
>> +                                               struct stk_response *rsp,
>> +                                               struct ofono_stk *stk)
>> +{
>> +       const struct stk_command_open_channel *oc =3D&cmd->open_channel;
>> +       char *alpha_id;
>> +       int err;
>> +
>> +       /* Don't ask for user confirmation if AID is a null data object*/
>> +       if (oc->alpha_id&&  strlen(oc->alpha_id) =3D=3D 0) {
>> +               /*
>> +                * TODO
>> +                * setup the channel
>> +                */
>> +
>> +               /* For now, return  "Command beyond terminal's capabilit=
ies" */
>> +               rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
>> +               return TRUE;
>> +       }
>> +
>> +       alpha_id =3D dbus_apply_text_attributes(oc->alpha_id ? oc->alpha=
_id : "",
>> +&oc->text_attr);
>> +       if (alpha_id =3D=3D NULL) {
>> +               rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
>> +               return TRUE;
>> +       }
>> +
>> +       err =3D stk_agent_confirm_open_channel(stk->current_agent, alpha=
_id,
>> +&oc->icon_id,
>> +                                               confirm_open_channel_cb,
>> +                                               stk, NULL, stk->timeout =
* 1000);
>> +       g_free(alpha_id);
>
> What if no AlphaId or Icon are provided?

As you know, we are treating null data object(len =3D 0, no value part) =

and no alpha identifier cases equally. As specified for the case null =

data object, we are not allowed to provide any information to the user. =

So we start to setup the channel directly.

Also why don't we just use
> stk_alpha_id_set?

For Open channel, we need to get the user confirmation before setting up =

the channel. So a dedicated method is required.
However, for close/send/receive, the idea is finally to use =

stk_alpha_id_set. The set of patch introducing the new method =

"DisplayAction" is precisely preparing this work.

>
> Another thing, is that AFAICS this series wants to support only one
> channel at a time, right?  Then we need to check if a channel is
> already open (non-NULL) and return "busy".  In the
> close/transmit/receive functions we need to make sure that the channel
> is non NULL and the channel id matches.

You're right, the basic checking are missing. For Open channel, we need =

also to check that the bearer type is supported (for now, we are looking =

to handle only packet data service bearer).
And I confirm that for now, only one channel is supported at a time.

>
> Also it looks like the patches are in reverse order because unit tests
> are added before implementation, and stk.c functions are added before
> stkagent.c functions.
>

Yes, I missed to consider that we could apply the patches one by one so =

I didn't care about the order. I will reorder the patches next time.

>> +
>> +       if (err<  0) {
>> +               unsigned char no_cause_result[] =3D { 0x00 };
>> +
>> +               /*
>> +                * We most likely got an out of memory error, tell SIM
>> +                * to retry
>> +                */
>> +               ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_B=
USY,
>> +                                       no_cause_result);
>> +               return TRUE;
>> +       }
>> +
>> +       stk->respond_on_exit =3D TRUE;
>> +       stk->cancel_cmd =3D stk_request_cancel;
>> +
>> +       return FALSE;
>> +}
>> +
>> +static void channel_activity_cb(enum stk_agent_result result, void *use=
r_data)
>> +{
>> +       struct ofono_stk *stk =3D user_data;
>> +
>> +       if (result =3D=3D STK_AGENT_RESULT_TERMINATE) {
>> +               stk->respond_on_exit =3D FALSE;
>> +               send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATE=
D);
>> +       }
>
> Should we close the channel?

Yes, logically (at least for Receive data/Send Data).
The following code could be more relevant:

	if (result =3D=3D STK_AGENT_RESULT_TERMINATE && stk->pending_cmd) {
			stk->respond_on_exit =3D FALSE;
			=

			stk->cancel_cmd(stk);
			=

			send_simple_response(stk,
                             STK_RESULT_TYPE_USER_TERMINATED);
	}	=



stk->cancel_cmd should not be set to 'stk_request_cancel' as you see in =

this patch but it should be set to a generic function like =

"cancel_channel" implementing the channel closing and cleanup .

In practice, the terminal response to Receive data/Send Data is likely =

to be already sent before the user decides to end the session. So, in =

this case, sending the 'Channel status' event should be considered =

instead of sending a simple response.


>
> Best regards


--===============5420667881302963500==--

