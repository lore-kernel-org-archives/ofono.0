Content-Type: multipart/mixed; boundary="===============4009818796158975668=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH udev 01/15] udevng: simplify logic in check_usb_device
Date: Sun, 26 Mar 2017 20:46:34 -0500
Message-ID: <6f542a3b-37c4-d7ce-56e4-a528910fc280@gmail.com>
In-Reply-To: <20170325165805.28166-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4009818796158975668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/25/2017 11:57 AM, Jonas Bonn wrote:
> This patch simplifies and cleans up the check_usb_device function a bit
> by doing the two following (slightly intertwined) things:
>
> 1)  The parent "usb_device" is searched for early in this function and th=
is
> device will always have the ID_VENDOR_ID and ID_MODEL_ID properties.
> As such, we can get them from this device and thereby be certain that
> we _always_ have them available.
>
> 2)  The logic of iterating the vendor_list table is cleaned up.  It's
> easier to follow and won't be any less efficient.
> ---
>  plugins/udevng.c | 37 ++++++++++++-------------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============4009818796158975668==--

