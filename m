Content-Type: multipart/mixed; boundary="===============6846070654536472242=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] udevng: Add Gemalto P-family detection
Date: Mon, 16 Jan 2017 21:52:00 -0600
Message-ID: <08848843-dd39-eec1-51f4-d2dc033a12c7@gmail.com>
In-Reply-To: <1484557673-15666-2-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6846070654536472242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 01/16/2017 03:07 AM, Vincent Cesson wrote:
> Add a new function setup, based on telit, to handle Gemalto P-family
> discovery. The setup looks for USB interfaces:
> application=3D/dev/ttyUSB2
> gps=3D/dev/ttyUSB1
> modem=3D/dev/ttyUSB3
> ---
>  plugins/udevng.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============6846070654536472242==--

