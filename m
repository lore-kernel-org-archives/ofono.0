Content-Type: multipart/mixed; boundary="===============3661160447518839631=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ublox: netreg: reuse at_registration_status
Date: Fri, 07 Feb 2020 10:56:50 -0600
Message-ID: <dc9e23f0-a390-dcd1-0777-fc139ff7e0a9@gmail.com>
In-Reply-To: <20200204122127.30760-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3661160447518839631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 2/4/20 6:21 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> Instead of implementing an own copy of requesting and parsing
> CREG, reuse the existing one from at-modem.
> ---
>   drivers/ubloxmodem/network-registration.c | 40 +++++++++--------------
>   1 file changed, 16 insertions(+), 24 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3661160447518839631==--

