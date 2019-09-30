Content-Type: multipart/mixed; boundary="===============5126781436362546486=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 3/4] quectel: rework sim detection
Date: Mon, 30 Sep 2019 22:04:58 +0200
Message-ID: <2d791424-49e9-3fc8-80be-244b779cacea@geanix.com>
In-Reply-To: <20d45d76-089c-09e7-3025-0b24c598b7ca@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5126781436362546486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 27/09/2019 00.10, Denis Kenzior wrote:
> On 9/26/19 2:27 PM, Martin Hundeb=C3=B8ll wrote:
>> Simplify sim handling by querying cpin state directly from
>> quectel_pre_sim().
> =

> Don't initiate commands from pre_sim/post_sim/post_online callbacks =

> please.=C2=A0 There's almost never a reason to.

Ok.

>>
>> The query is conducted by issuing a AT+CPIN?, where only CME errors are
>> catched by the command response handler. The +CPIN: <state> response is
>> instead catched by a listener.
> =

> nit: s/catched/caught
> =

>>
>> The CME handler allows proper handling of the sim-busy and sim-not-
>> inserted states, which are returned as CME errors by the quectel
>> modems.
>>
>> The +CPIN listener allows handling of both sim-locked and sim-ready
>> states. When the sim is not locked, the listener catches the +CPIN:
>> READY response from the query in quectel_pre_sim(). If the sim is
>> locked, the listener catched the +CPIN: READY indication received after
>> unlocking the sim.
>> ---
>> =C2=A0 plugins/quectel.c | 401 +++++++++++++++++------------------------=
-----
>> =C2=A0 1 file changed, 149 insertions(+), 252 deletions(-)
>>
> =

> <snip>
> =

>> @@ -751,9 +534,8 @@ static void cfun_enable(gboolean ok, GAtResult =

>> *result, gpointer user_data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbus_hw_enable(modem);
>> -
>> -=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, c=
pin_query, =

>> modem,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL=
);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix=
, NULL, NULL, =

>> NULL);
> =

> Don't you want to wait until this succeeds?

Might as well.

> Also, you could issue a query for CPIN here and record whether the sim =

> is inserted.=C2=A0 I assume no hot-swap of SIM is supported?
> =

>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, true);
>> =C2=A0 }
>> =C2=A0 static void cfun_query(gboolean ok, GAtResult *result, gpointer =

>> user_data)
> =

> <snip>
> =

>> +
>> +=C2=A0=C2=A0=C2=A0 if (ofono_sim_get_state(data->sim) =3D=3D OFONO_SIM_=
STATE_INSERTED)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_initialized_notify=
(data->sim);
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_inserted_notify(da=
ta->sim, true);
> =

> This is a strange dance.=C2=A0 Shouldn't the modem tell you up front that=
 the =

> SIM is inserted or not?=C2=A0 So then you only need to run QINISTAT when =
it =

> goes from pin locked to unlocked?

These modems are really picky about when to do what.

If the sim is locked, we need to do some initial work to enable entering =

the pin.

If it is not, then we really need to wait with reading sim files until =

qinistat is ready.

I've made another attempt in the v2 sim-rework patch.

>> +}
>> +
>> +static void init_timer_cb(struct l_timeout *timeout, void *user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct quectel_data *data =3D ofono_modem_get_data(m=
odem);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "AT+QINISTAT", qinistat_pr=
efix, =

>> qinistat_cb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode=
m, NULL);
>> +}
>> +
>> +static void sim_watch_cb(GAtResult *result, void *user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct quectel_data *data =3D ofono_modem_get_data(m=
odem);
>> +=C2=A0=C2=A0=C2=A0 enum ofono_sim_state state =3D ofono_sim_get_state(d=
ata->sim);
>> +=C2=A0=C2=A0=C2=A0 const char *path =3D ofono_modem_get_path(modem);
>> +=C2=A0=C2=A0=C2=A0 GAtResultIter iter;
>> +=C2=A0=C2=A0=C2=A0 const char *cpin;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_result_iter_init(&iter, result);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!g_at_result_iter_next(&iter, "+CPIN:"))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> -=C2=A0=C2=A0=C2=A0 switch (data->sim_state) {
>> -=C2=A0=C2=A0=C2=A0 case OFONO_SIM_STATE_LOCKED_OUT:
>> -=C2=A0=C2=A0=C2=A0 case OFONO_SIM_STATE_READY:
>> +=C2=A0=C2=A0=C2=A0 g_at_result_iter_next_unquoted_string(&iter, &cpin);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (g_strcmp0(cpin, "NOT INSERTED") =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_warn("%s: sim not pres=
ent", path);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (g_strcmp0(cpin, "READY") !=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (state !=3D OFONO_SIM_STA=
TE_INSERTED) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofon=
o_info("%s: sim locked", path);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofon=
o_sim_inserted_notify(data->sim, true);
> =

> Okay, but=C2=A0 it might be easier to just know this up front whether the=
 sim =

> is inserted or not.

I think I am getting close in the v2 patch.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unregister(data->aux, data->sim_watch);
>> +=C2=A0=C2=A0=C2=A0 data->sim_watch =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 data->init_timeout =3D l_timeout_create_ms(500, init=
_timer_cb, =

>> modem, NULL);
>> +=C2=A0=C2=A0=C2=A0 if (!data->init_timeout) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close_serial(modem);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
> =

> So then this READY case becomes simple.=C2=A0 Didn't you also say that =

> Quectel sends +CPIN: READY unsolicited?

It does, but we might miss the initial one during the retry-dance after =

powerup, or if ofono is started long after the modem is initialized =

(sans gpio).

It does send a +CPIN: READY after the pin is entered, though.

>> +}
>> +
>> +static void cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct quectel_data *data =3D ofono_modem_get_data(m=
odem);
>> +=C2=A0=C2=A0=C2=A0 struct ofono_error error;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ok)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 decode_at_error(&error, g_at_result_final_response(r=
esult));
>> +
>> +=C2=A0=C2=A0=C2=A0 if (error.type !=3D OFONO_ERROR_TYPE_CME)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (error.error) {
>> +=C2=A0=C2=A0=C2=A0 case 5:
>> +=C2=A0=C2=A0=C2=A0 case 6:
>> +=C2=A0=C2=A0=C2=A0 case 7:
>> +=C2=A0=C2=A0=C2=A0 case 11:
>> +=C2=A0=C2=A0=C2=A0 case 12:
>> +=C2=A0=C2=A0=C2=A0 case 17:
>> +=C2=A0=C2=A0=C2=A0 case 18:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_inserte=
d_notify(data->sim, true);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0 case 10:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_warn("%s: sim not pres=
ent", ofono_modem_get_path(modem));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case 13:
>> +=C2=A0=C2=A0=C2=A0 case 14:
>> +=C2=A0=C2=A0=C2=A0 case 15:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* wait for +CPIN: indicatio=
n */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_error("unknown cpin er=
ror: %i", error.error);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
> =

> at_util_sim_state_query_new does most of this for you btw...

Thanks for the hint.

I tried this once some time ago, but I needed not only present =

true/false, but also locked/unlocked. This is queried in the v2 patch now.

>> +static void quectel_pre_sim(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct quectel_data *data =3D ofono_modem_get_data(m=
odem);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_voicecall_create(modem, data->vendor, "atmodem=
", data->aux);
>> +=C2=A0=C2=A0=C2=A0 data->sim =3D ofono_sim_create(modem, data->vendor, =
"atmodem", =

>> data->aux);
>> +=C2=A0=C2=A0=C2=A0 data->sim_watch =3D g_at_chat_register(data->aux, "+=
CPIN:", =

>> sim_watch_cb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FALSE=
, modem, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * unsolicited indications about a missing or l=
ocked sim can =

>> occur before
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the auto-baud dance in open_serial(), so iss=
ue a CPIN query here
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the callback is only called for CME errors t=
o catch those. The =

>> +CPIN
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * response is catched by the watch registered =
above
> =

> nit: caught
> =

>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "AT+CPIN?", none_prefix, c=
pin_cb, =

>> modem, NULL);
> =

> So as mentioned before, don't run commands in pre_sim.=C2=A0 You can do t=
his =

> as part of .enable sequence instead, store sim presence info and simply =

> call sim_create & sim_inserted if needed.

Got it.

// Martin
--===============5126781436362546486==--

