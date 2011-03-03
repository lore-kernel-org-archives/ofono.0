Content-Type: multipart/mixed; boundary="===============1518501278676242330=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Replace modulo operations in ringbuffer.c by masking
 operations.
Date: Wed, 02 Mar 2011 22:51:35 -0600
Message-ID: <4D6F1E57.5020701@gmail.com>
In-Reply-To: <1299060935-12999-1-git-send-email-patrick.porlan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1518501278676242330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On 03/02/2011 04:15 AM, Patrick Porlan wrote:
> That's possible because the size of the ring buffers is always
> a power of two, and yields a small performance improvement.
> =

> The improvement should be mostly visible on processors that implement
> division in microcode (Atom) or lack a division instruction (ARM).
> ---
>  gatchat/ringbuffer.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============1518501278676242330==--

