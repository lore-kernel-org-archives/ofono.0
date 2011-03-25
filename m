Content-Type: multipart/mixed; boundary="===============1822784394540586629=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] dun: Add ATX command in emulator (X0 only)
Date: Fri, 25 Mar 2011 12:36:27 -0500
Message-ID: <4D8CD29B.70500@gmail.com>
In-Reply-To: <1300980591-9395-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1822784394540586629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

On 03/24/2011 10:29 AM, Olivier Guiter wrote:
> ---
>  src/emulator.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 56 insertions(+), 1 deletions(-)
> =


I applied this patch, however...

<snip>

> +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
> +		g_at_server_send_info(server, "000", TRUE);

This seems fishy to me.  Shouldn't this be X: 0?

> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;

<snip>

Regards,
-Denis

--===============1822784394540586629==--

