Content-Type: multipart/mixed; boundary="===============7399485599292819838=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Remove stray newlines in DBG and ofono log messages
Date: Fri, 26 Nov 2010 13:51:31 -0600
Message-ID: <4CF00FC3.9060906@gmail.com>
In-Reply-To: <1290682265-11373-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7399485599292819838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 11/25/2010 04:51 AM, R=C3=A9mi Denis-Courmont wrote:
> ---
>  drivers/isimodem/call-barring.c    |   10 +++++-----
>  drivers/isimodem/call-forwarding.c |    8 ++++----
>  drivers/isimodem/call-settings.c   |    8 ++++----
>  drivers/isimodem/cbs.c             |    2 +-
>  drivers/isimodem/sms.c             |    2 +-
>  drivers/stemodem/caif_rtnl.c       |    2 +-
>  drivers/stemodem/gprs-context.c    |    2 +-
>  plugins/isigen.c                   |    2 +-
>  src/gprs.c                         |    2 +-
>  src/sim.c                          |    2 +-
>  src/voicecall.c                    |    4 ++--
>  11 files changed, 22 insertions(+), 22 deletions(-)
> =


I applied this patch but broke it up into four:

- isimodem
- stemodem
- isigen
- core

Regards,
-Denis

--===============7399485599292819838==--

