Content-Type: multipart/mixed; boundary="===============6058036335460069664=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 5/9] stk: Handle ENVELOPEs in a queue, retry on sim busy.
Date: Fri, 02 Jul 2010 03:32:25 +0200
Message-ID: <AANLkTim0qPTPK392IBQUtYkHu2ZIe8iI3wCriKXqGSwf@mail.gmail.com>
In-Reply-To: <4C2CF33B.90908@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6058036335460069664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 1 July 2010 21:57, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
>> +
>> + =C2=A0 =C2=A0 gboolean envelope_q_busy;
>
> In my opinion we can get rid of this variable. =C2=A0The SMS tx_queue does
> almost the same thing without requiring such a variable.

True, I didn't think of it.

>
>> + =C2=A0 =C2=A0 GQueue *envelope_q;
>> +};
>> +
>> +struct envelope_op {
>> + =C2=A0 =C2=A0 struct stk_envelope e;
>> + =C2=A0 =C2=A0 int retries;
>> + =C2=A0 =C2=A0 void (*cb)(struct ofono_stk *stk, gboolean ok,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
const unsigned char *data, int length);
>
> Is the callback really needed? =C2=A0What can we intelligently do besides
> printing an error to the log?

In the generic case we should inform whoever asked us to submit the
information to the UICC.  We don't currently have any such case (in
case of Cell Broadcast there's no one to inform.   In case of the
SimAppAgent our d-bus api doesn't let us do it.  In case of SMS-PP
download it's a technical difficulty).  But, for example the Timer
Expiration event is more complicated because it needs to be retried
until it succeeds, and every time we retry sending the envelope it
will be different because it contains current time.  So the Timer
Expiration retrying has to be imlemented separately.

>
>> =C2=A0};
>>
>> +#define ENVELOPE_RETRIES_DEFAULT 5
>> +
>> +static void envelope_queue_run(struct ofono_stk *stk);
>> +
>> =C2=A0static int stk_respond(struct ofono_stk *stk, struct stk_response =
*rsp,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 void (*cb)(const struct ofono_error *error,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ofono=
_stk *stk))
>> @@ -72,37 +86,87 @@ static int stk_respond(struct ofono_stk *stk, struct=
 stk_response *rsp,
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> -static int stk_send_envelope(struct ofono_stk *stk, struct stk_envelope=
 *e,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void (*cb)(const struct ofono_error *error,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const unsigned char *data,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int length,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct ofono_stk *stk))
>> +static void envelope_cb(const struct ofono_error *error, const uint8_t =
*data,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
int length, void *user_data)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_stk *stk =3D user_data;
>> + =C2=A0 =C2=A0 struct envelope_op *op =3D g_queue_peek_head(stk->envelo=
pe_q);
>> + =C2=A0 =C2=A0 gboolean result =3D TRUE;
>> +
>> + =C2=A0 =C2=A0 stk->envelope_q_busy =3D FALSE;
>> +
>> + =C2=A0 =C2=A0 if (op->retries > 0 && error->type =3D=3D OFONO_ERROR_TY=
PE_SIM &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
error->error =3D=3D 0x9300) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 op->retries--;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>
> You might really want to use an increasing retry timeout here.

For now I'm hoping that this retrying is purely theoretical, and it
never happens in practice.  The problem with increasing timeouts is
that there's a period where we're not doing anything.  And if we have
an envelope like Menu Selection or Timer Expiration later in the
queue, we don't want to delay it.

>
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D FALSE;
>> +
>> + =C2=A0 =C2=A0 g_queue_pop_head(stk->envelope_q);
>> +
>> + =C2=A0 =C2=A0 if (op->cb)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 op->cb(stk, result, data, le=
ngth);
>> + =C2=A0 =C2=A0 g_free(op);
>> +
>> +out:
>> + =C2=A0 =C2=A0 envelope_queue_run(stk);
>> +}
>> +
>> +static void envelope_queue_run(struct ofono_stk *stk)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 const guint8 *tlv;
>> =C2=A0 =C2=A0 =C2=A0 unsigned int tlv_len;
>>
>> - =C2=A0 =C2=A0 e->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
>> + =C2=A0 =C2=A0 while (stk->envelope_q_busy =3D=3D FALSE &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
g_queue_get_length(stk->envelope_q) > 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct envelope_op *op =3D g=
_queue_peek_head(stk->envelope_q);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlv =3D stk_pdu_from_envelop=
e(&op->e, &tlv_len);
>
> Do you think it is efficient for us to re-encode the envelope every time
> the queue is retried? =C2=A0What about encoding once during send (and
> erroring out right away if that fails) and then simply storing the PDU?
> =C2=A0Might make the code a bit simpler too.

Yes, good idea.

Regards

--===============6058036335460069664==--

