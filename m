Content-Type: multipart/mixed; boundary="===============4414978348766386545=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 03/10] ublox: query USBCONF for applicable devices
Date: Wed, 13 Mar 2019 16:30:36 -0500
Message-ID: <3ca8bdc5-fdf4-2442-4632-e257bf1cd367@gmail.com>
In-Reply-To: <20190313204657.22395-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4414978348766386545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/13/2019 03:46 PM, Jonas Bonn wrote:
> The TOBY L2 series of modems presents a number of different
> configurations with different throughtput characteristics.  These
> configurations are packaged up as USB profiles; moreover, changing the
> profile actually changes the USB model ID so this is even more like
> selecting a different "device" altogether.  Nonetheless, all we need to
> know is which profile is selected in order to set things up correctly
> and this can be queried directly.
> =

> This patch adds a call to UUSBCONF for applicable modems in order to
> query the USB configuration to find out which profile is active.
> ---
>   plugins/ublox.c | 84 +++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 61 insertions(+), 23 deletions(-)
> =


Okay, I applied v2 patches 1, 2, 4 and v3 patch 3.

Patch 5 no longer applies, so please re-submit.

Regards,
-Denis


--===============4414978348766386545==--

