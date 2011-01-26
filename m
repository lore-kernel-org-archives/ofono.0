Content-Type: multipart/mixed; boundary="===============1327563726908270719=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH v3 2/7] gps: add gps atom and gpsagent implementations
Date: Wed, 26 Jan 2011 19:51:57 -0200
Message-ID: <20110126215157.GB2192@joana>
In-Reply-To: <1296055974-9640-3-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1327563726908270719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

* Rafael Ignacio Zurita <rafael.zurita@profusion.mobi> [2011-01-26 12:32:=
49 -0300]:

> ---
>  Makefile.am    |    3 +-
>  src/gps.c      |  326 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/gpsagent.c |  145 +++++++++++++++++++++++++
>  src/gpsagent.h |   37 +++++++
>  src/ofono.conf |    1 +
>  src/ofono.h    |    2 +
>  6 files changed, 513 insertions(+), 1 deletions(-)
>  create mode 100644 src/gps.c
>  create mode 100644 src/gpsagent.c
>  create mode 100644 src/gpsagent.h
> =

> diff --git a/Makefile.am b/Makefile.am
> index 7374f70..de70976 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -355,7 +355,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sou=
rces) src/ofono.ver \
>  			src/simfs.c src/simfs.h src/audio-settings.c \
>  			src/smsagent.c src/smsagent.h src/ctm.c \
>  			src/cdma-voicecall.c src/sim-auth.c \
> -			src/message.h src/message.c
> +			src/message.h src/message.c src/gps.c \
> +			src/gpsagent.c src/gpsagent.h

gpsagent.c should not be in src/, it should be in test/. But I saw you alre=
ady
have python implementation for the Agent. So just discard the c one and keep
only the python one. oFono does not really care about the Agent
implementation.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============1327563726908270719==--

