Content-Type: multipart/mixed; boundary="===============4084510857214980149=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] simfs: Reset op_source in simfs_read_block.
Date: Sat, 29 Jan 2011 11:22:28 -0600
Message-ID: <4D444CD4.4040808@gmail.com>
In-Reply-To: <1296260961-15155-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4084510857214980149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 01/28/2011 06:29 PM, Andrzej Zaborowski wrote:
> If the block is not in cache or if this is the last block of a last
> op in the queue, then fs->op_source might be left with the wrong
> value.
> ---
>  src/simfs.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============4084510857214980149==--

