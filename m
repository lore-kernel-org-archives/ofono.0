Content-Type: multipart/mixed; boundary="===============0822734585748723313=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH resend 1/3] voicecall: Rename cb-function hangup to
 hangup_active in core and drivers.
Date: Wed, 11 Aug 2010 18:03:19 -0500
Message-ID: <4C632C37.4000509@gmail.com>
In-Reply-To: <1281388719-11781-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0822734585748723313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 08/09/2010 04:18 PM, Sjur Br=C3=A6ndeland wrote:
> From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
> =

> ---
>  drivers/atmodem/voicecall.c      |    4 ++--
>  drivers/calypsomodem/voicecall.c |    2 +-
>  drivers/hfpmodem/voicecall.c     |    2 +-
>  drivers/isimodem/voicecall.c     |    2 +-
>  drivers/stemodem/voicecall.c     |    2 +-
>  include/voicecall.h              |    2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

I applied patch 1 and 2.  For patch 3 I changed my mind and fixed it
slightly differently (e.g. just always skipping WAITING calls).

Regards,
-Denis

--===============0822734585748723313==--

