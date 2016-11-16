Content-Type: multipart/mixed; boundary="===============5632241959444199997=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ubloxmodem: gprscontext: adapt for newer firmware
Date: Wed, 16 Nov 2016 11:52:18 -0600
Message-ID: <582C9CD2.4000403@gmail.com>
In-Reply-To: <1479311662-12996-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5632241959444199997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 11/16/2016 09:54 AM, Dragos Tatulea wrote:
> The U-Blox documentation specifies the following:
> * get interface ip and dns from +CGDCONTRDP
> * get gw ip and netmask from +UIPADDR
>
> However, different firmware versions have different befaviour:
>
> * On newer firmware, +UIPADDR returns error. But it's possible to configu=
re
> gateway ip =3D=3D ipterface ip (read from CGDCONTRDP).
>
> * On older firmware, we can actually use the commands specified in the
> docs.
>
> This patch runs +CGDCONTRDP, configures everything and then tries to run
> +UIPADDR. In that works, reconfigures gw ip and netmask.
> ---
>   drivers/ubloxmodem/gprs-context.c | 51 ++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 51 insertions(+)
>

Amended the patch for a couple of small whitespace issues.  Applied, thanks!

Regards,
-Denis


--===============5632241959444199997==--

