Content-Type: multipart/mixed; boundary="===============8728943281112398789=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/6] gatchat: Add g_at_chat_send_full.
Date: Mon, 10 May 2010 14:13:09 -0500
Message-ID: <201005101413.09271.denkenz@gmail.com>
In-Reply-To: <1273192031-11189-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8728943281112398789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> g_at_chat_send_full takes two additional parameters compared to
> g_at_chat_send.  The destroy notification is removed from
> g_at_chat_send and users updated.
> ---

You stated earlier that the modem will return an error and not time out.  I=
f =

this is the case then I'm really failing to see the point of needing the =

submit callback.  Perhaps we should simply drop this for now and assume tha=
t =

all modems will return an error and not time out.

>  drivers/atmodem/call-barring.c          |    6 +-
>  drivers/atmodem/call-forwarding.c       |    4 +-
>  drivers/atmodem/call-meter.c            |   19 ++++----
>  drivers/atmodem/call-settings.c         |   12 +++---
>  drivers/atmodem/call-volume.c           |   13 ++----
>  drivers/atmodem/cbs.c                   |    8 ++--
>  drivers/atmodem/devinfo.c               |    8 ++--
>  drivers/atmodem/gprs-context.c          |    6 +-
>  drivers/atmodem/gprs.c                  |   16 ++++----
>  drivers/atmodem/network-registration.c  |   70
>  +++++++++++++----------------- drivers/atmodem/phonebook.c             |=
  =

>  16 ++++----
>  drivers/atmodem/sim-poll.c              |    5 +-
>  drivers/atmodem/sim.c                   |   26 ++++++------
>  drivers/atmodem/sms.c                   |   52 ++++++++++-------------
>  drivers/atmodem/ssn.c                   |    2 +-
>  drivers/atmodem/stk.c                   |    9 ++--
>  drivers/atmodem/ussd.c                  |    6 +-
>  drivers/atmodem/voicecall.c             |   35 +++++++---------
>  drivers/calypsomodem/voicecall.c        |    7 +--
>  drivers/hfpmodem/call-volume.c          |    4 +-
>  drivers/hfpmodem/network-registration.c |   13 +++---
>  drivers/hfpmodem/voicecall.c            |   27 ++++++------
>  drivers/hsomodem/gprs-context.c         |   11 ++---
>  drivers/mbmmodem/gprs-context.c         |   20 ++++----
>  drivers/stemodem/gprs-context.c         |   10 ++--
>  drivers/stemodem/voicecall.c            |   10 ++--
>  gatchat/gatchat.c                       |   45 ++++++++++++++------
>  gatchat/gatchat.h                       |   23 +++++++++-
>  gatchat/gatmux.c                        |    4 +-
>  gatchat/gsmdial.c                       |   31 ++++++--------
>  plugins/calypso.c                       |   17 +++----
>  plugins/em770.c                         |    8 +--
>  plugins/g1.c                            |    6 +-
>  plugins/hfp.c                           |   14 +++----
>  plugins/hso.c                           |    8 ++--
>  plugins/huawei.c                        |    8 +--
>  plugins/mbm.c                           |   12 +++---
>  plugins/novatel.c                       |    6 +--
>  plugins/palmpre.c                       |    8 +--
>  plugins/phonesim.c                      |   10 ++---
>  plugins/ste.c                           |    7 +--
>  unit/test-caif.c                        |    2 +-
>  unit/test-mux.c                         |   18 ++++----
>  43 files changed, 313 insertions(+), 329 deletions(-)

Please separate these patches into:
- core GAtChat changes
- GAtChat utilities changes
- plugins changes
- drivers changes
- unit test changes

Regards,
-Denis

--===============8728943281112398789==--

