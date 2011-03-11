Content-Type: multipart/mixed; boundary="===============6832158631980060536=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simfs: fix GLib-CRITICAL issue occuring when there is no
 SIM card.
Date: Fri, 11 Mar 2011 15:46:23 -0600
Message-ID: <4D7A982F.705@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5BA2@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6832158631980060536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 03/09/2011 06:32 AM, Lucas, GuillaumeX wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
> =

> During modem release, when there is no SIM card, a GLib-CRITICAL
> issue occurs during the free of the sim fs context.
> ---
>  src/simfs.c |   26 ++++++++++++++------------
>  1 files changed, 14 insertions(+), 12 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============6832158631980060536==--

