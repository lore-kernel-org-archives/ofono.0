Content-Type: multipart/mixed; boundary="===============4161054729739921823=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 1/3] Add TTY (hearing impaired) support
Date: Fri, 19 Nov 2010 20:18:07 -0200
Message-ID: <20101119221807.GB19122@vigoh>
In-Reply-To: <1290079616-2754-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4161054729739921823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

* Lucas De Marchi <lucas.demarchi@profusion.mobi> [2010-11-18 09:26:54 -0=
200]:

> ---
>  Makefile.am                |    5 +-
>  doc/text-telephony-api.txt |   38 +++++
>  include/dbus.h             |    1 +
>  include/text-telephony.h   |   71 ++++++++++
>  src/modem.c                |    1 +
>  src/ofono.h                |    2 +
>  src/text-telephony.c       |  333 ++++++++++++++++++++++++++++++++++++++=
++++++
>  7 files changed, 449 insertions(+), 2 deletions(-)
>  create mode 100644 doc/text-telephony-api.txt
>  create mode 100644 include/text-telephony.h
>  create mode 100644 src/text-telephony.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index f841b4c..ee1313d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -13,7 +13,8 @@ include_HEADERS =3D include/log.h include/plugin.h incl=
ude/history.h \
>  			include/cbs.h include/call-volume.h \
>  			include/gprs.h include/gprs-context.h \
>  			include/radio-settings.h include/stk.h \
> -			include/audio-settings.h include/nettime.h
> +			include/audio-settings.h include/nettime.h \
> +			include/text-telephony.h
>  =

>  nodist_include_HEADERS =3D include/version.h
>  =

> @@ -318,7 +319,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sou=
rces) src/ofono.ver \
>  			src/radio-settings.c src/stkutil.h src/stkutil.c \
>  			src/nettime.c src/stkagent.c src/stkagent.h \
>  			src/simfs.c src/simfs.h src/audio-settings.c \
> -			src/smsagent.c src/smsagent.h
> +			src/smsagent.c src/smsagent.h src/text-telephony.c
>  =

>  src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LI=
BS@ -ldl
>  =

> diff --git a/doc/text-telephony-api.txt b/doc/text-telephony-api.txt
> new file mode 100644
> index 0000000..8623d5f
> --- /dev/null
> +++ b/doc/text-telephony-api.txt
> @@ -0,0 +1,38 @@
> +Text Telephony hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.TextTelephony
> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods		dict GetProperties()
> +
> +			Returns all Text Telephony properties. See the
> +			properties section for available properties.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +
> +		void SetProperty(string name, variant value)
> +
> +			Changes the value of the specified property. Only
> +			properties that are listed as read-write are
> +			changeable. On success a PropertyChanged signal
> +			will be emitted.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.DoesNotExist
> +					 [service].Error.InProgress
> +
> +Signals		PropertyChanged(string property, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> +Properties	boolean	Powered [readwrite]

From what I remember in the discussion in the IRC, this should be
Enabled and not Powered.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============4161054729739921823==--

