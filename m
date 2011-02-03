Content-Type: multipart/mixed; boundary="===============5504513065247473438=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stemodem: Fix handling of local_release.
Date: Thu, 03 Feb 2011 10:20:00 -0600
Message-ID: <4D4AD5B0.60405@gmail.com>
In-Reply-To: <1296738945-23696-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5504513065247473438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

On 02/03/2011 07:15 AM, Marit Henriksen wrote:
> From: Marit Henriksen <marit.henriksen@stericsson.com>
> =

> - Reset local_release when call is disconnected.
> - Change bitmap for affected types, ste_hangup is only called when
>   call state is Incoming, Dialing, Alerting or Active.
> - Used macros instead of numbers when creating bitmaps.
> ---
>  drivers/stemodem/voicecall.c |   21 ++++++++++++++++-----
>  1 files changed, 16 insertions(+), 5 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============5504513065247473438==--

