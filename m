Content-Type: multipart/mixed; boundary="===============0307108718184414579=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 19:49:32 +0200
Message-ID: <e799cbb1-f8c5-d81e-6056-80e2b7b033cb@norrbonn.se>
In-Reply-To: <CAHB-PjmvC3chu=xDoqxwekoNrQocvSdLgDsZ229uBUcDz=Q=4A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0307108718184414579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 24/09/2019 18:32, Richard R=C3=B6jfors wrote:
> Hi Jonas,
> =

> Den tis 24 sep. 2019 kl 18:01 skrev Jonas Bonn <jonas@norrbonn.se =

> <mailto:jonas@norrbonn.se>>:
> =

>     uBlox devices present their USB interfaces well before those interfac=
es
>     are ready to respond to any commands.=C2=A0 The documentation says to=
 monitor
>     the 'greeting text' to detect readiness, but this 'greeting text' is =
not
>     actually specified for any device other than the TOBY L4.
> =

>     What seems to work is to probe the device with 'AT' commands until the
>     device responds, and then to wait an additional second before
>     proceeding.=C2=A0 The TOBY L4 reliably sends its 'greeting text' (+AT=
: READY)
>     within this interval.
> =

>     It would be more rigorous to actually wait for the 'READY' indication
>     for the TOBY L4, but that would require knowing the device model befo=
re
>     the device model is actually queried.=C2=A0 This is doable via the USB
>     product ID, but overkill when the above heuristic seems to work
>     reliably.
> =

>     Before this patch, the ublox plugin was trying to achieve something l=
ike
>     the above with the g_at_chat_set_wakeup_command() function, but that =
had
>     some issues:
> =

>     i)=C2=A0 it did not work reliably, in particular failing badly on the=
 TOBY L4
>     with responses getting out of sync with commands
>     ii) it was an inappropriate use of the wakeup_command which is intend=
ed
>     for devices that may sleep when there is no communication during some
>     interval
> =

>     This patch adds an init sequence that probes the device for readiness
>     before continuing with initialization.
>     ---
> =

>     Changed in v2:
>     - drop return statement
>     - drop superfluous empty line
> =

>      =C2=A0plugins/ublox.c | 119 ++++++++++++++++++++++++++++++++++++++++=
++------
>      =C2=A01 file changed, 105 insertions(+), 14 deletions(-)
> =

>     diff --git a/plugins/ublox.c b/plugins/ublox.c
>     index 9ee38a6b..5be9d4cc 100644
>     --- a/plugins/ublox.c
>     +++ b/plugins/ublox.c
>     @@ -29,6 +29,7 @@
>      =C2=A0#include <glib.h>
>      =C2=A0#include <gatchat.h>
>      =C2=A0#include <gattty.h>
>     +#include <ell/ell.h>
> =

>      =C2=A0#define OFONO_API_SUBJECT_TO_CHANGE
>      =C2=A0#include <ofono/plugin.h>
>     @@ -66,6 +67,10 @@ struct ublox_data {
> =

>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct ublox_model *model;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct l_timeout *init_timeout;
> =

> =

> Shouldn't this should be removed in disable in case its still available..
> =

>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0int init_count;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0guint init_cmd;
>      =C2=A0};
> =

>      =C2=A0static void ublox_debug(const char *str, void *user_data)
>     @@ -223,6 +228,80 @@ fail:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_modem_set_powered(modem, FALSE);
>      =C2=A0}
> =

>     +static void init_cmd_cb(gboolean ok, GAtResult *result, void
>     *user_data)
>     +{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_modem *modem =3D user_data;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ublox_data *data =3D ofono_modem_g=
et_data(modem);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("%p", modem);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ok)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* When the 'init command' succeeds, we i=
nsert an additional
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * delay of 1 second before proceeding wi=
th the actual
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * intialization of the device.=C2=A0 We =
reuse the init_timeout
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * instance for this, just clearing the c=
ommand to indicate
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * that additional retries aren't necessa=
ry.
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->init_cmd =3D 0;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->init_count =3D 0;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0l_timeout_modify_ms(data->init_timeout, 1=
000);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>     +
>     +fail:
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0l_timeout_remove(data->init_timeout);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->init_timeout =3D NULL;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_unref(data->aux);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->aux =3D NULL;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_unref(data->modem);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->modem =3D NULL;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_modem_set_powered(modem, FALSE);
>     +}
>     +
>     +static void init_timeout_cb(struct l_timeout *timeout, void *user_da=
ta)
>     +{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_modem *modem =3D user_data;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ublox_data *data =3D ofono_modem_g=
et_data(modem);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("%p", modem);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* As long as init_cmd is set we need to =
either keep retrying
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * or fail everything after excessive ret=
ries
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (data->init_cmd && data->init_count++ =
< 20) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_ret=
ry(data->aux, data->init_cmd);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l_timeout_mod=
ify_ms(timeout, 1000);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0l_timeout_remove(data->init_timeout);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->init_timeout =3D NULL;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (data->init_cmd) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_error("=
failed to init modem after 20 attempts");
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_send(data->aux, "ATE0", none_pr=
efix,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NU=
LL, NULL, NULL);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_send(data->aux, "AT+CMEE=3D1", =
none_prefix,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NU=
LL, NULL, NULL);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (g_at_chat_send(data->aux, "AT+CGMM", =
NULL,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_model_cb, modem, NULL) >=
 0)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>     +
>     +fail:
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_unref(data->aux);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->aux =3D NULL;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_unref(data->modem);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->modem =3D NULL;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_modem_set_powered(modem, FALSE);
>     +}
>     +
>      =C2=A0static int ublox_enable(struct ofono_modem *modem)
>      =C2=A0{
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ublox_data *data =3D ofono_modem_=
get_data(modem);
>     @@ -250,22 +329,34 @@ static int ublox_enable(struct ofono_modem *mod=
em)
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_at_chat_se=
nd(data->modem, "AT&C0", NULL, NULL,
>     NULL, NULL);
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =

>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The modem can take a while to wake up =
if just powered on. */
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_set_wakeup_command(data->aux, "=
AT\r", 1000, 11000);
>     -
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_send(data->aux, "ATE0", none_pr=
efix,
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NU=
LL, NULL, NULL);
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_send(data->aux, "AT+CMEE=3D1", =
none_prefix,
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NU=
LL, NULL, NULL);
>     -
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (g_at_chat_send(data->aux, "AT+CGMM", =
NULL,
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_model_cb, modem, NULL) >=
 0)
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINPR=
OGRESS;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * uBlox devices present their USB interf=
aces well before those
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * interfaces are actually ready to use.=
=C2=A0 The specs say to
>     monitor
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the 'greeting text' to detect whether =
the device is ready
>     to use;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * unfortunately, other than for the TOBY=
 L4, the greeting
>     text is
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * not actually specified.
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * What has been determined experimentall=
y to work is to
>     probe with
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * an 'AT' command until it responds and =
then wait an additional
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * second before continuing with device i=
nitialization. =

>     Even for
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the TOBY L4 where one should wait for =
the '+AT: READY' URC
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * before intialization, this seems to be=
 sufficient; the
>     'READY'
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * indication always arrives within this =
time.
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * (It would be more rigorous to actually=
 wait for the 'READY'
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * indication, but that would require kno=
wing the device model
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * before the device model is actually qu=
eried.=C2=A0 Do-able via
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * USB Product ID, but overkill when the =
above seems to work
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * reliably.)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =

>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0g_at_chat_unref(data->aux);
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0data->aux =3D NULL;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->init_count =3D 0;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->init_cmd =3D g_at_chat_send(data->a=
ux, "AT", none_prefix,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
it_cmd_cb, modem, NULL);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0data->init_timeout =3D l_timeout_create_m=
s(500,
>     init_timeout_cb, modem,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);
> =

> =

> Is 500ms enough? What happens if the modem buffers the at commands for a =

> while
> and sends out two "OK"? Won't the second be in the queue and considered =

> being
> the response to the next command?

That's the beauty with the extra second delay.  During this dead period =

we can pick up all the extra OK's we receive and ignore them.  That way, =

the next command in the init sequence doesn't get fooled by the spurious =

OK and get the commands out of sync with the responses.

Also, the TOBY L4 wants the extra second to finish its intialisation.

Furthermore, there's not an AT command sent every 500 ms.  The command =

gets requeued after 500ms, but it doesn't actually go out until the =

modem responds to the first one... not quite sure why this works, to be =

honest.

/Jonas

> =

> =

>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINPROGRESS;
>      =C2=A0}
> =

>      =C2=A0static void cfun_disable(gboolean ok, GAtResult *result, gpoin=
ter
>     user_data)
>     -- =

>     2.20.1
> =

>     _______________________________________________
>     ofono mailing list
>     ofono(a)ofono.org <mailto:ofono@ofono.org>
>     https://lists.ofono.org/mailman/listinfo/ofono
>=20

--===============0307108718184414579==--

