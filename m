Content-Type: multipart/mixed; boundary="===============6670325639495045811=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] Use %m instead of strerror() in syslog messages
Date: Fri, 26 Nov 2010 15:12:09 -0600
Message-ID: <4CF022A9.2070104@gmail.com>
In-Reply-To: <1290682265-11373-2-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6670325639495045811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/25/2010 04:51 AM, R=C3=A9mi Denis-Courmont wrote:
> strerror() is not thread-safe, nor in the glibc implementation,
> nor in the POSIX specification. In my experience, it will infrequently
> crash when another thread uses locale data in any way, including
> string formatting and such...
> =

> Since the Huawei driver uses thread, we might as well avoid strerror().
> ---
>  drivers/isimodem/sim.c |    3 ++-
>  plugins/hfp.c          |    4 ++--
>  plugins/isigen.c       |   13 ++++++++-----
>  plugins/n900.c         |   14 +++++++-------
>  plugins/nokia-gpio.c   |   29 +++++++++++++++++------------
>  5 files changed, 36 insertions(+), 27 deletions(-)
> =


Since we do not use threads, do you still want this patch?  If you do,
can you please break this up into two patches, one for drivers/isimodem
and one for plugins?  We prefer patches to be split by directory.

<snip>

> @@ -765,7 +767,10 @@ int gpio_probe(GIsiModem *idx, unsigned addr, gpio_f=
inished_cb_t cb, void *data)
>  	if (addr) {
>  		error =3D g_pn_netlink_set_address(idx, addr);
>  		if (error && error !=3D -EEXIST)
> -			DBG("g_pn_netlink_set_address: %s", strerror(-error));
> +		{
> +			errno =3D -error;
> +			DBG("g_pn_netlink_set_address: %m");
> +		}
>  	}
>  =

>  	return 0;

You might also want to fix the style violation above, the opening brace
should be on the same line as the if statement.

Regards,
-Denis

--===============6670325639495045811==--

