Content-Type: multipart/mixed; boundary="===============3890892762052827953=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v9 1/4] huaweicdma: create a dedicated netreg atom.
Date: Tue, 09 Aug 2011 13:31:42 -0500
Message-ID: <4E417D0E.9030406@gmail.com>
In-Reply-To: <1312805600-20043-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3890892762052827953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 08/08/2011 07:13 AM, Guillaume Zajac wrote:
> From: Bertrand Aygon <bertrand.aygon@intel.com>
> =

> ---
>  Makefile.am                                    |    3 +-
>  drivers/huaweicdmamodem/huaweicdmamodem.c      |    3 +
>  drivers/huaweicdmamodem/huaweicdmamodem.h      |    3 +
>  drivers/huaweicdmamodem/network-registration.c |  171 ++++++++++++++++++=
++++++
>  4 files changed, 179 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/huaweicdmamodem/network-registration.c
> =


I applied this patch but refactored it slightly afterwards.  Please
review and make sure I didn't break anything.

Regards,
-Denis

--===============3890892762052827953==--

