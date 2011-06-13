Content-Type: multipart/mixed; boundary="===============0278753106140538685=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spiekerdoyle@gmail.com>
Subject: Re: [PATCH] cdma-voicecall: Fix for crash when unregistering atom
Date: Mon, 13 Jun 2011 15:53:00 -0700
Message-ID: <4DF694CC.6080107@gmail.com>
In-Reply-To: <1308004662-2310-1-git-send-email-dara.spiekerdoyle@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0278753106140538685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/13/2011 03:37 PM, Dara Spieker-Doyle wrote:
> ---
>   src/cdma-voicecall.c |   14 ++++++++++++++
>   1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
> index a590063..2bdf850 100644
> --- a/src/cdma-voicecall.c
> +++ b/src/cdma-voicecall.c
> @@ -335,6 +335,18 @@ void ofono_cdma_voicecall_driver_unregister(
>   	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
>   }
>
Please ignore this patch as it contains incorrect formatting. I shall =

resubmit.

Regards
Dara


--===============0278753106140538685==--

