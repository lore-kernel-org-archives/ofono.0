Content-Type: multipart/mixed; boundary="===============4854624790992096255=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/7] extended support for LTE and NR. Some minor fixes.
 part 3 of 7
Date: Wed, 19 Sep 2018 10:05:57 -0500
Message-ID: <48bcb420-a9c1-b65f-b6d2-b62184a13f95@gmail.com>
In-Reply-To: <1537335453-21498-3-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4854624790992096255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/19/2018 12:37 AM, Giacinto Cifelli wrote:
> ---
>   drivers/atmodem/atutil.h                 |  14 +
>   drivers/atmodem/cbs.c                    |   1 +
>   drivers/atmodem/gprs-context.c           |   2 +
>   drivers/atmodem/gprs.c                   | 554 ++++++++++++++++--
>   drivers/atmodem/lte.c                    | 283 ++++++++-
>   drivers/atmodem/network-registration.c   | 134 +++--
>   drivers/atmodem/sim.c                    |  10 +-
>   drivers/atmodem/sms.c                    |  21 +-
>   drivers/atmodem/vendor.h                 |   1 +
>   drivers/gemaltomodem/gemaltomodem.c      |   5 +-
>   drivers/gemaltomodem/gemaltomodem.h      |  19 +-
>   drivers/gemaltomodem/gprs-context-wwan.c | 445 ++++++++++++++
>   drivers/gemaltomodem/voicecall.c         | 965 ++++++++++++++++++++++++=
+++++++
>   drivers/mbimmodem/gprs-context.c         |   2 +
>   drivers/mbimmodem/mbim.c                 |   3 +
>   drivers/mbimmodem/mbimmodem.c            |   2 +-
>   drivers/rilmodem/call-forwarding.c       |   2 +-
>   drivers/rilmodem/network-registration.c  |   2 +-
>   18 files changed, 2343 insertions(+), 122 deletions(-)
>   create mode 100644 drivers/gemaltomodem/gprs-context-wwan.c
>   create mode 100644 drivers/gemaltomodem/voicecall.c
>

I'm not going to even bother looking at this until it is broken up =

properly and actually has a commit description that is longer than an =

empty string.

Regards,
-Denis

--===============4854624790992096255==--

