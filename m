Content-Type: multipart/mixed; boundary="===============7086254989223521681=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 3/5] test-server: Add PPP server support
Date: Wed, 30 Jun 2010 17:43:21 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F681664@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1277435949-5976-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7086254989223521681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Zhenhua Zhang wrote:
> So that gsmdial and wvdial could talk to test-server and establish
> PPP connection. ---
> gatchat/test-server.c |  131
> ++++++++++++++++++++++++++++++++++++++++++++++---
> 1 files changed, 123 insertions(+), 8 deletions(-)
> =

> diff --git a/gatchat/test-server.c b/gatchat/test-server.c
> index 5c1cfa4..96faab4 100644
> --- a/gatchat/test-server.c
> +++ b/gatchat/test-server.c
>
<--snip-->

> static void server_destroy(gpointer user)
> @@ -706,15 +825,11 @@ static void server_destroy(gpointer user)
> =

> static void set_raw_mode(int fd)
> {
> -	struct termios options;
> -
> -	tcgetattr(fd, &options);
> -
> -	/* Set TTY as raw mode to disable echo back of input characters
> -	 * when they are received from Modem to avoid feedback loop */
> -	options.c_lflag &=3D ~(ICANON | ECHO | ECHOE | ISIG); +	struct
> termios ti; =

> =

> -	tcsetattr(fd, TCSANOW, &options);
> +	tcflush(fd, TCIOFLUSH);
> +	cfmakeraw(&ti);
> +	tcsetattr(fd, TCSANOW, &ti);
> }
>
> static gboolean create_tty(const char *modem_path)

I found above changes does not contain latest git tree. The part of change =
is necessary when I tried to use bluetooth serial proxy between two machine=
s. Without cfmakeraw, the server responses:
	'\r\nOK\r\n'
would change to:
	'\n\nOK\n\n'

And this issue doesn't exist if both server and client on the same machine.

> --
> 1.6.3.3
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============7086254989223521681==--

