Content-Type: multipart/mixed; boundary="===============9179536290649847017=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 0/3] LTE APN series
Date: Mon, 05 Mar 2018 11:33:51 -0600
Message-ID: <c1026ece-9309-967e-a735-7759bfc6b0ee@gmail.com>
In-Reply-To: <20180305123103.11759-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9179536290649847017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/05/2018 06:31 AM, Jonas Bonn wrote:
> Here's v3 of the LTE APN series.  This just fixes up some of the issues t=
hat
> Denis identified in the previous series.  All cosmetic with the exception
> of a leaked QMI response parameter.
> =

> Reinhard had some interesting insight into whence QMI modems take their
> LTE settings.  It seems that there are a fair number of variants in this
> area; I suspect we need to provide some driver hooks somewhere in order
> to get this right.  What this patch series does is to query the default
> context and set the LTE APN there.  It seems this should work for some
> subset of QMI modems, at least; it works for Quectel.  As for the others,
> that will need to be left until another time when they become relevant as
> I don't have anything other than my QMI EC21 to test with...
> =

> /Jonas
> =

> Jonas Bonn (3):
>    qmi: add LTE atom driver
>    gobi: add LTE atom
>    qmimodem: get LTE default bearer APN from modem
> =

>   Makefile.am                 |   1 +
>   drivers/qmimodem/gprs.c     | 162 +++++++++++++++++++++++++--
>   drivers/qmimodem/lte.c      | 264 +++++++++++++++++++++++++++++++++++++=
+++++++
>   drivers/qmimodem/qmimodem.c |   2 +
>   drivers/qmimodem/qmimodem.h |   3 +
>   plugins/gobi.c              |   3 +
>   6 files changed, 426 insertions(+), 9 deletions(-)
>   create mode 100644 drivers/qmimodem/lte.c
> =



All three applied, thanks!

Regards,
-Denis

--===============9179536290649847017==--

