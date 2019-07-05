Content-Type: multipart/mixed; boundary="===============3355534374587011926=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 08/10] quectel: fix initial channel/device configuration
Date: Fri, 05 Jul 2019 17:29:18 -0500
Message-ID: <028bcf99-c850-65a3-fdf0-f0d1fb98db0b@gmail.com>
In-Reply-To: <20190704110351.47831-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3355534374587011926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 07/04/2019 06:03 AM, Martin Hundeb=C3=B8ll wrote:
> The three-commands-in-one-go results in error on some quectel devices
> (e.g. m95). Add semicolons between the commands to fix it.
> ---
>   plugins/quectel.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============3355534374587011926==--

