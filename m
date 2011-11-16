Content-Type: multipart/mixed; boundary="===============0106806136922902075=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/6] cdmamodem: Add serving system identifier support
Date: Wed, 16 Nov 2011 04:26:00 -0600
Message-ID: <4EC38FB8.6040105@gmail.com>
In-Reply-To: <1321546864-368-7-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0106806136922902075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 11/17/2011 10:21 AM, Philippe Nunes wrote:
> ---
>  drivers/cdmamodem/network-registration.c |   78 ++++++++++++++++++++++++=
++++++
>  include/cdma-netreg.h                    |    7 +++
>  2 files changed, 85 insertions(+), 0 deletions(-)
> =


So the obvious comment is that this patch should be split into two, one
for adding new driver API and one for the driver changes.

I would also like to see how you're planning to use this information in
the core, before reviewing this patch in detail.  Do note that after
taking a quick peek at Huawei CDMA manuals and ModemManager, I very much
doubt that +CSS is what you want to use in the first place.

Regards,
-Denis

--===============0106806136922902075==--

