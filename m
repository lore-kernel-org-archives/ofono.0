Content-Type: multipart/mixed; boundary="===============3310887741961706435=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] qmimodem/network-registration: register callbacks
 after ofono_netreg_register()
Date: Mon, 11 Sep 2017 10:41:53 -0500
Message-ID: <4db1e202-723c-eb2a-5885-e65f796dbb74@gmail.com>
In-Reply-To: <20170911002543.31030-2-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3310887741961706435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 09/10/2017 07:25 PM, Alexander Couzens wrote:
> When registering callbacks before ofono_netreg_register(), callbacks
> will use the netreg api which might lead into undefined behaviour,
> because certain fields aren't yet initilized.
> ---
>   drivers/qmimodem/network-registration.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Applied, thanks.

Regards,
-Denis


--===============3310887741961706435==--

