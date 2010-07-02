Content-Type: multipart/mixed; boundary="===============2525937247968001075=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/9] stk: Handle ENVELOPEs in a queue, retry on sim busy.
Date: Thu, 01 Jul 2010 21:28:45 -0500
Message-ID: <4C2D4EDD.1000701@gmail.com>
In-Reply-To: <AANLkTim0qPTPK392IBQUtYkHu2ZIe8iI3wCriKXqGSwf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2525937247968001075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> +     GQueue *envelope_q;
>>> +};
>>> +
>>> +struct envelope_op {
>>> +     struct stk_envelope e;
>>> +     int retries;
>>> +     void (*cb)(struct ofono_stk *stk, gboolean ok,
>>> +                     const unsigned char *data, int length);
>>
>> Is the callback really needed?  What can we intelligently do besides
>> printing an error to the log?
> =

> In the generic case we should inform whoever asked us to submit the
> information to the UICC.  We don't currently have any such case (in
> case of Cell Broadcast there's no one to inform.   In case of the
> SimAppAgent our d-bus api doesn't let us do it.  In case of SMS-PP
> download it's a technical difficulty).  But, for example the Timer
> Expiration event is more complicated because it needs to be retried
> until it succeeds, and every time we retry sending the envelope it
> will be different because it contains current time.  So the Timer
> Expiration retrying has to be imlemented separately.
> =


So I suggest keeping it simple for now and not having the callback.  We
can always add it if really needed.

>>> +static void envelope_cb(const struct ofono_error *error, const uint8_t=
 *data,
>>> +                     int length, void *user_data)
>>> +{
>>> +     struct ofono_stk *stk =3D user_data;
>>> +     struct envelope_op *op =3D g_queue_peek_head(stk->envelope_q);
>>> +     gboolean result =3D TRUE;
>>> +
>>> +     stk->envelope_q_busy =3D FALSE;
>>> +
>>> +     if (op->retries > 0 && error->type =3D=3D OFONO_ERROR_TYPE_SIM &&
>>> +                     error->error =3D=3D 0x9300) {
>>> +             op->retries--;
>>> +             goto out;
>>
>> You might really want to use an increasing retry timeout here.
> =

> For now I'm hoping that this retrying is purely theoretical, and it
> never happens in practice.  The problem with increasing timeouts is
> that there's a period where we're not doing anything.  And if we have
> an envelope like Menu Selection or Timer Expiration later in the
> queue, we don't want to delay it.
> =


Ok fair enough.

Regards,
-Denis

--===============2525937247968001075==--

