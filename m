Content-Type: multipart/mixed; boundary="===============8429838020927709420=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [RFC] voicecall: Allow second stage string on Dial()
Date: Fri, 19 Jul 2013 02:36:56 -0300
Message-ID: <CAMOw1v6paRAonYJN-GgjxFMSB78Z+WJPiwvhyVxO2TxVL+TDGA@mail.gmail.com>
In-Reply-To: <51E83909.1090802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8429838020927709420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2013 at 3:50 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Lucas,
>
>
> On 07/17/2013 06:23 PM, Lucas De Marchi wrote:
>>
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> Use a pause to separate the number to dial from the second stage part,
>> that is sent as tones. We wait until the call becomes ACTIVE and even
>> the first pause is applied (we wait 3s before continuing with the
>> second stage).
>
>
> That description is confusing.  What's 'even the first pause is applied'?
> You might want to just cite 22.101 A.21 or simply quote it in the code or
> commit description.

Ha... there is what I was looking for and didn't find.  With "even the
first pause" I meant:  we don't send the tones right away when the
call becomes ACTIVE, but rather we wait the first pause.
Nice to know there is this spec so I can throw away my worries if this
was the right thing to do here.

>
>
>> ---
>>
>> A starting point to implement the dialtstring item in the TODO list.  I
>> couldn't find a better way to propagate the second stage string until the
>> call
>> reaches the ACTIVE state.  So I've put it in ofono_voicecall, that
>> "propagates"
>> the string until we reach that state.
>>
>> Due to the fact that manager_dial_callback() can be called before or aft=
er
>> the
>> voicecall is in ACTIVE state, we need some checks here and there in order
>> not
>> to do the wrong thing.
>
>
> Sorry, but what does manager_dial_callback() have to do with?
>
> Just FYI, what happens in practice is one of two scenarios:
> ATD....;
> OK
>
> -> Active call
>
> or
>
> ATD....;
> OK
>
> CALLSTATE: dialing
> CALLSTATE: alerting
> CALLSTATE: active
>
> The second being vastly more common.  There is another hypothetical
> scenario, but I've not seen any hardware do this:
>
> ATD....;
> CALLSTATE:dialing
> CALLSTATE:alerting
> OK
> CALLSTATE:active
>
> In HFP, we might get another scenario where the AG dials the number:
>
> CALLSTATE: dialing
> CALLSTATE: alerting
> CALLSTATE: active
>
> But then this one is not relevant to your problem.

Humn...  I was guided by this comment in dial_handle_result():

/*
 * Dial request may return before existing active call
 * is put on hold or after dialed call has got active
 */

So either I misunderstood what "after dialed call has got active" means or:

ATD...;
CALLSTATE: dialing
CALLSTATE: alerting
CALLSTATE: active
OK

>
>
>>
>> Let me know if there's an easier way to handle it.
>>
>>
>> Maybe we should export a property in the voicecall? And set it to an err=
or
>> if later the send-tones failed?  Thoughts?
>
>
> The user can disconnect / switch the call to a Held state mid-way for

mid-way while the tones are being sent, right?

> example, in which case all the tones are lost.  I think that this is just
> fine, unless you have some nice way of presenting this fact to the user?

I was thinking about a property SecondStageNumber that is set once we
start sending it and then if it errors out, we set it to "error" or
the like.
Or we can update the property like below:

SecondStageNumber=3D1234567AB
...
SecondStageNumber=3D4567AB
...
SecondStageNumber=3DAB
SecondStageNumber=3D"failed"

Just throwing away some ideas... We could do it with signals too:

SendToneStarted(string complete_number)
SendToneUpdate(string partial_number)
SendToneEnd()

I think this would cover the other TODO item?

"
- Provide feedback of sent DTMF tones. Emit SendingTones signal if modem can
  provide approximate starting and stopping times for DTMF tones. Signal
  argument contains a string of DTMF tones to be sent, or empty string when
  all tones has been sent."

Or what the TODO item says.

>
> Another interesting case to consider is what should happen if we have a
> Three-Way call, start a DTMF queue and then swap calls.

Right now we continue sending the tones, right? We could change
voicecall.c to associate a queue to the active call and throw it away
when this  call change state, setting the property to error as above.


>
>
>>
>> Lucas De Marchi
>>
>>   src/voicecall.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index ae76b91..f49942d 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -72,6 +72,7 @@ struct ofono_voicecall {
>>         unsigned int hfp_watch;
>>         GKeyFile *settings;
>>         char *imsi;
>> +       char *pending_tones;
>>         ofono_voicecall_cb_t release_queue_done_cb;
>>         struct ofono_emulator *pending_em;
>>         unsigned int pending_id;
>> @@ -83,6 +84,7 @@ struct voicecall {
>>         time_t start_time;
>>         time_t detect_time;
>>         char *message;
>> +       char *pending_tones;
>>         uint8_t icon_id;
>>         gboolean untracked;
>>         gboolean dial_result_handled;
>
>
> Why do we need pending_tones in both voicecall and ofono_voicecall? Can't=
 we
> get away with just one?

Because until we have a a voicecall, where do we put the string that we cre=
ated?

And once we have a voicecall, we have to wait until the ACTIVE state.
We don't want to start sending the tones because another voicecall
became ACTIVE.


>
>
>> @@ -394,7 +396,7 @@ static void tone_request_finish(struct ofono_voiceca=
ll
>> *vc,
>>   {
>>         g_queue_remove(vc->toneq, entry);
>>
>> -       if (callback)
>> +       if (callback && entry->cb)
>>                 entry->cb(error, entry->user_data);
>>
>>         if (entry->destroy)
>> @@ -707,6 +709,7 @@ static void voicecall_destroy(gpointer userdata)
>>
>>         g_free(voicecall->call);
>>         g_free(voicecall->message);
>> +       g_free(voicecall->pending_tones);
>>
>>         g_free(voicecall);
>>   }
>> @@ -750,6 +753,19 @@ static void voicecall_emit_multiparty(struct
>> voicecall *call, gboolean mpty)
>>                                                 &val);
>>   }
>>
>> +static void voicecall_handle_pending_tones(struct voicecall *call)
>> +{
>> +       if (call->call->status !=3D CALL_STATUS_ACTIVE)
>> +               return;
>> +
>> +       if (call->pending_tones =3D=3D NULL)
>> +               return;
>> +
>> +       tone_queue(call->vc, call->pending_tones, NULL, NULL, NULL);
>> +       g_free(call->pending_tones);
>> +       call->pending_tones =3D NULL;
>> +}
>> +
>>   static void emulator_set_indicator_forced(struct ofono_voicecall *vc,
>>                                                 const char *name, int
>> value)
>>   {
>> @@ -946,6 +962,13 @@ static void voicecall_set_call_status(struct
>> voicecall *call, int status)
>>
>>                 if (call->vc->dial_req && call =3D=3D
>> call->vc->dial_req->call)
>>                         dial_request_finish(call->vc);
>> +
>> +               if (call->vc->pending_tones !=3D NULL) {
>> +                       call->pending_tones =3D call->vc->pending_tones;
>> +                       call->vc->pending_tones =3D NULL;
>> +               }
>> +
>
>
> So we just shuffle from one struct to another.  Even though we're guarant=
eed
> to have ATD finish before set_call_status is called with an active call.

If this is indeed true, then  we can remove the pass-the-baton above.

>
>> +               voicecall_handle_pending_tones(call);
>
>
> Then why do we check for ACTIVE state in voicecall_handle_pending_tones?

Yep, we can move the check to the other place that calls this function.

>
>
>>         }
>>
>>         if (status =3D=3D CALL_STATUS_DISCONNECTED && call->vc->dial_req=
 &&
>> @@ -1459,6 +1482,10 @@ static struct voicecall *dial_handle_result(struct
>> ofono_voicecall *vc,
>>         vc->call_list =3D g_slist_insert_sorted(vc->call_list, v,
>>                                 call_compare);
>>
>> +       v->pending_tones =3D vc->pending_tones;
>> +       vc->pending_tones =3D NULL;
>> +       voicecall_handle_pending_tones(v);
>> +
>
>
> Again with the shuffling.  Why don't we simply use the number argument in
> this function, find out if we have a dial string, and either queue the to=
nes
> right here or store it for the future.

Right... it was my first option... I may need to write it again to
remember why I decided to change :-/

>
>
>>         *need_to_emit =3D TRUE;
>>
>>   handled:
>> @@ -1494,6 +1521,9 @@ static void manager_dial_callback(const struct
>> ofono_error *error, void *data)
>>                 if (is_emergency_number(vc, number) =3D=3D TRUE)
>>                         __ofono_modem_dec_emergency_mode(modem);
>>
>> +               g_free(vc->pending_tones);
>> +               vc->pending_tones =3D NULL;
>> +
>
>
> See above, I think we can get away without having pending_tones inside
> ofono_voicecall.

ok

>
>
>>                 reply =3D __ofono_error_failed(vc->pending);
>>         }
>>
>> @@ -1552,7 +1582,8 @@ static DBusMessage *manager_dial(DBusConnection
>> *conn,
>>                                         DBusMessage *msg, void *data)
>>   {
>>         struct ofono_voicecall *vc =3D data;
>> -       const char *number;
>> +       char *number_nopause =3D NULL;
>> +       const char *number, *tones;
>>         const char *clirstr;
>>         enum ofono_clir_option clir;
>>         int err;
>> @@ -1570,12 +1601,24 @@ static DBusMessage *manager_dial(DBusConnection
>> *conn,
>>
>>         vc->pending =3D dbus_message_ref(msg);
>>
>> +       tones =3D strpbrk(number, "pP");
>> +
>
>
> Doing this is not safe, you might want to sanitize this input.

How so? Searching for "pP" is as safe as calculating the length in
valid_number_format().

>
>
>> +       if (tones !=3D NULL) {
>> +               number_nopause =3D g_strndup(number, tones - number);
>> +               vc->pending_tones =3D g_ascii_strup(tones, -1);
>> +               number =3D number_nopause;
>> +       }

Doing this above may not be. Isn't this what you were referring to instead?

If passing the length to the sanitize functions called by
voicecall_dial() is acceptable, then I can get away with the dup
above. The tones part is as safe as the one used in
manager_send_tones().


Lucas De Marchi

--===============8429838020927709420==--

