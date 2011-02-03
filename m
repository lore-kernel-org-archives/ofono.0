Content-Type: multipart/mixed; boundary="===============7110478117721695126=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] simfs: Use cache for sim_fs_read_info requests too.
Date: Thu, 03 Feb 2011 11:38:14 -0600
Message-ID: <4D4AE806.1000909@gmail.com>
In-Reply-To: <1296260961-15155-3-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7110478117721695126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 01/28/2011 06:29 PM, Andrzej Zaborowski wrote:
> There seems to be no reason that the fileinfo is cached for file
> read or block read requests but not info_only requests, so move
> code around to fix this.  O_RDWR is changed to O_WRONLY for the
> cache file because the file is not being read in case of cache miss.
> ---
>  src/simfs.c |  140 ++++++++++++++++++++++++++++++++++-------------------=
-----
>  1 files changed, 82 insertions(+), 58 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============7110478117721695126==--

