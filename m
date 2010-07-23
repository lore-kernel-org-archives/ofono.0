Content-Type: multipart/mixed; boundary="===============3434791724122219817=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 05/20] introduce DECLARE_SMS_ADDR_STR()
Date: Fri, 23 Jul 2010 17:30:11 -0500
Message-ID: <4C4A17F3.2090700@gmail.com>
In-Reply-To: <c8d46d04c81da20902f52f017b7081ef8f042545.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3434791724122219817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 07/23/2010 03:59 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> Introduce DECLARE_SMS_ADDR_STR(), which declares a string variable of
> the right size for passing to sms_assembly_decode_address(). This way
> we detach each client having to have the knowledge of what the right
> size is, leaving that decission to the infrastructure
> provider. Updated couple of sites in smsutil.c to use it vs a raw
> declaration.
> ---
>  src/smsutil.c |    4 ++--
>  src/smsutil.h |    6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> =


This one has been applied, thanks.

Regards,
-Denis

--===============3434791724122219817==--

