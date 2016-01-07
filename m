Content-Type: multipart/mixed; boundary="===============5308553347555531412=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] network: Fix use-after-free caused by Scan() in poor
 reception.
Date: Thu, 07 Jan 2016 10:32:43 -0600
Message-ID: <568E932B.7000203@gmail.com>
In-Reply-To: <1452163577-23146-2-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5308553347555531412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 01/07/2016 04:46 AM, John Ernberg wrote:
> From: John Ernberg <john.ernberg@actia.se>
>
> When issuing a Scan() in poor reception while attached to an operator it's
> fully possible to get no results, which causes the attached operator to be
> cleaned up. In certain scenarios this would cause a use-after-free as the=
re
> are still references to this operator.
> Transfer the attached operator to the new list regardless of removal caus=
ed
> by the Scan() results.
> ---
>   src/network.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>

Looks good to me.  I tweaked the commit header slightly and applied the =

patch.

Thanks!

Regards,
-Denis

--===============5308553347555531412==--

