Content-Type: multipart/mixed; boundary="===============9114157018200269938=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] sim: Use quoted string with AT+CRSM data parameter
Date: Fri, 23 Mar 2012 08:39:51 -0500
Message-ID: <4F6C7D27.40802@gmail.com>
In-Reply-To: <1332437290-31190-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9114157018200269938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 03/22/2012 12:28 PM, Nicolas Bertrand wrote:
> Fix issue with some modems preventing to update elementary files
> (speedup, ZTE, huawei, MBM)
> ---
>  drivers/atmodem/sim.c |  127 ++++++++++++++++---------------------------=
------
>  1 files changed, 41 insertions(+), 86 deletions(-)
>

Patch has been applied, but I had to fix up numerous coding style
violations afterwards.  Please re-read doc/coding-style.txt and pay
extra attention next time.

Just one more comment:

> +	sprintf(buf + len, "%s", quote);
>  =


Something like this is really wasteful, you're invoking sprintf (which
is quite a heavy hammer) just to put in a quote character.  Use buf[len]
=3D '\"' next time.

Regards,
-Denis

--===============9114157018200269938==--

