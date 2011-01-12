Content-Type: multipart/mixed; boundary="===============7279893219462319081=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 2/2] ifxmodem: add enable/disable ctm support
Date: Wed, 12 Jan 2011 14:58:49 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802D59E62@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1294811942.3873.49.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7279893219462319081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

ofono-bounces(a)ofono.org wrote:
>> +static void xctms_modify_cb(gboolean ok, GAtResult *result,
>> gpointer +user_data) { +	struct cb_data *cbd =3D user_data;
>> +	ofono_ctm_set_cb_t cb =3D cbd->cb;
>> +	struct ofono_error error;
>> +	const char *setting =3D NULL;
>> +	struct ofono_ctm *ctm =3D cbd->user;
>> +	struct ctm_data *ctmd =3D ofono_ctm_get_data(ctm);
>> +	ofono_bool_t enable =3D ctmd->enable;
>> +
>> +	decode_at_error(&error, g_at_result_final_response(result)); +
>> +	if (!ok) {
>> +		cb(&error, cbd->data);
>> +		return;
>> +	}
>> +
>> +	if (g_strcmp0(ctmd->audio_setting, "FULL_DUPLEX") =3D=3D 0) +
setting
>> =3D "0,0,0,0,0,0,0"; +	else if (g_strcmp0(ctmd->audio_setting,
>> "BURSTMODE_48KHZ") =3D=3D 0) +		setting =3D "0,0,8,0,2,0,0"; +
else if
>> (g_strcmp0(ctmd->audio_setting, "BURSTMODE_96KHZ") =3D=3D 0) +
setting
>> =3D "0,0,9,0,2,0,0"; + +	if (setting) {
>> +		char xdrv_buf[64];
>> +
>> +		/* configure source */
>> +		snprintf(xdrv_buf, sizeof(xdrv_buf),
"AT+XDRV=3D40,4,%d,%d,%s,%s",
>> +						4, +
0,
>> +						setting,
>> +						enable ? "2,5" : "0,0");
>> +		g_at_chat_send(ctmd->chat, xdrv_buf, xdrv_prefix, NULL,
NULL,
>> +				NULL); +
>> +		/* configure destination */
>> +		snprintf(xdrv_buf, sizeof(xdrv_buf),
"AT+XDRV=3D40,5,%d,%d,%s,%s",
>> +						3, +
0,
>> +						setting,
>> +						enable ? "2,6" : "0,0");
>> +
>> +		g_at_chat_send(ctmd->chat, xdrv_buf, xdrv_prefix, NULL,
NULL,
>> +				NULL); +	}
> =

> Now this is something I don't like at all. It is copied code from the
> modem plugin. =


Its the same audio configuration code except that there is a new
parameter added
at the end of the parameter list for TTY case.

> =

> The initial discussion was that we need to configure XDRV
> only once during init and never have to touch it again. That
> seems to be not true anymore. So what is the deal here?
> =


Audio source/destination parameter includes configuration and transducer
mode

TRANSDUCER is the difference. Incase of voice call it is set to
default(0) whereas
for TTY call it is set to TRANSDUCER TTY( 5 for source and 6 for
destination).

TTY call - Last 2 parameters are 2,5 and 2,6 for the source(uplink) and
destination(downlink) respectively.
Voice call - Last 2 parameters are 0,0.

> Also if this is required, we might need to figure out a
> complete different way of handling this. We can't have this
> in two places since that means a full disconnect. Maybe
> putting this into the audio settings atom might be better.
> However before we can do anything, I have to understand the
> semantics behind XDRV, normal voice calls and TTY calls.
> =


Correct me if I'm wrong. If we move this to the audio settings atom,
then I'm
afraid that it will end up in used by only ifx modem. =


> =

> We wanna be consistent, so pleace do ifx_ctm_init(void) here.
> =

>> +	ofono_ctm_driver_register(&driver);
>> +}
>> +
>> +void ifx_ctm_exit()
>> +{
> =

> Same here. And for extra bonus points, I accept patches that
> fixes this inside the whole oFono tree ;)
> =

> It is coding style rule M15 now.
> =


Separate set of patches sent for the M15 coding style rule fix for the
whole oFono tree.

Regards,
Jeevaka

--===============7279893219462319081==--

