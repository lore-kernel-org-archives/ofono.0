Content-Type: multipart/mixed; boundary="===============0018247832220299328=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH udev 06/15] udev: simplify add_modem
Date: Sun, 26 Mar 2017 22:09:10 -0500
Message-ID: <47726de7-6ef7-73ee-a5be-929c67cd99e7@gmail.com>
In-Reply-To: <20170325165805.28166-7-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0018247832220299328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/25/2017 11:57 AM, Jonas Bonn wrote:
> Adding a modem boils down to finding the device in the hierarchy with
> the OFONO_DRIVER property.  The original code special-cased the property
> being on the device itself rather than on a parent device.  This patch
> combines the two cases.
> ---
>  plugins/udev.c | 72 ++++++++++++++++++++++++++--------------------------=
------
>  1 file changed, 32 insertions(+), 40 deletions(-)
>

I went ahead and applied patches 6-10.

Regards,
-Denis


--===============0018247832220299328==--

