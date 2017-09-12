Content-Type: multipart/mixed; boundary="===============1393530416114305376=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/3] QMI NetworkMonitor
Date: Tue, 12 Sep 2017 12:53:39 -0500
Message-ID: <08c48c10-fb17-7990-9eb0-1aba456fc3ac@gmail.com>
In-Reply-To: <20170912105237.21750-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1393530416114305376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/12/2017 05:52 AM, Jonas Bonn wrote:
> This is a resubmission of the network-monitor series for QMI modems.
> =

> Changes in v2:
> =

> * Fix endianess errors
> * Add patch to fix out of tree build
> =

> Jonas Bonn (3):
>    Fix out of tree build
>    qmi: add NetworkMonitor interface
>    gobi: create NetworkMonitor atom
> =

>   Makefile.am                 |   3 +-
>   drivers/qmimodem/netmon.c   | 286 +++++++++++++++++++++++++++++++++++++=
+++++++
>   drivers/qmimodem/qmimodem.c |   2 +
>   drivers/qmimodem/qmimodem.h |   3 +
>   plugins/gobi.c              |   5 +-
>   src/common.c                |   2 +-
>   6 files changed, 298 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/qmimodem/netmon.c
> =


All three applied, thanks.

Regards,
-Denis

--===============1393530416114305376==--

