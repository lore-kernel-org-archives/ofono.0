Content-Type: multipart/mixed; boundary="===============4140005306763363828=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] V2 qmimodem: set data format when needed (and
 possible)
Date: Thu, 02 Feb 2017 11:49:18 -0600
Message-ID: <6af98b49-2fc8-3738-7c44-6c7e8c3c0fb0@gmail.com>
In-Reply-To: <20170201103248.26822-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4140005306763363828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 02/01/2017 04:32 AM, Christophe Ronco wrote:
> Remarks from Denis integrated.
>
> MC7430 is a raw-ip only modem. If accessed through 802.3 network interfac=
e,
> no packets can be received (IP layer headers missing).
>
> To be able to start a data connection with this modem, we must tell driver
> (qmi_wwan.c) to mount a raw-ip network interface instead of a 802.3 inter=
face.
>
> This has been implemented in libqmi package. The idea is:
>  - ask modem what data format it wants (raw-ip or 802.3)
>  - ask driver what data format it expects (raw-ip or 802.3)
>  - change driver data format if values do not match
>
> Patch has been split in two.
> In first part, we just add the code needed to get/set driver expected data
> format but nobody ever call these functions.
> In second part, logic explained above is implemented.
> If anything fail (can't get expected data format, can't get modem data fo=
rmat,
> ...), we just don't set anything and continue.
>
> To be able to use this, a kernel 4.5 or more recent is needed.
>
> Christophe Ronco (2):
>   qmimodem: get/set kernel device driver data format
>   qmimodem: change kernel driver data format if needed
>
>  Makefile.am                     |   3 +-
>  drivers/qmimodem/gprs-context.c |  79 +++++++++++++++-
>  drivers/qmimodem/qmi.c          | 200 ++++++++++++++++++++++++++++++++++=
++++++
>  drivers/qmimodem/qmi.h          |  11 +++
>  drivers/qmimodem/wda.h          |  25 +++++
>  5 files changed, 314 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/qmimodem/wda.h
>

All applied, thanks.

Regards,
-Denis

--===============4140005306763363828==--

