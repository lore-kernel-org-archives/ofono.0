Content-Type: multipart/mixed; boundary="===============0050003922755397326=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 06/20] _assembly_encode_address: export and rename
Date: Fri, 23 Jul 2010 17:31:00 -0500
Message-ID: <4C4A1824.9040000@gmail.com>
In-Reply-To: <ebfe4b1dd715e2ebe6c155d2c32bce0f42a5014f.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0050003922755397326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 07/23/2010 03:59 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> The new name better reflects the function's purpose.
> =

> We need to export it, as for generating unique message naming (for
> persistence and D-Bus object naming), we'll be using the
> address.
> ---
>  src/smsutil.c |    7 +++----
>  src/smsutil.h |    2 ++
>  2 files changed, 5 insertions(+), 4 deletions(-)
> =


Applied with a very small tweak to the commit header.  Thanks.

Regards,
-Denis

--===============0050003922755397326==--

