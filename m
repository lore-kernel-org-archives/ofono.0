Content-Type: multipart/mixed; boundary="===============2316951309882845372=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugins: Add support for SIM7100E by SIMCom
Date: Mon, 30 Apr 2018 11:19:29 -0500
Message-ID: <82df3069-20e3-c28c-3402-278be5954b0c@gmail.com>
In-Reply-To: <20180430135606.22571-1-bob.ham@puri.sm>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2316951309882845372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bob,

On 04/30/2018 08:56 AM, Bob Ham wrote:
> Add support for the SIM7100E modem.  We add a new "sim7100" plugin
> because there's no other AT-based modem that has support for both GPRS
> and voice calls.
> ---
>   Makefile.am       |   3 +
>   plugins/sim7100.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++
>   plugins/udevng.c  |  56 +++++++++-
>   3 files changed, 327 insertions(+), 3 deletions(-)
>   create mode 100644 plugins/sim7100.c
> =


Applied, thanks!  I did silently fix a couple of >80 character line =

violations.

Regards,
-Denis

--===============2316951309882845372==--

