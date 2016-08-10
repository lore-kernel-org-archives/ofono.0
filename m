Content-Type: multipart/mixed; boundary="===============0832820997402832813=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] huaweimodem: Fix DHCP parsing on 32-bit platforms
Date: Wed, 10 Aug 2016 11:22:34 -0500
Message-ID: <57AB54CA.90901@gmail.com>
In-Reply-To: <1470823447-24819-1-git-send-email-santtu.lakkala@link-motion.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0832820997402832813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Santtu,

On 08/10/2016 05:04 AM, Santtu Lakkala wrote:
> strtol clamps returned value between INT_MIN and INT_MAX, causing
> invalid value (255.255.255.127) being reported for any address
> if last octet > 127 when sizeof(long) =3D=3D 4.
> ---
>   drivers/huaweimodem/gprs-context.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============0832820997402832813==--

