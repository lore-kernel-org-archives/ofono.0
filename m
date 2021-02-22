Content-Type: multipart/mixed; boundary="===============1226571746211742997=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: Add USSD indication support
Date: Mon, 22 Feb 2021 10:06:31 -0600
Message-ID: <9f0a4bab-1365-207a-436b-cd2fe569c93e@gmail.com>
In-Reply-To: <8fe191b9-0c3b-45ad-8701-d5311b64b3a6@ya.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1226571746211742997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

On 2/19/21 9:30 AM, Alexey Andreyev wrote:
> Sorry for a noob html format, retrying from a custom client as plaintext:
> =

> Hello! My first patch, feel free to criticize :) This is to handle the US=
SD =

> Indication messages with the qmimodem driver.
> Higher-level KDE Plasma Mobile issue: =

> https://invent.kde.org/plasma-mobile/plasma-dialer/-/merge_requests/33
> Tested with Quectel EG25-G (Pinephone BH), looks like working, I'm able t=
o =

> receive the expected QMI USSD Indication messages.
> =

> ---
>  From 2f041e6ba183a2f2a3309e139adef3d114bdc85b Mon Sep 17 00:00:00 2001
> From: Alexey Andreyev <aa13q@ya.ru>
> Date: Fri, 19 Feb 2021 15:47:42 +0300
> Subject: [PATCH] qmimodem: Add USSD indication support
> =

> Handle USSD QMI indication messages.
> Add support for UCS2 USS Data coding scheme.
> Check for User Action TLV type.
> ---
> drivers/qmimodem/ussd.c | 45 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 45 insertions(+)
> =


I had to hand-edit this patch for it to apply and then fix up the whitespac=
e =

formatting.  Please get git send-email working properly for future submissi=
ons.

Applied, thanks.

Regards,
-Denis
--===============1226571746211742997==--

