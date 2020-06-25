Content-Type: multipart/mixed; boundary="===============3770006544757581519=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: clean context properly
Date: Thu, 25 Jun 2020 12:05:16 -0500
Message-ID: <c0c700a0-5d6e-bb7f-13bc-08764eb9355e@gmail.com>
In-Reply-To: <20200625093008.4840-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3770006544757581519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jimmy,

On 6/25/20 4:30 AM, Jimmy Gysens wrote:
> After a context is detached, the context is not properly cleared. In
> addition to releasing the context:
> =

> - Reset the context settings (IP, DNS, interface, ...).
> - Signal the Active flag as false.
> ---
>   src/gprs.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3770006544757581519==--

