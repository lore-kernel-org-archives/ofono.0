Content-Type: multipart/mixed; boundary="===============1564307743206386933=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 3/3] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 17:52:40 +0200
Message-ID: <5b442107-0001-4d97-2c60-2e368fa0e5d6@norrbonn.se>
In-Reply-To: <584db322-9372-38a4-dfc0-af2c6b7b4737@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1564307743206386933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 24/09/2019 17:05, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 9/24/19 6:33 AM, Jonas Bonn wrote:
>> uBlox devices present their USB interfaces well before those interfaces
>> are ready to respond to any commands.=C2=A0 The documentation says to mo=
nitor
>> the 'greeting text' to detect readiness, but this 'greeting text' is not
>> actually specified for any device other than the TOBY L4.
>>
>> What seems to work is to probe the device with 'AT' commands until the
>> device responds, and then to wait an additional second before
>> proceeding.=C2=A0 The TOBY L4 reliably sends its 'greeting text' (+AT: R=
EADY)
>> within this interval.
>>
>> It would be more rigorous to actually wait for the 'READY' indication
>> for the TOBY L4, but that would require knowing the device model before
>> the device model is actually queried.=C2=A0 This is doable via the USB
>> product ID, but overkill when the above heuristic seems to work
>> reliably.
>>
>> Before this patch, the ublox plugin was trying to achieve something like
>> the above with the g_at_chat_set_wakeup_command() function, but that had
>> some issues:
>>
>> i)=C2=A0 it did not work reliably, in particular failing badly on the TO=
BY L4
>> with responses getting out of sync with commands
>> ii) it was an inappropriate use of the wakeup_command which is intended
>> for devices that may sleep when there is no communication during some
>> interval
>>
>> This patch adds an init sequence that probes the device for readiness
>> before continuing with initialization.
>> ---
>> =C2=A0 plugins/ublox.c | 121 ++++++++++++++++++++++++++++++++++++++++++-=
-----
>> =C2=A0 1 file changed, 107 insertions(+), 14 deletions(-)
>>
>> diff --git a/plugins/ublox.c b/plugins/ublox.c
>> index 9ee38a6b..656dc553 100644
>> --- a/plugins/ublox.c
>> +++ b/plugins/ublox.c
>> @@ -29,6 +29,7 @@
>> =C2=A0 #include <glib.h>
>> =C2=A0 #include <gatchat.h>
>> =C2=A0 #include <gattty.h>
>> +#include <ell/ell.h>
>> =C2=A0 #define OFONO_API_SUBJECT_TO_CHANGE
>> =C2=A0 #include <ofono/plugin.h>
>> @@ -66,6 +67,10 @@ struct ublox_data {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct ublox_model *model;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flags;
>> +
>> +=C2=A0=C2=A0=C2=A0 struct l_timeout *init_timeout;
>> +=C2=A0=C2=A0=C2=A0 int init_count;
>> +=C2=A0=C2=A0=C2=A0 guint init_cmd;
>> =C2=A0 };
>> =C2=A0 static void ublox_debug(const char *str, void *user_data)
>> @@ -223,6 +228,82 @@ fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, FALSE);
>> =C2=A0 }
>> +static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct ublox_data *data =3D ofono_modem_get_data(mod=
em);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!ok)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* When the 'init command' succeeds, we insert an ad=
ditional
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * delay of 1 second before proceeding with the=
 actual
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * intialization of the device.=C2=A0 We reuse =
the init_timeout
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * instance for this, just clearing the command=
 to indicate
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * that additional retries aren't necessary.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 data->init_cmd =3D 0;
>> +=C2=A0=C2=A0=C2=A0 data->init_count =3D 0;
>> +=C2=A0=C2=A0=C2=A0 l_timeout_modify_ms(data->init_timeout, 1000);
>> +
>> +=C2=A0=C2=A0=C2=A0 return;
>> +
>> +fail:
>> +=C2=A0=C2=A0=C2=A0 l_timeout_remove(data->init_timeout);
>> +=C2=A0=C2=A0=C2=A0 data->init_timeout =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->aux);
>> +=C2=A0=C2=A0=C2=A0 data->aux =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->modem);
>> +=C2=A0=C2=A0=C2=A0 data->modem =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, FALSE);
>> +}
>> +
>> +static void init_timeout_cb(struct l_timeout *timeout, void *user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct ublox_data *data =3D ofono_modem_get_data(mod=
em);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* As long as init_cmd is set we need to either keep=
 retrying
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * or fail everything after excessive retries
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (data->init_cmd && data->init_count++ < 20) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_retry(data->aux, d=
ata->init_cmd);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_timeout_modify_ms(timeout,=
 1000);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
> =

> Can data->init_cmd be 0 here?

Yes... init_cmd gets cleared in init_cmd_cb when the command succeeds. =

We reuse the callback to get an extra 1 second delay (which we require) =

before continuing with the initialization.  There's a comment about this =

in init_cmd_cb above.

> =

>> +
>> +=C2=A0=C2=A0=C2=A0 l_timeout_remove(data->init_timeout);
>> +=C2=A0=C2=A0=C2=A0 data->init_timeout =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (data->init_cmd) {
> =

> Or here?

Yes.

> =

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_error("failed to init =
modem after 20 attempts");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "ATE0", none_prefix,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL, NULL);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "AT+CMEE=3D1", none_prefix,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 query_model_cb, modem, NULL) > 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +fail:
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->aux);
>> +=C2=A0=C2=A0=C2=A0 data->aux =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->modem);
>> +=C2=A0=C2=A0=C2=A0 data->modem =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, FALSE);
>> +=C2=A0=C2=A0=C2=A0 return;
> =

> This return isn't needed, and you may want to just put these statements =

> into a common utility since you copy-paste this in two places.

Yes, but it's not needed anywhere else... are you requiring a static =

inline function for this or can I just resubmit this without the return =

statement?

/Jonas

> =

>> +}
>> +
>> +
> =

> No double empty lines please
> =

>> =C2=A0 static int ublox_enable(struct ofono_modem *modem)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ublox_data *data =3D ofono_modem_g=
et_data(modem);
>> @@ -250,22 +331,34 @@ static int ublox_enable(struct ofono_modem *modem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_send(da=
ta->modem, "AT&C0", NULL, NULL, NULL, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 /* The modem can take a while to wake up if just pow=
ered on. */
>> -=C2=A0=C2=A0=C2=A0 g_at_chat_set_wakeup_command(data->aux, "AT\r", 1000=
, 11000);
>> -
>> -=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "ATE0", none_prefix,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL, NULL);
>> -=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "AT+CMEE=3D1", none_prefix,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL, NULL);
>> -
>> -=C2=A0=C2=A0=C2=A0 if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 query_model_cb, modem, NULL) > 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINPROGRESS;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * uBlox devices present their USB interfaces w=
ell before those
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * interfaces are actually ready to use.=C2=A0 =
The specs say to monitor
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the 'greeting text' to detect whether the de=
vice is ready to use;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * unfortunately, other than for the TOBY L4, t=
he greeting text is
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * not actually specified.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * What has been determined experimentally to w=
ork is to probe with
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * an 'AT' command until it responds and then w=
ait an additional
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * second before continuing with device initial=
ization.=C2=A0 Even for
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the TOBY L4 where one should wait for the '+=
AT: READY' URC
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * before intialization, this seems to be suffi=
cient; the 'READY'
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * indication always arrives within this time.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * (It would be more rigorous to actually wait =
for the 'READY'
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * indication, but that would require knowing t=
he device model
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * before the device model is actually queried.=
=C2=A0 Do-able via
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * USB Product ID, but overkill when the above =
seems to work
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reliably.)
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->aux);
>> -=C2=A0=C2=A0=C2=A0 data->aux =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 data->init_count =3D 0;
>> +=C2=A0=C2=A0=C2=A0 data->init_cmd =3D g_at_chat_send(data->aux, "AT", n=
one_prefix,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_cmd_cb, modem, NULL);
>> +=C2=A0=C2=A0=C2=A0 data->init_timeout =3D l_timeout_create_ms(500, init=
_timeout_cb, =

>> modem,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 NULL);
>> -=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 return -EINPROGRESS;
>> =C2=A0 }
>> =C2=A0 static void cfun_disable(gboolean ok, GAtResult *result, gpointer =

>> user_data)
>>
> =

> Regards,
> -Denis

--===============1564307743206386933==--

