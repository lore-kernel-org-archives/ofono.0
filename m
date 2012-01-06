Content-Type: multipart/mixed; boundary="===============3166071762553799095=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v0 1/3] udevng: Simplify vendor_list for Huawei constructor
Date: Fri, 06 Jan 2012 13:43:41 -0800
Message-ID: <1325886221.6454.94.camel@aeonflux>
In-Reply-To: <1325863718-19357-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3166071762553799095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> According to Huawei constructor, the port mapping is identical
> for all the modems. We can decide to use GSM or CDMA drivers into
> the plugin.
> ---
>  plugins/udevng.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

we might should do this last, but I applied the patch anyway.

Regards

Marcel



--===============3166071762553799095==--

