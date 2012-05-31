Content-Type: multipart/mixed; boundary="===============7433901117283112921=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] v3: Wavecom Q2403/Q2686 modems support
Date: Thu, 31 May 2012 09:50:58 -0500
Message-ID: <4FC78552.2040305@gmail.com>
In-Reply-To: <1338472885-30645-1-git-send-email-pablo@gnumonks.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7433901117283112921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

On 05/31/2012 09:01 AM, pablo(a)gnumonks.org wrote:
> From: Pablo Neira Ayuso<pablo@gnumonks.org>
>
> Hi!
>
> This patch adds the missing bits to fully support Wavecom
> Q2403/Q2686 modems.
>
> Thanks to Denis Kenzior for providing useful tips to get a
> much nicer patch.
>
> Pablo Neira Ayuso (2):
>    udev: add Wavecom support
>    plugins: add support for Wavecom Q2403/Q2686 modems
>
>   drivers/atmodem/sim.c |    3 +++
>   plugins/udev.c        |   27 +++++++++++++++++++++++++++
>   plugins/wavecom.c     |   21 +++++++++++++++++++--
>   3 files changed, 49 insertions(+), 2 deletions(-)
>

Everything in this series has been pushed upstream.  I did split patch =

#2 into two commits.

Thanks,
-Denis

--===============7433901117283112921==--

