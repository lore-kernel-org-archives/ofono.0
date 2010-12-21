Content-Type: multipart/mixed; boundary="===============5706062647572859823=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.uklinux.net>
Subject: Re: [PATCH] udev: Fix warning in compilation
Date: Tue, 21 Dec 2010 11:56:06 +0000
Message-ID: <87fwtr9w6h.fsf@ossau.uklinux.net>
In-Reply-To: <1292922199-20434-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5706062647572859823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Antti Paila <antti.paila@nokia.com> writes:

> ---
>  plugins/udev.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/plugins/udev.c b/plugins/udev.c
> index 837ee9c..3ca6af0 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -452,7 +452,6 @@ static void add_isi(struct ofono_modem *modem,
>  static void add_calypso(struct ofono_modem *modem,
>  					struct udev_device *udev_device)
>  {
> -	struct udev_list_entry *entry;
>  	const char *devnode;
>  =

>  	DBG("modem %p", modem);

My apologies for putting that warning in.  Thanks for fixing it.

     Neil

--===============5706062647572859823==--

