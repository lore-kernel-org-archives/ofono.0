Content-Type: multipart/mixed; boundary="===============4235546108628499623=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 1/1] gisi: Updated subscriptions and pipe handling to
 accomodate additional isimodem versions
Date: Fri, 28 Jan 2011 16:33:44 +0200
Message-ID: <201101281633.44721.remi.denis-courmont@nokia.com>
In-Reply-To: <1296214630-27822-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4235546108628499623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 28 January 2011 13:37:10 ext Jessica Nilsson, you wrote:
> diff --git a/gisi/common.h b/gisi/common.h
> index 83a8cf5..c78f893 100644
> --- a/gisi/common.h
> +++ b/gisi/common.h
> @@ -26,6 +26,8 @@
>  extern "C" {
>  #endif
> =

> +#define PN_HOST                                        0x00
> +#define PN_MODEM                               0x60

It looks like you are mixing up services (PN_* from 0 to 255), with device =

addresses (PN_DEV_* multiple of four from 0 to 252).

>  #define PN_COMMGR                              0x10
>  #define PN_NAMESERVICE                         0xDB
>  #define PN_FIREWALL                            0x43
> diff --git a/gisi/modem.c b/gisi/modem.c
> index 8750367..7201235 100644
> --- a/gisi/modem.c
> +++ b/gisi/modem.c
> @@ -61,6 +61,7 @@ struct _GIsiModem {
>         unsigned index;
>         GHashTable *services;
>         gboolean subs_source;
> +       GIsiVersion version;

I can't see where this gets set?!

>         int req_fd;
>         int ind_fd;
>         guint req_watch;
> @@ -349,11 +345,34 @@ static gboolean modem_subs_update(gpointer data)
>         gpointer keyptr, value;
> =

>         GIsiModem *modem =3D data;
> -       uint8_t msg[3 + 256] =3D {
> -               0, PNS_SUBSCRIBED_RESOURCES_IND,
> -               0,
> -       };
> +       GIsiMessage dmsg;
> +       uint8_t msg[3 + 256] =3D { 0 };
>         uint8_t count =3D 0;
> +       int msg_size =3D 0;
> +       struct sockaddr_pn commgr =3D {
> +               .spn_family =3D AF_PHONET,
> +               .spn_resource =3D PN_COMMGR,
> +       };
> +
> +       if (g_isi_modem_version_major(modem) =3D=3D 2 &&
> +               g_isi_modem_version_minor(modem) =3D=3D 5) {

You really need to factor this check out. It's going to be a disaster when =

there are more than two versions otherwise.

> +               uint8_t s_msg[4] =3D {
> +                       0, PNS_SUBSCRIBED_RESOURCES_EXTEND_IND,
> +                       0,
> +                       0, /* filler */
> +               };
> +               g_memmove(msg, s_msg, 4);
> +               msg_size =3D 4;
> +
> +               commgr.spn_dev =3D PN_MODEM;
> +       } else {
> +               uint8_t s_msg[3] =3D {
> +                       0, PNS_SUBSCRIBED_RESOURCES_IND,
> +                       0,
> +               };
> +               g_memmove(msg, s_msg, 3);
> +               msg_size =3D 3;
> +       }
> =

>         modem->subs_source =3D 0;
> =

> @@ -363,13 +382,31 @@ static gboolean modem_subs_update(gpointer data)
>                 GIsiServiceMux *mux =3D value;
> =

>                 if (mux->subscriptions > 0) {
> -                       msg[3 + count] =3D mux->resource;
> +
>                         count++;
> +
> +                       if (g_isi_modem_version_major(modem) =3D=3D 2 &&
> +                               g_isi_modem_version_minor(modem) =3D=3D 5=
) {
> +                               msg[3 + (count * 4)] =3D mux->resource;
> +                               msg_size +=3D 4;
> +                       } else {
> +                               msg[2 + count] =3D mux->resource;
> +                               msg_size +=3D count;
> +                       }
> +
>                 }
>         }
>         msg[2] =3D count;
> =

> -       sendto(modem->ind_fd, msg, 3 + msg[2], MSG_NOSIGNAL, (void
> *)&commgr, +       dmsg.addr =3D &commgr;
> +       dmsg.error =3D 0;
> +       dmsg.data =3D msg;
> +       dmsg.len =3D msg_size;
> +
> +       if (modem->trace !=3D NULL)
> +               modem->trace(&dmsg, NULL);
> +
> +       sendto(modem->ind_fd, msg, msg_size, MSG_NOSIGNAL, (void *)&commg=
r,
>                 sizeof(commgr));

That should probably be a separate patch.

> =

>         return FALSE;
> diff --git a/gisi/pipe.c b/gisi/pipe.c
> index 1bd5140..14d8b1c 100644
> --- a/gisi/pipe.c
> +++ b/gisi/pipe.c
> @@ -24,15 +24,22 @@
>  #endif
> =

>  #include <stdint.h>
> +#include <sys/ioctl.h>
> +#include <net/if.h>
> +#include <fcntl.h>
> +#include <unistd.h>
>  #include <errno.h>
>  #include <glib.h>
> =

>  #include "client.h"
>  #include "pipe.h"
> +#include "common.h"
> =

>  #define PN_PIPE                        0xD9
>  #define PN_PIPE_INVALID_HANDLE 0xFF
> =

> +#define PN_OBJ_PEP_GPRS 0x30
> +
>  struct isi_pipe_create_req {
>         uint8_t cmd;
>         uint8_t state_after;
> @@ -73,6 +80,53 @@ struct isi_pipe_resp {
>         uint8_t error2;
>  };
> =

> +struct isi_pep_connect_req{
> +       uint8_t cmd;
> +       uint8_t pipe_handle;
> +       uint8_t state_after;
> +       uint8_t other_pep_type;
> +       uint8_t filler1;
> +       uint8_t filler2;
> +       uint8_t n_sb;
> +       uint8_t data_sb;
> +       uint8_t sb_len;
> +       uint8_t alignment;
> +       uint8_t filler;
> +};
> +
> +struct isi_pep_enable_req{
> +       uint8_t cmd;
> +       uint8_t pipe_handle;
> +       uint8_t filler;
> +};
> +
> +struct isi_pep_disconnect_req{
> +       uint8_t cmd;
> +       uint8_t pipe_handle;
> +       uint8_t filler;
> +};
> +
> +struct isi_pep_resp {
> +       uint8_t pipe_handle;
> +       uint8_t error_code;
> +};
> +
> +struct isi_pipe_created_ind{
> +       uint8_t cmd;
> +       uint8_t pipe_handle;
> +       uint8_t n_sb;
> +       uint8_t sb_neg_fc;
> +       uint8_t sb_len;
> +       uint8_t tx_fc;
> +       uint8_t rx_fc;
> +};
> +
> +struct isi_pipe_enabled_ind{
> +       uint8_t cmd;
> +       uint8_t pipe_handle;
> +       uint8_t filler;
> +};
> +

We already have this in kernel and I wonder why this needs to be duplicated=
 in =

userspace now?! Furthermore pipe.c is about pipes. Pipe endpoints code belo=
ngs =

in pep.c. If you want to implement a pipe controller in gisi, then I think =
it =

really deserves a new file of its own.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============4235546108628499623==--

