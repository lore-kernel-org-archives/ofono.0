Content-Type: multipart/mixed; boundary="===============1961312318270503428=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] include: Introduce message
Date: Thu, 13 Jan 2011 12:08:48 -0600
Message-ID: <4D2F3FB0.1000505@gmail.com>
In-Reply-To: <1294343455-29551-3-git-send-email-faiyaz.baxamusa@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1961312318270503428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Faiyaz,

On 01/06/2011 01:50 PM, Faiyaz Baxamusa wrote:
> ---
>  Makefile.am       |    2 +-
>  include/message.h |   67 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 68 insertions(+), 1 deletions(-)
>  create mode 100644 include/message.h

This is not an atom, it is an implementation detail inside the core.  So
please don't put this into include/ (this is where the public API, for
e.g. plugins and drivers goes)

Moving this inside src/message.h is the way to go.

> =

> diff --git a/Makefile.am b/Makefile.am
> index 14f53ef..8b19eef 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -15,7 +15,7 @@ include_HEADERS =3D include/log.h include/plugin.h incl=
ude/history.h \
>  			include/radio-settings.h include/stk.h \
>  			include/audio-settings.h include/nettime.h \
>  			include/ctm.h include/cdma-voicecall.h \
> -			include/cdma-sms.h
> +			include/cdma-sms.h include/message.h
>  =

>  nodist_include_HEADERS =3D include/version.h
>  =

> diff --git a/include/message.h b/include/message.h
> new file mode 100644
> index 0000000..7c60390
> --- /dev/null
> +++ b/include/message.h
> @@ -0,0 +1,67 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifndef __OFONO_MESSAGE_H
> +#define __OFONO_MESSAGE_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <ofono/types.h>
> +
> +enum message_state {
> +	MESSAGE_STATE_PENDING,
> +	MESSAGE_STATE_SENT,
> +	MESSAGE_STATE_FAILED
> +};
> +
> +struct message;
> +
> +struct message *ofono_message_create(const struct ofono_uuid *uuid,
> +								void *data);

Please use message_set_data to be symmetrical with the rest of the codebase.

> +
> +gboolean ofono_message_dbus_register(const char *atompath, struct messag=
e *m);
> +void ofono_message_dbus_unregister(const char *atompath, struct message =
*m);
> +
> +const struct ofono_uuid *ofono_message_get_uuid(const struct message *m);
> +
> +void ofono_message_set_state(const char *atompath, struct message *m,
> +						enum message_state new_state);
> +
> +void ofono_message_append_properties(struct message *m, DBusMessageIter =
*dict);
> +
> +void ofono_emit_message_added(const char *atompath, const char *interfac=
e,
> +							struct message *m);
> +
> +void ofono_emit_message_removed(const char *atompath, const char *interf=
ace,
> +							struct message *m);
> +
> +void *ofono_message_get_data(struct message *m);
> +
> +const char *ofono_message_path_from_uuid(const char *atompath,
> +						const struct ofono_uuid *uuid);
> +

Since this is not public API please don't use the ofono_ prefix for
this.  Using e.g. message_emit_removed, message_append_properties, etc
is good enough.

Regards,
-Denis

--===============1961312318270503428==--

