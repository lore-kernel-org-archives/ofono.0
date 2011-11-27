Content-Type: multipart/mixed; boundary="===============1368837485106579105=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 1/4] cdmamodem: Add sim driver implementation
Date: Sun, 27 Nov 2011 06:02:33 -0600
Message-ID: <4ED226D9.2070502@gmail.com>
In-Reply-To: <1321872845-24754-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1368837485106579105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 11/21/2011 04:54 AM, Guillaume Zajac wrote:
> ---
>  Makefile.am                   |    3 +-
>  drivers/cdmamodem/cdmamodem.c |    2 +
>  drivers/cdmamodem/cdmamodem.h |    3 +
>  drivers/cdmamodem/sim.c       |  582 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 589 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/cdmamodem/sim.c
> =


I really don't like us copy-pasting this much code for no good reason.
Let me toy with a few ideas, but the obvious start would be to refactor
this code into a library.

Regards,
-Denis

--===============1368837485106579105==--

