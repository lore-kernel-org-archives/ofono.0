Content-Type: multipart/mixed; boundary="===============7897212435166366274=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] cdmamodem: fix to follow oFono probe rules
Date: Fri, 14 Jan 2011 14:23:04 -0600
Message-ID: <4D30B0A8.3090402@gmail.com>
In-Reply-To: <1295036752-23114-1-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7897212435166366274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 01/14/2011 02:25 PM, Dara Spieker-Doyle wrote:
> Not allowed to call register directly from probe, use g_idle_add
> instead for now
> ---
>  drivers/cdmamodem/voicecall.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============7897212435166366274==--

