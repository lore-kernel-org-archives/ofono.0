Content-Type: multipart/mixed; boundary="===============4220267027273417431=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] build: add support for test-rilmodem-sms
Date: Tue, 17 Nov 2015 21:31:09 -0600
Message-ID: <564BF0FD.9000007@gmail.com>
In-Reply-To: <1447811116-11970-3-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4220267027273417431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 11/17/2015 07:45 PM, Tony Espy wrote:
> ---
>   Makefile.am | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index fba25ba..1cdfc1f 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -740,7 +740,8 @@ unit_objects =3D
>   unit_tests =3D unit/test-common unit/test-util unit/test-idmap \
>   				unit/test-simutil unit/test-stkutil \
>   				unit/test-sms unit/test-cdmasms \
> -				unit/test-rilmodem-cs
> +				unit/test-rilmodem-cs \
> +				unit/test-rilmodem-sms
>
>   noinst_PROGRAMS =3D $(unit_tests) \
>   			unit/test-sms-root unit/test-mux unit/test-caif
> @@ -801,6 +802,17 @@ unit_test_rilmodem_cs_LDADD =3D gdbus/libgdbus-inter=
nal.la $(builtin_libadd) \
>   			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
>   unit_objects +=3D $(unit_test_rilmodem_cs_OBJECTS)
>
> +unit_test_rilmodem_sms_SOURCES =3D unit/test-rilmodem-sms.c $(gril_sourc=
es) \
> +			src/log.c src/common.c src/util.c \
> +			gatchat/ringbuffer.h gatchat/ringbuffer.c \
> +			drivers/rilmodem/sms.c \
> +			unit/rilmodem-test-server.h \
> +			unit/rilmodem-test-server.c \
> +			src/simutil.c

Can the files common to the ril unit tests be assigned to a variable?  I =

count at least 8 files that are shared between rilmodem_sms & =

rilmodem_cs.  Lets keep duplication to a minimum.

> +unit_test_rilmodem_sms_LDADD =3D gdbus/libgdbus-internal.la $(builtin_li=
badd) \
> +			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
> +unit_objects +=3D $(unit_test_rilmodem_sms_OBJECTS)
> +
>   TESTS =3D $(unit_tests)
>
>   if TOOLS
>

Regards,
-Denis

--===============4220267027273417431==--

