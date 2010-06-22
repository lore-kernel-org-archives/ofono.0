Content-Type: multipart/mixed; boundary="===============0238478345593927253=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/4] stk: Allow registering proactive command handlers.
Date: Wed, 23 Jun 2010 00:14:28 +0200
Message-ID: <AANLkTil0oYlMv0iHtUq35K9sE1RZwM-dQ_GFhMha5NDJ@mail.gmail.com>
In-Reply-To: <201006221642.23328.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0238478345593927253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 22 June 2010 23:42, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
>> ---
>> =C2=A0src/stk.c | =C2=A0144
>> =C2=A0+++++++++++++++++++++++++++++++++++++++++++++++++++++++------ 1
> files
>> =C2=A0changed, 131 insertions(+), 13 deletions(-)
>>
>> diff --git a/src/stk.c b/src/stk.c
>> index f472a63..1dd5b77 100644
>> --- a/src/stk.c
>> +++ b/src/stk.c
>> @@ -40,14 +40,85 @@
>>
>> =C2=A0static GSList *g_drivers =3D NULL;
>>
>> +typedef void (*generic_cb_t)(const struct ofono_error *error,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk);
>> +
>> +typedef void (*envelope_cb_t)(const struct ofono_error *error,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *rdata,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int length, struct ofono_stk *stk);
>
> User data?

Changed to just "data", as this is "response data".

>
>> +
>> +typedef gboolean (*command_handler_t)(const struct stk_command *cmd,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stk_response=
 *rsp,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *s=
tk);
>
> I think here we must have user data, especially if you're planning to use=
 it
> outside stk (e.g. in voicecall atom). =C2=A0Any reason why *stk can't sim=
ply be
> void *?

Well, these types are just copies of the types in include/ofono/stk.h,
which do take void *, so these ones are just for local use in this
file to make working with the stk_respond / stk_send_envelope
functions easier.

>
>> +
>> =C2=A0struct ofono_stk {
>> =C2=A0 =C2=A0 =C2=A0 const struct ofono_stk_driver *driver;
>> =C2=A0 =C2=A0 =C2=A0 void *driver_data;
>> =C2=A0 =C2=A0 =C2=A0 struct ofono_atom *atom;
>> + =C2=A0 =C2=A0 command_handler_t handlers[256];
>
> There are only 41 proactive commands, and we'll implement a subset. =C2=
=A0This
> seems a bit excessive. =C2=A0However, if we can't come up with anything m=
ore
> clever, I'm actually fine with it for fast access.

Ok, changed it to command_handler_t
handlers[STK_COMMAND_TYPE_END_SESSION + 1]; (that equals 0x82), is
that ok?

>
>> + =C2=A0 =C2=A0 struct stk_command *pending_cmd;
>> =C2=A0};
>>
>> +static void stk_respond(struct ofono_stk *stk, struct stk_command *cmd,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct stk_response *rsp, generic_cb_t cb)
>> +{
>
> Can we avoid passing in the original stk_command object? =C2=A0Since only=
 one
> command is pending at a time, sounds like we should be able to set it
> elsewhere easily.

Ok, I'll remove the parameter completely since it was only used twice
in the file.

>
> Is the plan to make this public API at some point? =C2=A0If so it definit=
ely
> requires userdata.

I was rather wanting them to be local, other files wouldn't need to
deal with stk_response or stk_envelope at all, instead stk.c would
pick the important bits from the structure and perhaps call a function
in the other file.

>
>> + =C2=A0 =C2=A0 struct ofono_error error =3D { .type =3D OFONO_ERROR_TYP=
E_FAILURE };
>> + =C2=A0 =C2=A0 const guint8 *tlv;
>> + =C2=A0 =C2=A0 unsigned int tlv_len;
>> +
>> + =C2=A0 =C2=A0 if (cmd =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D stk->pending_cmd;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stk->pending_cmd =3D cmd;
>> +
>> + =C2=A0 =C2=A0 rsp->src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL;
>> + =C2=A0 =C2=A0 rsp->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
>> + =C2=A0 =C2=A0 rsp->number =3D cmd->number;
>> + =C2=A0 =C2=A0 rsp->type =3D cmd->type;
>> + =C2=A0 =C2=A0 rsp->qualifier =3D cmd->qualifier;
>> +
>> + =C2=A0 =C2=A0 if (stk->driver->terminal_response =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(&error, stk);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 tlv =3D stk_pdu_from_response(rsp, &tlv_len);
>> + =C2=A0 =C2=A0 if (!tlv) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(&error, stk);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 stk->driver->terminal_response(stk, tlv_len, tlv,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ofono_stk_generic_=
cb_t) cb, stk);
>> +}
>> +
>> +static void stk_send_envelope(struct ofono_stk *stk, struct stk_envelope
>> =C2=A0*e, + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0envelope_cb_t cb)
>
> Same comments here. =C2=A0Should this be public API with userdata?
>
>> +{
>> + =C2=A0 =C2=A0 struct ofono_error error =3D { .type =3D OFONO_ERROR_TYP=
E_FAILURE };
>> + =C2=A0 =C2=A0 const guint8 *tlv;
>> + =C2=A0 =C2=A0 unsigned int tlv_len;
>> +
>> + =C2=A0 =C2=A0 e->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
>> +
>> + =C2=A0 =C2=A0 if (stk->driver->envelope =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(&error, NULL, -1, stk);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 tlv =3D stk_pdu_from_envelope(e, &tlv_len);
>> + =C2=A0 =C2=A0 if (!tlv) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(&error, NULL, -1, stk);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 stk->driver->envelope(stk, tlv_len, tlv,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (ofono_stk_envelope_cb_t) cb, stk);
>> +}
>> +
>> =C2=A0static void stk_cbs_download_cb(const struct ofono_error *error,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *data, int len, void *user)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *data, int len,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("CellBroadc=
ast download to UICC failed");
>> @@ -56,34 +126,47 @@ static void stk_cbs_download_cb(const struct
>> =C2=A0ofono_error *error, return;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 if (len)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("CellBroadcast d=
ownload returned %i bytes of data",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 len);
>> +
>> =C2=A0 =C2=A0 =C2=A0 DBG("CellBroadcast download to UICC reported no err=
or");
>> =C2=A0}
>>
>> =C2=A0void __ofono_cbs_sim_download(struct ofono_stk *stk, const struct =
cbs
>> =C2=A0*msg) {
>> - =C2=A0 =C2=A0 const guint8 *tlv;
>> - =C2=A0 =C2=A0 unsigned int tlv_len;
>> =C2=A0 =C2=A0 =C2=A0 struct stk_envelope e;
>>
>> - =C2=A0 =C2=A0 if (stk->driver->envelope =3D=3D NULL)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 memset(&e, 0, sizeof(e));
>>
>> =C2=A0 =C2=A0 =C2=A0 e.type =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
>> =C2=A0 =C2=A0 =C2=A0 e.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
>> - =C2=A0 =C2=A0 e.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
>> =C2=A0 =C2=A0 =C2=A0 memcpy(&e.cbs_pp_download.page, msg, sizeof(msg));
>>
>> - =C2=A0 =C2=A0 tlv =3D stk_pdu_from_envelope(&e, &tlv_len);
>> - =C2=A0 =C2=A0 if (!tlv)
>> + =C2=A0 =C2=A0 stk_send_envelope(stk, &e, stk_cbs_download_cb);
>> +}
>> +
>> +static void stk_command_cb(const struct ofono_error *error,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ofono_stk *stk)
>> +{
>> + =C2=A0 =C2=A0 stk_command_free(stk->pending_cmd);
>> + =C2=A0 =C2=A0 stk->pending_cmd =3D NULL;
>> +
>> + =C2=A0 =C2=A0 if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("TERMINAL RESPON=
SE to a UICC command failed");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* "The ME may retry to deli=
ver the same Cell Broadcast
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* page." */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 stk->driver->envelope(stk, tlv_len, tlv, stk_cbs_downloa=
d_cb, stk);
>> + =C2=A0 =C2=A0 DBG("TERMINAL RESPONSE to a command reported no errors");
>> =C2=A0}
>>
>> =C2=A0void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int length, =
const unsigned char *pdu)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct stk_command *cmd;
>> + =C2=A0 =C2=A0 struct stk_response rsp;
>> =C2=A0 =C2=A0 =C2=A0 char *buf;
>> =C2=A0 =C2=A0 =C2=A0 int i;
>>
>> @@ -97,14 +180,49 @@ void ofono_stk_proactive_command_notify(struct
>> =C2=A0ofono_stk *stk, ofono_error("Can't parse proactive command: %s", b=
uf);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(buf);
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: return TERMINAL RES=
PONSE with permanent error */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* There's nothing we c=
an do, we'd need at least Command
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Details to respond w=
ith an error.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 g_free(buf);
>>
>> - =C2=A0 =C2=A0 /* TODO: execute */
>> + =C2=A0 =C2=A0 memset(&rsp, 0, sizeof(rsp));
>>
>> - =C2=A0 =C2=A0 g_free(buf);
>> - =C2=A0 =C2=A0 stk_command_free(cmd);
>> + =C2=A0 =C2=A0 switch (cmd->status) {
>> + =C2=A0 =C2=A0 case STK_PARSE_RESULT_OK:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stk->handlers[cmd->type]=
) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (stk->handlers[cmd->type](cmd, &rsp, stk) =3D=3D TRUE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
stk->pending_cmd =3D cmd;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fall through */
>> +
>> + =C2=A0 =C2=A0 case STK_PARSE_RESULT_TYPE_NOT_UNDERSTOOD:
>> + =C2=A0 =C2=A0 default:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D STK_RESU=
LT_TYPE_COMMAND_NOT_UNDERSTOOD;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 case STK_PARSE_RESULT_MISSING_VALUE:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D STK_RESU=
LT_TYPE_MINIMUM_NOT_MET;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 case STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D STK_RESU=
LT_TYPE_DATA_NOT_UNDERSTOOD;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 stk_respond(stk, cmd, &rsp, stk_command_cb);
>> +}
>> +
>> +static void stk_command_handler_register(struct ofono_stk *stk,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 enum stk_command_type type,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 command_handler_t handler)
>> +{
>> + =C2=A0 =C2=A0 stk->handlers[type] =3D handler;
>
> More error handling, might want to return an error if something is already
> registered.

Ok, added a check.

Regards

--===============0238478345593927253==--

