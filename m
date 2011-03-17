Content-Type: multipart/mixed; boundary="===============1529960744570969370=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] PPP: Switch ringbuffer.c to g_slice allocator
Date: Wed, 16 Mar 2011 21:37:13 -0500
Message-ID: <4D8173D9.6030108@gmail.com>
In-Reply-To: <1300267463-4980-1-git-send-email-patrick.porlan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1529960744570969370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On 03/16/2011 04:24 AM, Patrick Porlan wrote:
> This should allow for more efficient handling of equally sized
> buffers, in terms of alignment and recycling.
> ---
>  gatchat/ringbuffer.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============1529960744570969370==--

