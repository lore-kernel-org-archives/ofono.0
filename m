Content-Type: multipart/mixed; boundary="===============0393872933941042898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] at/cdma/ifxmodem: Use /dev/net/tun to check for TUN
 support
Date: Tue, 22 Aug 2017 23:26:52 -0500
Message-ID: <08ad4db1-6f2f-7856-455e-53f262018c21@gmail.com>
In-Reply-To: <20170822161629.GB10106@login.tika.stderr.nl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0393872933941042898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthijs,

On 08/22/2017 11:16 AM, Matthijs Kooijman wrote:
> Previously, these drivers would check /sys/devices/virtual/misc/tun to
> see if TUN is supported, and bail out otherwise. However, the tun module
> can sometimes be autoloaded by opening the /dev/net/tun file. In this
> case the /dev file already exists, but the /sys file only gets created
> after the modul is loaded.
> =

> Additionally, the ppp code does not use the /sys file, but only the
> /dev file, so checking for the existence of the latter seems a better
> indicator of expected success.
> =

> ---
> This patch was only tested with the atmodem driver, but the other two
> seem similar enough that it should work there as well.
> =

> This is a verbatim resend of this patch, orginally sent on 15th of July,
> as requested by Denis Kenzior.

Applied, thanks.

Regards,
-Denis


--===============0393872933941042898==--

