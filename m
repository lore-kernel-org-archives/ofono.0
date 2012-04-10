Content-Type: multipart/mixed; boundary="===============0334527700783552639=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] ussd: Fix speedup ussd encoding
Date: Tue, 10 Apr 2012 02:53:02 -0500
Message-ID: <4F83E6DE.7040203@gmail.com>
In-Reply-To: <1334072105-32105-3-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0334527700783552639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 04/10/2012 10:35 AM, Nicolas Bertrand wrote:
> Speedup dongles encode USSD strings in GSM7
> packed, so we don't have to pack it ourselves.
> ---
>  drivers/atmodem/ussd.c |   13 ++++++++++---
>  plugins/speedup.c      |    2 +-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> =


Patch looks good, but please split it into two in accordance with our
patch submission guidelines.  See HACKING document, 'Submitting patches'
section.

Regards,
-Denis

--===============0334527700783552639==--

