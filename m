Content-Type: multipart/mixed; boundary="===============0383131455503654090=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] don't redefine GNU_SOURCE
Date: Sat, 07 Nov 2015 08:23:22 +0900
Message-ID: <508E3E53-7866-4BCA-B1B5-92AB37417DFE@holtmann.org>
In-Reply-To: <1446831257-26136-2-git-send-email-petr.vorel@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0383131455503654090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petr,

> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> drivers/atmodem/call-barring.c          | 2 ++
> drivers/atmodem/call-forwarding.c       | 2 ++
> drivers/atmodem/call-meter.c            | 2 ++
> drivers/atmodem/call-settings.c         | 2 ++
> drivers/atmodem/call-volume.c           | 2 ++
> drivers/atmodem/cbs.c                   | 2 ++
> drivers/atmodem/gnss.c                  | 2 ++
> drivers/atmodem/gprs-context.c          | 2 ++
> drivers/atmodem/gprs.c                  | 2 ++
> drivers/atmodem/network-registration.c  | 2 ++
> drivers/atmodem/phonebook.c             | 2 ++
> drivers/atmodem/sim-auth.c              | 2 ++
> drivers/atmodem/sim.c                   | 2 ++
> drivers/atmodem/sms.c                   | 2 ++
> drivers/atmodem/stk.c                   | 2 ++
> drivers/atmodem/ussd.c                  | 2 ++
> drivers/atmodem/voicecall.c             | 2 ++
> drivers/calypsomodem/stk.c              | 2 ++
> drivers/calypsomodem/voicecall.c        | 2 ++
> drivers/cdmamodem/connman.c             | 2 ++
> drivers/cdmamodem/voicecall.c           | 2 ++
> drivers/hfpmodem/call-volume.c          | 2 ++
> drivers/hfpmodem/handsfree.c            | 2 ++
> drivers/hfpmodem/network-registration.c | 2 ++
> drivers/hfpmodem/siri.c                 | 2 ++
> drivers/hfpmodem/slc.c                  | 2 ++
> drivers/hfpmodem/voicecall.c            | 2 ++
> drivers/hsomodem/gprs-context.c         | 2 ++
> drivers/hsomodem/radio-settings.c       | 2 ++
> drivers/huaweimodem/audio-settings.c    | 2 ++
> drivers/huaweimodem/cdma-netreg.c       | 2 ++
> drivers/huaweimodem/gprs-context.c      | 2 ++
> drivers/huaweimodem/radio-settings.c    | 2 ++
> drivers/huaweimodem/voicecall.c         | 2 ++
> drivers/iceramodem/gprs-context.c       | 2 ++
> drivers/iceramodem/radio-settings.c     | 2 ++
> drivers/ifxmodem/audio-settings.c       | 2 ++
> drivers/ifxmodem/ctm.c                  | 2 ++
> drivers/ifxmodem/gprs-context.c         | 2 ++
> drivers/ifxmodem/radio-settings.c       | 2 ++
> drivers/ifxmodem/stk.c                  | 2 ++
> drivers/ifxmodem/voicecall.c            | 2 ++
> drivers/isimodem/audio-settings.c       | 2 ++
> drivers/isimodem/call-barring.c         | 2 ++
> drivers/isimodem/call-forwarding.c      | 2 ++
> drivers/isimodem/call-meter.c           | 2 ++
> drivers/isimodem/call-settings.c        | 2 ++
> drivers/isimodem/cbs.c                  | 2 ++
> drivers/isimodem/debug.c                | 2 ++
> drivers/isimodem/devinfo.c              | 2 ++
> drivers/isimodem/gprs-context.c         | 2 ++
> drivers/isimodem/gprs.c                 | 2 ++
> drivers/isimodem/network-registration.c | 2 ++
> drivers/isimodem/radio-settings.c       | 2 ++
> drivers/isimodem/sim.c                  | 2 ++
> drivers/isimodem/sms.c                  | 2 ++
> drivers/isimodem/uicc-util.c            | 2 ++
> drivers/isimodem/uicc.c                 | 2 ++
> drivers/isimodem/ussd.c                 | 2 ++
> drivers/isimodem/voicecall.c            | 2 ++
> drivers/mbmmodem/gprs-context.c         | 2 ++
> drivers/mbmmodem/location-reporting.c   | 2 ++
> drivers/mbmmodem/stk.c                  | 2 ++
> drivers/nwmodem/radio-settings.c        | 2 ++
> drivers/qmimodem/location-reporting.c   | 2 ++
> drivers/qmimodem/qmi.c                  | 2 ++
> drivers/rilmodem/call-forwarding.c      | 2 ++
> drivers/rilmodem/call-settings.c        | 2 ++
> drivers/rilmodem/call-volume.c          | 2 ++
> drivers/rilmodem/devinfo.c              | 2 ++
> drivers/rilmodem/gprs-context.c         | 2 ++
> drivers/rilmodem/gprs.c                 | 2 ++
> drivers/rilmodem/network-registration.c | 2 ++
> drivers/rilmodem/phonebook.c            | 2 ++
> drivers/rilmodem/radio-settings.c       | 2 ++
> drivers/rilmodem/sim.c                  | 2 ++
> drivers/rilmodem/sms.c                  | 2 ++
> drivers/rilmodem/ussd.c                 | 2 ++
> drivers/rilmodem/voicecall.c            | 2 ++
> drivers/stemodem/gprs-context.c         | 2 ++
> drivers/stemodem/radio-settings.c       | 2 ++
> drivers/stemodem/voicecall.c            | 2 ++
> drivers/swmodem/gprs-context.c          | 2 ++
> drivers/telitmodem/location-reporting.c | 2 ++
> drivers/ztemodem/radio-settings.c       | 2 ++
> gisi/client.c                           | 2 ++
> gisi/modem.c                            | 2 ++
> gril/parcel.c                           | 2 ++
> src/call-volume.c                       | 2 ++
> src/cdma-smsutil.c                      | 2 ++
> src/common.c                            | 2 ++
> src/gnss.c                              | 2 ++
> src/gnssagent.c                         | 2 ++
> src/handsfree.c                         | 2 ++
> src/idmap.c                             | 2 ++
> src/log.c                               | 2 ++
> src/phonebook.c                         | 2 ++
> src/sim-auth.c                          | 2 ++
> src/sim.c                               | 2 ++
> src/simfs.c                             | 2 ++
> src/siri.c                              | 2 ++
> src/smsagent.c                          | 2 ++
> src/smsutil.c                           | 2 ++
> src/stk.c                               | 2 ++
> src/stkagent.c                          | 2 ++
> src/storage.c                           | 2 ++
> src/ussd.c                              | 2 ++
> tools/tty-redirector.c                  | 2 ++
> 108 files changed, 216 insertions(+)
> =

> diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barrin=
g.c
> index 1239d05..243d3fc 100644
> --- a/drivers/atmodem/call-barring.c
> +++ b/drivers/atmodem/call-barring.c
> @@ -23,7 +23,9 @@
> #include <config.h>
> #endif
> =

> +#ifndef _GNU_SOURCE
> #define _GNU_SOURCE
> +#endif

lets not do that. Either we have #define _GNU_SOURCE in the files that need=
 it or we let config.h set it unconditionally. However we are not #ifdef ar=
ound it ever.

Regards

Marcel


--===============0383131455503654090==--

