Content-Type: multipart/mixed; boundary="===============7487015660366778127=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/7] voicecall: Fix issue with invalid dbus path
Date: Fri, 08 Dec 2017 08:27:22 -0600
Message-ID: <427fb4c8-29c3-3351-e868-36eed311f5e3@gmail.com>
In-Reply-To: <20171206153604.15080-5-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7487015660366778127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 12/06/2017 09:36 AM, Philippe De Swert wrote:
> Fix an error message from dbus about the path supplied not being valid.
> Related to commit f58e7685b0078df470300b99cd89fb9b3c45d1c0
> =

> ofonod[19107]: src/voicecall.c:voicecall_dial_shortcut() check position
> ofonod[19107]: src/voicecall.c:synthesize_outgoing_call() Registering new=
 call: 1
> process 19107: arguments to dbus_message_iter_append_basic() were incorre=
ct, assertion "_dbus_check_is_valid_path (*string_p)" failed in file ../../=
../dbus/dbus-message.c line 2759.
> This is normally a bug in some application using the D-Bus library.
> =

> ---
>   src/voicecall.c | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index 67384cf2..ed6ea83f 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -28,6 +28,7 @@
>   #include <time.h>
>   #include <errno.h>
>   #include <stdint.h>
> +#include <stdlib.h>

This seems unrelated.  I dropped this chunk

>   =

>   #include <glib.h>
>   #include <gdbus.h>
> @@ -1592,6 +1593,7 @@ static void manager_dial_shortcut_callback(const st=
ruct ofono_error *error,
>   	if (!v)
>   		goto error;
>   =

> +	path =3D voicecall_build_path(vc, v->call);
>   	reply =3D dbus_message_new_method_return(vc->pending);
>   	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
>   						DBUS_TYPE_INVALID);
> =


and applied this one.

Regards,
-Denis

--===============7487015660366778127==--

