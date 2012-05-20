Content-Type: multipart/mixed; boundary="===============0480052894780159881=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 01/12] Constify GDBus method tables
Date: Sun, 20 May 2012 02:48:31 -0700
Message-ID: <1337507311.15105.0.camel@aeonflux>
In-Reply-To: <1337490456-10941-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0480052894780159881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> Constify method tables with the following command:
> =

> find . -name '*.[ch]' -exec \
>              sed -i 's/\(GDBusMethodTable .* =3D\)/const \1/g' {} \;
> ---
>  plugins/hfp_hf.c            |    2 +-
>  plugins/push-notification.c |    2 +-
>  plugins/smart-messaging.c   |    2 +-
>  src/audio-settings.c        |    2 +-
>  src/call-barring.c          |    2 +-
>  src/call-forwarding.c       |    2 +-
>  src/call-meter.c            |    2 +-
>  src/call-settings.c         |    2 +-
>  src/call-volume.c           |    2 +-
>  src/cbs.c                   |    2 +-
>  src/cdma-connman.c          |    2 +-
>  src/cdma-netreg.c           |    2 +-
>  src/cdma-sms.c              |    2 +-
>  src/cdma-voicecall.c        |    2 +-
>  src/ctm.c                   |    2 +-
>  src/gnss.c                  |    2 +-
>  src/gprs.c                  |    4 ++--
>  src/handsfree.c             |    2 +-
>  src/location-reporting.c    |    2 +-
>  src/manager.c               |    2 +-
>  src/message-waiting.c       |    2 +-
>  src/message.c               |    2 +-
>  src/modem.c                 |    2 +-
>  src/network.c               |    4 ++--
>  src/phonebook.c             |    2 +-
>  src/radio-settings.c        |    2 +-
>  src/sim.c                   |    2 +-
>  src/sms.c                   |    2 +-
>  src/stk.c                   |    2 +-
>  src/ussd.c                  |    2 +-
>  src/voicecall.c             |    4 ++--
>  31 files changed, 34 insertions(+), 34 deletions(-)

all 12 patches have been applied.

Regards

Marcel



--===============0480052894780159881==--

