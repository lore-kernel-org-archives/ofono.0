Content-Type: multipart/mixed; boundary="===============5788085449681871650=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 2/2] sms: Introduce message code independent of protocol
 stack
Date: Thu, 20 Jan 2011 12:02:09 -0600
Message-ID: <4D3878A1.3020206@gmail.com>
In-Reply-To: <1295051446-22150-3-git-send-email-faiyaz.baxamusa@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5788085449681871650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Faiyaz,

> +static void message_destroy(gpointer userdata)
> +{
> +	struct message *m =3D userdata;
> +
> +	m->data =3D NULL;
> +	m->atom =3D NULL;

Lets remove the above two assignments, they're not really needed.

> +	g_free(m);
> +}
> +

<snip>

> diff --git a/src/message.h b/src/message.h
> new file mode 100644
> index 0000000..faa957f
> --- /dev/null
> +++ b/src/message.h
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

Please remove these #ifdefs, non-public headers should not contain these
guards.  The intent is to let the compiler warn us if/when we
inadvertently include a file more than once.  See any other header file
in src/ for an example

> +#include <ofono/types.h>
> +
> +enum message_state {
> +	MESSAGE_STATE_PENDING,
> +	MESSAGE_STATE_SENT,
> +	MESSAGE_STATE_FAILED
> +};
> +
> +struct ofono_atom;
> +struct message;
> +
> +struct message *message_create(const struct ofono_uuid *uuid,
> +						struct ofono_atom *atom);
> +
> +gboolean message_dbus_register(struct message *m);
> +void message_dbus_unregister(struct message *m);
> +
> +const struct ofono_uuid *message_get_uuid(const struct message *m);
> +
> +void message_set_state(struct message *m, enum message_state new_state);
> +
> +void message_append_properties(struct message *m, DBusMessageIter *dict);
> +
> +void message_emit_added(struct message *m, const char *interface);
> +
> +void message_emit_removed(struct message *m, const char *interface);
> +
> +void *message_get_data(struct message *m);
> +
> +void message_set_data(struct message *m, void *data);
> +
> +const char *message_path_from_uuid(struct ofono_atom *atom,
> +						const struct ofono_uuid *uuid);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __OFONO_MESSAGE_H */

Same comment as above about the ifdefs

<snip>

Rest looks just fine to me.

Regards,
-Denis

--===============5788085449681871650==--

