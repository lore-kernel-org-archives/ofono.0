Content-Type: multipart/mixed; boundary="===============2312857340213709596=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 1/2] huaweimodem: Add support for radio settings
Date: Wed, 08 Dec 2010 15:12:04 -0200
Message-ID: <AANLkTinPQdjHdpJHnYd6R52jgBD22Fo4T9HM7yHm82Ey@mail.gmail.com>
In-Reply-To: <4CFFAF9E.8040602@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2312857340213709596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 8, 2010 at 2:17 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Lucas,
>
> On 11/30/2010 12:41 PM, Lucas De Marchi wrote:
>> ---
>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A03 +-
>> =C2=A0drivers/huaweimodem/huaweimodem.c =C2=A0 =C2=A0| =C2=A0 =C2=A02 +
>> =C2=A0drivers/huaweimodem/huaweimodem.h =C2=A0 =C2=A0| =C2=A0 =C2=A03 +
>> =C2=A0drivers/huaweimodem/radio-settings.c | =C2=A0212 +++++++++++++++++=
+++++++++++++++++
>> =C2=A04 files changed, 219 insertions(+), 1 deletions(-)
>> =C2=A0create mode 100644 drivers/huaweimodem/radio-settings.c
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index a4c47e8..5d39c23 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -180,7 +180,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 drivers/huaweimodem/huaweimodem.c \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 drivers/huaweimodem/voicecall.c \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 drivers/huaweimodem/audio-settings.c \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
drivers/huaweimodem/gprs-context.c
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
drivers/huaweimodem/gprs-context.c \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
drivers/huaweimodem/radio-settings.c
>>
>> =C2=A0builtin_modules +=3D calypsomodem
>> =C2=A0builtin_sources +=3D drivers/atmodem/atutil.h \
>> diff --git a/drivers/huaweimodem/huaweimodem.c b/drivers/huaweimodem/hua=
weimodem.c
>> index c8b6522..8097a9c 100644
>> --- a/drivers/huaweimodem/huaweimodem.c
>> +++ b/drivers/huaweimodem/huaweimodem.c
>> @@ -36,6 +36,7 @@ static int huaweimodem_init(void)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 huawei_voicecall_init();
>> =C2=A0 =C2=A0 =C2=A0 huawei_audio_settings_init();
>> + =C2=A0 =C2=A0 huawei_radio_settings_init();
>> =C2=A0 =C2=A0 =C2=A0 huawei_gprs_context_init();
>>
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> @@ -44,6 +45,7 @@ static int huaweimodem_init(void)
>> =C2=A0static void huaweimodem_exit(void)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 huawei_gprs_context_exit();
>> + =C2=A0 =C2=A0 huawei_radio_settings_exit();
>> =C2=A0 =C2=A0 =C2=A0 huawei_audio_settings_exit();
>> =C2=A0 =C2=A0 =C2=A0 huawei_voicecall_exit();
>> =C2=A0}
>> diff --git a/drivers/huaweimodem/huaweimodem.h b/drivers/huaweimodem/hua=
weimodem.h
>> index 03d52ef..596aa08 100644
>> --- a/drivers/huaweimodem/huaweimodem.h
>> +++ b/drivers/huaweimodem/huaweimodem.h
>> @@ -27,5 +27,8 @@ extern void huawei_voicecall_exit();
>> =C2=A0extern void huawei_audio_settings_init();
>> =C2=A0extern void huawei_audio_settings_exit();
>>
>> +extern void huawei_radio_settings_init();
>> +extern void huawei_radio_settings_exit();
>> +
>> =C2=A0extern void huawei_gprs_context_init();
>> =C2=A0extern void huawei_gprs_context_exit();
>> diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/=
radio-settings.c
>> new file mode 100644
>> index 0000000..7f0b223
>> --- /dev/null
>> +++ b/drivers/huaweimodem/radio-settings.c
>> @@ -0,0 +1,212 @@
>> +/*
>> + *
>> + * =C2=A0oFono - Open Source Telephony
>> + *
>> + * =C2=A0Copyright (C) 2010 =C2=A0Intel Corporation. All rights reserve=
d.
>> + *
>> + * =C2=A0This program is free software; you can redistribute it and/or =
modify
>> + * =C2=A0it under the terms of the GNU General Public License version 2=
 as
>> + * =C2=A0published by the Free Software Foundation.
>> + *
>> + * =C2=A0This program is distributed in the hope that it will be useful,
>> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See=
 the
>> + * =C2=A0GNU General Public License for more details.
>> + *
>> + * =C2=A0You should have received a copy of the GNU General Public Lice=
nse
>> + * =C2=A0along with this program; if not, write to the Free Software
>> + * =C2=A0Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =C2=
=A002110-1301 =C2=A0USA
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#define _GNU_SOURCE
>> +#include <string.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <errno.h>
>> +
>> +#include <glib.h>
>> +
>> +#include <ofono/log.h>
>> +#include <ofono/modem.h>
>> +#include <ofono/radio-settings.h>
>> +
>> +#include "gatchat.h"
>> +#include "gatresult.h"
>> +
>> +#include "huaweimodem.h"
>> +
>> +static const char *none_prefix[] =3D { NULL };
>> +static const char *xrat_prefix[] =3D { "^SYSCFG:", NULL };
>> +
>> +struct radio_settings_data {
>> + =C2=A0 =C2=A0 GAtChat *chat;
>> +};
>> +
>> +static void xrat_query_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
>
> Why is this named xrat query?

Looking at ifxmodem, I thought the prefix had something to do with
radio technology (please don't ask me why the "x" in front of "rat"
:-) )

As I told through IRC, I'm changing it to syscfg, as this is actually
the command name


>> +{
>> + =C2=A0 =C2=A0 struct cb_data *cbd =3D user_data;
>> + =C2=A0 =C2=A0 ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
>> + =C2=A0 =C2=A0 enum ofono_radio_access_mode mode;
>> + =C2=A0 =C2=A0 struct ofono_error error;
>> + =C2=A0 =C2=A0 GAtResultIter iter;
>> + =C2=A0 =C2=A0 int value;
>> +
>> + =C2=A0 =C2=A0 decode_at_error(&error, g_at_result_final_response(resul=
t));
>> +
>> + =C2=A0 =C2=A0 if (!ok) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(&error, -1, cbd->data);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 g_at_result_iter_init(&iter, result);
>> +
>> + =C2=A0 =C2=A0 if (g_at_result_iter_next(&iter, "^SYSCFG:") =3D=3D FALS=
E)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>> +
>> + =C2=A0 =C2=A0 if (g_at_result_iter_next_number(&iter, &value) =3D=3D F=
ALSE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>> +
>> + =C2=A0 =C2=A0 switch (value) {
>> + =C2=A0 =C2=A0 case 2:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D OFONO_RADIO_ACCESS_=
MODE_ANY;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case 13:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D OFONO_RADIO_ACCESS_=
MODE_GSM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case 14:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D OFONO_RADIO_ACCESS_=
MODE_UMTS;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 default:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, -1=
, cbd->data);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 cb(&error, mode, cbd->data);
>> +
>> + =C2=A0 =C2=A0 return;
>> +
>> +error:
>> + =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
>> +}
>> +
>> +static void huawei_query_rat_mode(struct ofono_radio_settings *rs,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_radio_settings_rat_mode_query_cb_t cb,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)
>> +{
>> + =C2=A0 =C2=A0 struct radio_settings_data *rsd =3D ofono_radio_settings=
_get_data(rs);
>> + =C2=A0 =C2=A0 struct cb_data *cbd =3D cb_data_new(cb, data);
>> +
>> + =C2=A0 =C2=A0 if (g_at_chat_send(rsd->chat, "AT^SYSCFG?", xrat_prefix,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xrat_query_cb, cbd,=
 g_free) =3D=3D 0) {
>
> And xrat_query here too?
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, -1=
, data);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
>> + =C2=A0 =C2=A0 }
>> +}
>> +
>> +static void xrat_modify_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
>
> xrat_modify?
>
>> +{
>> + =C2=A0 =C2=A0 struct cb_data *cbd =3D user_data;
>> + =C2=A0 =C2=A0 ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
>> + =C2=A0 =C2=A0 struct ofono_error error;
>> +
>> + =C2=A0 =C2=A0 decode_at_error(&error, g_at_result_final_response(resul=
t));
>> + =C2=A0 =C2=A0 cb(&error, cbd->data);
>> +}
>> +
>> +static void huawei_set_rat_mode(struct ofono_radio_settings *rs,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum ofono_radio_access_mode mode,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_radio_settings_rat_mode_set_cb_t cb,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)
>> +{
>> + =C2=A0 =C2=A0 struct radio_settings_data *rsd =3D ofono_radio_settings=
_get_data(rs);
>> + =C2=A0 =C2=A0 struct cb_data *cbd =3D cb_data_new(cb, data);
>> + =C2=A0 =C2=A0 char buf[40];
>> + =C2=A0 =C2=A0 int value =3D 2;
>> +
>> + =C2=A0 =C2=A0 switch (mode) {
>> + =C2=A0 =C2=A0 case OFONO_RADIO_ACCESS_MODE_ANY:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D 2;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case OFONO_RADIO_ACCESS_MODE_GSM:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D 13;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case OFONO_RADIO_ACCESS_MODE_UMTS:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D 14;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case OFONO_RADIO_ACCESS_MODE_LTE:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), "AT^SYSCFG=3D%u,0,3FFFFFFF,2,=
4", value);
>
> These values don't seem to be correct. =C2=A0At least not after taking a =
peek
> at some of our competitors ;)

I don't think so after poking other projects and testing with a huawei
E220. The second parameter for SYSCFG command means the acquire order
(https://wiki.archlinux.org/index.php/3G_and_GPRS_modems_with_pppd_alone),
so it's pointless here even if some other competitors explicitly set
to "gsm first" or "umts first" when setting the mode.


Thanks for reviewing.


regards,

Lucas De Marchi

--===============2312857340213709596==--

