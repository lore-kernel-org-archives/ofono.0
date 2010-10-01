Content-Type: multipart/mixed; boundary="===============5970900423054968660=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/2] isimodem: Add support for audio settings
Date: Fri, 01 Oct 2010 17:12:16 +0300
Message-ID: <AANLkTi=4kZB-ENJm45=__yd3Fk8OGqWF21d+8YU1oRoe@mail.gmail.com>
In-Reply-To: <1285938256-6423-2-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5970900423054968660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

2010/10/1 Kai Vehmanen <kai.vehmanen@nokia.com>:
> diff --git a/drivers/isimodem/audio-settings.c b/drivers/isimodem/audio-s=
ettings.c
> new file mode 100644
> index 0000000..0ec768d
> --- /dev/null
> +++ b/drivers/isimodem/audio-settings.c
> @@ -0,0 +1,148 @@
> +/*
> + *
> + * =C2=A0oFono - Open Source Telephony
> + *
> + * =C2=A0Copyright (C) 2010 =C2=A0Nokia Corporation. All rights reserved.

We have used a bit more elaborate statement, with subsidiaries and all.

> + * =C2=A0This program is free software; you can redistribute it and/or m=
odify
> + * =C2=A0it under the terms of the GNU General Public License version 2 =
as
> + * =C2=A0published by the Free Software Foundation.
> + *
> + * =C2=A0This program is distributed in the hope that it will be useful,
> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See =
the
> + * =C2=A0GNU General Public License for more details.
> + *
> + * =C2=A0You should have received a copy of the GNU General Public Licen=
se
> + * =C2=A0along with this program; if not, write to the Free Software
> + * =C2=A0Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =C2=
=A002110-1301 =C2=A0USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/audio-settings.h>
> +
> +#include <gisi/client.h>
> +
> +#include "debug.h"

This seems to be missing includes for isimodem.h and call.h.

> +struct audio_settings_data {
> + =C2=A0 =C2=A0 =C2=A0 GIsiClient *client;
> +};
> +
> +static void isi_call_server_status_ind_cb(GIsiClient *client,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 void const *restrict data,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size_t len,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint16_t object,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 void *_oas)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_audio_settings *oas =3D _oas;
> + =C2=A0 =C2=A0 =C2=A0 struct {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t message_id, se=
rver_status, sub_blocks;
> + =C2=A0 =C2=A0 =C2=A0 } const *m =3D data;
> + =C2=A0 =C2=A0 =C2=A0 gboolean call_server_status;
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("Call server status changed");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (len < 3)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 call_server_status =3D m->server_status & 0xf ? TR=
UE : FALSE;
> + =C2=A0 =C2=A0 =C2=A0 ofono_audio_settings_active_notify(oas, call_serve=
r_status);
> +}
> +
> +static gboolean isi_call_register(gpointer _oas)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_audio_settings *oas =3D _oas;
> + =C2=A0 =C2=A0 =C2=A0 struct audio_settings_data *asd =3D ofono_audio_se=
ttings_get_data(oas);
> + =C2=A0 =C2=A0 =C2=A0 const char *debug =3D getenv("OFONO_ISI_DEBUG");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (debug && (strcmp(debug, "all") =3D=3D 0) =3D=
=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_client_set_debug=
(asd->client, call_debug, NULL);
> +
> + =C2=A0 =C2=A0 =C2=A0 g_isi_subscribe(asd->client,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 CALL_SERVER_STATUS_IND, isi_call_server_status_ind_cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 oas);
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_audio_settings_register(oas);
> +
> + =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +}
> +
> +static void isi_call_verify_cb(GIsiClient *client,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gboolean alive, uint16_t object, void *o=
vc)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!alive) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Unable to bootstr=
ap audio settings driver");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("%s (v%03d.%03d) reachable",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pn_resource_name(g_isi=
_client_resource(client)),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_version_major(cl=
ient),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_version_minor(cl=
ient));
> +
> + =C2=A0 =C2=A0 =C2=A0 g_idle_add(isi_call_register, ovc);
> +}
> +
> +static int isi_audio_settings_probe(struct ofono_audio_settings *as,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int=
 vendor, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 GIsiModem *idx =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct audio_settings_data *asd =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_try_new0(struct audi=
o_settings_data, 1);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!asd)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 asd->client =3D g_isi_client_create(idx, PN_CALL);
> + =C2=A0 =C2=A0 =C2=A0 if (!asd->client) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(asd);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_audio_settings_set_data(as, asd);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_verify(asd->client, isi_call_verify_cb,=
 as))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Unable to verify =
reachability");
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void isi_audio_settings_remove(struct ofono_audio_settings *as)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct audio_settings_data *asd =3D ofono_audio_se=
ttings_get_data(as);
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_audio_settings_set_data(as, NULL);

Here you need to clean up asd->client as well.

Otherwise looks good.

I went ahead and commit-amended and patched these issues, and pushed
this and the other patch. Thanks!

Cheers,
Aki

--===============5970900423054968660==--

