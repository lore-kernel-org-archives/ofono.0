Content-Type: multipart/mixed; boundary="===============7208962846229851264=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 2/3] hfp_hf: Add generic hfp modem vendor
Date: Wed, 27 Mar 2013 00:09:28 -0500
Message-ID: <51527F08.1090508@gmail.com>
In-Reply-To: <d928220c40964749f7c79822563087cdf3af74a1.1360663430.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7208962846229851264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Timo,

On 02/13/2013 02:36 AM, Timo Mueller wrote:
> From: Timo Mueller<timo.mueller@bmw-carit.de>
>
> ---
>   drivers/hfpmodem/vendor.h    | 25 +++++++++++++++++++++++++
>   drivers/hfpmodem/voicecall.c |  3 +++
>   plugins/hfp_hf_bluez4.c      |  4 +++-
>   plugins/hfp_hf_bluez5.c      |  5 ++++-
>   4 files changed, 35 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/hfpmodem/vendor.h
>

Please split up this patch in line with our patch submission guidelines. =

  Refer to HACKING, 'Submitting Patches' section.

I prefer this to be broken into four patches:
- vendor.h changes
- voicecall.c changes
- hfp_hf_bluez4 changes
- hfp_hf_bluez5 changes

--===============7208962846229851264==--

