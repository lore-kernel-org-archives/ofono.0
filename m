Content-Type: multipart/mixed; boundary="===============4675956371939618217=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ublox: Do not leave vendor_family unset
Date: Mon, 01 Apr 2019 09:53:33 -0500
Message-ID: <3d8eb9ea-51e0-6bda-3e66-9dba77a85699@gmail.com>
In-Reply-To: <20190331211919.10720-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4675956371939618217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 03/31/2019 04:19 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> In a recent patch vendor family was only set if the device
> did not support USBCONF, but that resulted in drivers
> being registered the "generic" vendor. That caused
> for instance netreg to use incorrect cmer mode and fail
> on TOBY-L210.
> ---
>   plugins/ublox.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============4675956371939618217==--

