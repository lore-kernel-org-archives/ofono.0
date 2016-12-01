Content-Type: multipart/mixed; boundary="===============7626635460618806575=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: Re: [PATCH v3 4/7] ubloxmodem: add the netmon driver
Date: Thu, 01 Dec 2016 14:51:22 +0100
Message-ID: <CAH562ETeQh-wQ5EoDN6UVz0ZFOw6ci=ijizudSq+UgQgVieohA@mail.gmail.com>
In-Reply-To: <583EF654.4070102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7626635460618806575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 30 November 2016 at 16:55, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Djalal,
>
>
> On 11/30/2016 06:31 AM, Djalal Harouni wrote:
>>
>> This adds a netmon driver for ublox. The driver support both +COPS and
>> +CESQ commands to return the previously added ofono netmon types:
>>
>> RSCP: Received Signal Code Power
>> ECN0: Received Energy Ratio
>> RSRQ: Reference Signal Received Quality
>> RSRP: Reference Signal Received Power
>> ---
>>   drivers/ubloxmodem/netmon.c     | 336
>> ++++++++++++++++++++++++++++++++++++++++
>>   drivers/ubloxmodem/ubloxmodem.c |   2 +
>>   drivers/ubloxmodem/ubloxmodem.h |   3 +
>>   3 files changed, 341 insertions(+)
>>   create mode 100644 drivers/ubloxmodem/netmon.c
>>
>> diff --git a/drivers/ubloxmodem/netmon.c b/drivers/ubloxmodem/netmon.c
>> new file mode 100644
>> index 0000000..e5adf59
>> --- /dev/null
>> +++ b/drivers/ubloxmodem/netmon.c
>> @@ -0,0 +1,336 @@
>> +/*
>> + *
>> + *  oFono - Open Source Telephony
>> + *
>> + *  Copyright (C) 2016  EndoCode AG. All rights reserved.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 as
>> + *  published by the Free Software Foundation.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-13=
01
>> USA
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#define _GNU_SOURCE
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <stdint.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +
>> +#include <glib.h>
>> +
>> +#include <ofono/log.h>
>> +#include <ofono/modem.h>
>> +#include <ofono/netmon.h>
>> +
>> +#include "gatchat.h"
>> +#include "gatresult.h"
>> +
>> +#include "common.h"
>> +#include "netreg.h"
>
>
> This should probably be <ofono/netreg.h> and moved up above.
>

Fixed.

>> +#include "ubloxmodem.h"
[...]

> This if can in theory be removed, see my comments in req_cb_data_new0.
>
>> +
>> +       if (g_at_chat_send(nmd->chat, "AT+COPS?", cops_prefix,
>> +                          cops_cb, cbd, NULL) =3D=3D 0) {
>
>
> So this is still not right with the missing GDestroyNotify parameter.
> GAtChat is pretty flexible & neat, so it makes things like this easy to
> solve.  Here are a couple of ways you can handle this:
>
> 1. Send all commands right away.  Provide cbd as userdata for all of them,
> and provide GDestroyNotify callback (e.g. g_free) only to the last command
> sent. GAtChat will queue them up internally, and if this atom gets destro=
yed
> prematurely (e.g. due to sim removal conditions, hardware removal, etc) t=
he
> GDestroyNotify callback will be called in all cases.
>
> So roughly:
> g_at_chat_send(..., "AT+COPS?", ..., cbd, NULL);
> g_at_chat_send(..., "AT+CESQ?", ..., cbd, g_free);
>
> 2. Use reference counting on the cbd object.  req_cb_data_new0 would
> initialize reference count to 1.  req_cb_data_ref / unref would increase /
> decrease it.  req_cb_data_unref would use g_free if reference count reach=
es
> 0.
>
> This way you can do something like:
>
> g_at_chat_send(..., "AT+COPS?", ..., cbd, req_cb_data_unref);
>
> Then inside the cops callback, if the command succeeds and you want to
> proceed with CESQ, you'd invoke req_cb_data_ref(), otherwise simply callb=
ack
> with failure & return.  In both cases req_cb_data_unref will be called af=
ter
> the cops callback is executed.
>

OK thank you for the explanation. I did go with ref counting since
they are easy to use and I will follow up later with +UCGED which has
different behaviour depending on firmware version...

I take a ref just before doing the g_at_chat_send() , however I call
unref in case g_at_chat_send() returns 0 and fails since in that case
the GDestroyNotify is still not registered and the command was not
queued...

Hmm so now maybe the leak may happen in this small window between:
cbd =3D req_cb_data_ref(cbd);
and
g_at_chat_send() and before registering the GDestroyNotify
parameter... in case hardware removal happens or anything... I'm not
sure and I also don't know how to fix it.

Otherwise all comments for this patch were fixed.

Thank you for the review ;-)



>
>> +               CALLBACK_WITH_FAILURE(cb, data);
>> +               g_free(cbd);
>> +       }
>> +}
>> +
>> +static int ublox_netmon_probe(struct ofono_netmon *netmon,
>> +                             unsigned int vendor, void *user)
>> +{
>> +       GAtChat *chat =3D user;
>> +       struct netmon_driver_data *nmd;
>> +
>> +       DBG("ublox netmon probe");
>> +
>> +       nmd =3D g_try_new0(struct netmon_driver_data, 1);
>> +       if (nmd =3D=3D NULL)
>> +               return -ENOMEM;
>> +
>> +       nmd->chat =3D g_at_chat_clone(chat);
>> +
>> +       ofono_netmon_set_data(netmon, nmd);
>> +
>> +       g_idle_add(ublox_delayed_register, netmon);
>> +
>> +       return 0;
>> +}
>> +
>> +static void ublox_netmon_remove(struct ofono_netmon *netmon)
>> +{
>> +       struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
>> +
>> +       DBG("ublox netmon remove");
>> +
>> +       g_at_chat_unref(nmd->chat);
>> +
>> +       ofono_netmon_set_data(netmon, NULL);
>> +
>> +       g_free(nmd);
>> +}
>> +
>> +static struct ofono_netmon_driver driver =3D {
>> +       .name                   =3D UBLOXMODEM,
>> +       .probe                  =3D ublox_netmon_probe,
>> +       .remove                 =3D ublox_netmon_remove,
>> +       .request_update         =3D ublox_netmon_request_update,
>> +};
>> +
>> +void ublox_netmon_init(void)
>> +{
>> +       ofono_netmon_driver_register(&driver);
>> +}
>> +
>> +void ublox_netmon_exit(void)
>> +{
>> +       ofono_netmon_driver_unregister(&driver);
>> +}
>> diff --git a/drivers/ubloxmodem/ubloxmodem.c
>> b/drivers/ubloxmodem/ubloxmodem.c
>> index 93cb928..a325b1f 100644
>> --- a/drivers/ubloxmodem/ubloxmodem.c
>> +++ b/drivers/ubloxmodem/ubloxmodem.c
>> @@ -36,6 +36,7 @@
>>   static int ubloxmodem_init(void)
>>   {
>>         ublox_gprs_context_init();
>> +       ublox_netmon_init();
>>         ublox_lte_init();
>>
>>         return 0;
>> @@ -44,6 +45,7 @@ static int ubloxmodem_init(void)
>>   static void ubloxmodem_exit(void)
>>   {
>>         ublox_gprs_context_exit();
>> +       ublox_netmon_exit();
>>         ublox_lte_exit();
>>   }
>>
>> diff --git a/drivers/ubloxmodem/ubloxmodem.h
>> b/drivers/ubloxmodem/ubloxmodem.h
>> index cf66412..bfb0106 100644
>> --- a/drivers/ubloxmodem/ubloxmodem.h
>> +++ b/drivers/ubloxmodem/ubloxmodem.h
>> @@ -26,5 +26,8 @@
>>   extern void ublox_gprs_context_init(void);
>>   extern void ublox_gprs_context_exit(void);
>>
>> +extern void ublox_netmon_init(void);
>> +extern void ublox_netmon_exit(void);
>> +
>>   extern void ublox_lte_init(void);
>>   extern void ublox_lte_exit(void);
>>
>
> Regards,
> -Denis
>

--===============7626635460618806575==--

