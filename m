Content-Type: multipart/mixed; boundary="===============1671636520839808169=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ifxmodem: removing TAP/TUN support check for XMM vendor
Date: Tue, 15 Jan 2019 14:55:38 -0600
Message-ID: <fa8c2937-5c32-10a8-8cf2-533da41bf976@gmail.com>
In-Reply-To: <1547202947-2741-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1671636520839808169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 01/11/2019 04:35 AM, Antara Borwankar wrote:
> skipping TAP/TUN support check from gprs-context probe for
> xmm vendor. xmm modem does not require TAP/TUN support. Also
> it is not enabled by default in enbedded yocto bsp.
> ---
>   drivers/ifxmodem/gprs-context.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============1671636520839808169==--

