Content-Type: multipart/mixed; boundary="===============3861586864753258846=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 02/10]  handsfree-audio: Move SCO to handsfree-audio.c
Date: Fri, 01 Mar 2013 13:20:14 -0600
Message-ID: <5130FF6E.1030807@gmail.com>
In-Reply-To: <1362077572-28049-3-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3861586864753258846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 02/28/2013 12:52 PM, Claudio Takahasi wrote:
>   This patch moves the SCO socket handling from hfp_hf_bluez5 plugin to
>   handsfree-audio.c file.
>
>   This is the initial step to be able to support sending the file
>   descriptor through the Agent NewConnection method.
> ---
>   plugins/hfp_hf_bluez5.c | 102 +----------------------------------------=
------
>   src/handsfree-audio.c   | 103 +++++++++++++++++++++++++++++++++++++++++=
++++++-
>   2 files changed, 103 insertions(+), 102 deletions(-)
>

<snip>

> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index b2d4b97..14488ac 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -25,12 +25,19 @@
>
>   #include<errno.h>
>   #include<stdio.h>
> +#include<stdint.h>
>   #include<string.h>
> +#include<fcntl.h>
> +#include<unistd.h>
> +#include<sys/socket.h>
>
>   #include<gdbus.h>
> +#include<gatchat.h>

Why do you need this?

>
> +#include<drivers/hfpmodem/slc.h>

Or this?

>   #include<ofono/handsfree-audio.h>
>
> +#include "bluetooth.h"
>   #include "ofono.h"
>
>   #define HFP_AUDIO_MANAGER_INTERFACE	OFONO_SERVICE ".HandsfreeAudioManag=
er"
> @@ -60,6 +67,97 @@ struct agent {
>   static struct agent *agent =3D NULL;
>   static int ref_count =3D 0;
>   static GSList *card_list =3D 0;
> +static guint sco_watch =3D 0;
> +static uint16_t local_hfp_version =3D HFP_VERSION_1_6;

Why do we need this?

> +
> +static ofono_bool_t slc_match(struct ofono_modem *modem, void *userdata)
> +{
> +	const char *remote =3D userdata;
> +	const char *value =3D ofono_modem_get_string(modem, "Remote");
> +
> +	if (value =3D=3D NULL)
> +		return FALSE;
> +
> +	/* Make sure SLC has been established */
> +	if (ofono_modem_get_powered(modem) !=3D TRUE)
> +		return FALSE;
> +
> +	return g_str_equal(remote, value);

The matching should be done on cards, not modems.

> +}
> +
> +static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
> +							gpointer user_data)
> +{
> +	struct sockaddr_sco saddr;
> +	socklen_t alen;
> +	int sk, nsk;
> +	char remote[18];
> +
> +	if (cond&  (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> +		return FALSE;
> +
> +	sk =3D g_io_channel_unix_get_fd(io);
> +
> +	memset(&saddr, 0, sizeof(saddr));
> +	alen =3D sizeof(saddr);
> +
> +	nsk =3D accept(sk, (struct sockaddr *)&saddr,&alen);
> +	if (nsk<  0)
> +		return TRUE;
> +
> +	bt_ba2str(&saddr.sco_bdaddr, remote);
> +
> +	if (ofono_modem_find(slc_match, remote) =3D=3D NULL) {
> +		ofono_error("Rejecting SCO: No SLC connection found!");
> +		close(nsk);
> +		return TRUE;
> +	}
> +
> +	return TRUE;
> +}
> +
> +static int sco_init(void)
> +{
> +	GIOChannel *sco_io;
> +	struct sockaddr_sco saddr;
> +	int sk, defer_setup =3D 1;
> +
> +	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
> +								BTPROTO_SCO);
> +	if (sk<  0)
> +		return -errno;
> +
> +	/* Bind to local address */
> +	memset(&saddr, 0, sizeof(saddr));
> +	saddr.sco_family =3D AF_BLUETOOTH;
> +	bt_bacpy(&saddr.sco_bdaddr, BDADDR_ANY);
> +
> +	if (bind(sk, (struct sockaddr *)&saddr, sizeof(saddr))<  0) {
> +		close(sk);
> +		return -errno;
> +	}
> +
> +	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
> +				&defer_setup, sizeof(defer_setup))<  0) {
> +		ofono_warn("Can't enable deferred setup: %s (%d)",
> +						strerror(errno), errno);
> +		local_hfp_version =3D HFP_VERSION_1_5;
> +	}
> +
> +	if (listen(sk, 5)<  0) {
> +		close(sk);
> +		return -errno;
> +	}
> +
> +	sco_io =3D g_io_channel_unix_new(sk);
> +	sco_watch =3D g_io_add_watch(sco_io,
> +				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
> +				sco_accept, NULL);
> +
> +	g_io_channel_unref(sco_io);
> +
> +	return 0;
> +}
>
>   static void card_append_properties(struct ofono_handsfree_card *card,
>   					DBusMessageIter *dict)
> @@ -430,7 +528,7 @@ void ofono_handsfree_audio_unref(void)
>
>   int __ofono_handsfree_audio_manager_init(void)
>   {
> -	return 0;
> +	return sco_init();
>   }
>
>   void __ofono_handsfree_audio_manager_cleanup(void)
> @@ -443,4 +541,7 @@ void __ofono_handsfree_audio_manager_cleanup(void)
>
>   	ref_count =3D 1;
>   	ofono_handsfree_audio_unref();
> +
> +	if (sco_watch>  0)
> +		g_source_remove(sco_watch);
>   }

Regards,
-Denis

--===============3861586864753258846==--

