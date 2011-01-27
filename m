Content-Type: multipart/mixed; boundary="===============0580736466122678457=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/4] bluetooth: only use bluetooth_refcount in
 bluetooth_ref/bluetooth_unref
Date: Thu, 27 Jan 2011 16:12:04 +0100
Message-ID: <1296141124.1520.157.camel@aeonflux>
In-Reply-To: <1296140740-11486-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0580736466122678457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

>  plugins/bluetooth.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> =

> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 93dd7a1..e59bd31 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -505,7 +505,7 @@ static guint adapter_added_watch;
>  static guint adapter_removed_watch;
>  static guint property_watch;
>  =

> -static void bluetooth_ref(void)
> +static int bluetooth_ref(void)
>  {

why are we now reverting something back that we already applied
upstream. Something is wrong here.

Regards

Marcel



--===============0580736466122678457==--

