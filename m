Content-Type: multipart/mixed; boundary="===============4807861426677794240=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/3] udevng: Add Gemalto P-family detection
Date: Fri, 13 Jan 2017 16:31:34 -0600
Message-ID: <890ad773-025c-4412-360b-042ce9b8fe67@gmail.com>
In-Reply-To: <1484240812-3327-3-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4807861426677794240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/12/2017 11:06 AM, Vincent Cesson wrote:
> From: vcesson <vincent.cesson@smile.fr>

Please update your Author info.

>
> Add a new function setup, based on telit, to handle Gemalto P-family
> discovery. The setup look for USB interfaces:
> application=3D/dev/ttyUSB2
> gps=3D/dev/ttyUSB1
> modem=3D/dev/ttyUSB3
> ---
>  plugins/udevng.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>

Looks fine to me.

Regards,
-Denis


--===============4807861426677794240==--

