Content-Type: multipart/mixed; boundary="===============7821024789337879752=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/3] ssn: remove SSN atom completely
Date: Thu, 03 Mar 2011 13:51:44 -0600
Message-ID: <4D6FF150.8010903@gmail.com>
In-Reply-To: <1e15cdd245725a5a12b25ba6b3b0cc8d66792399.1299168583.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7821024789337879752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 03/03/2011 10:48 AM, Andras Domokos wrote:
> ---
>  Makefile.am                 |    6 +-
>  drivers/atmodem/atmodem.c   |    2 -
>  drivers/atmodem/atmodem.h   |    3 -
>  drivers/atmodem/ssn.c       |  147 -------------------------
>  drivers/isimodem/isimodem.c |    2 -
>  drivers/isimodem/isimodem.h |    3 -
>  drivers/isimodem/ssn.c      |   95 -----------------
>  include/ssn.h               |   61 -----------
>  plugins/calypso.c           |    2 -
>  plugins/g1.c                |    2 -
>  plugins/huawei.c            |    2 -
>  plugins/ifx.c               |    2 -
>  plugins/isiusb.c            |    2 -
>  plugins/linktop.c           |    2 -
>  plugins/n900.c              |    2 -
>  plugins/phonesim.c          |    2 -
>  plugins/ste.c               |    2 -
>  plugins/tc65.c              |    2 -
>  plugins/u8500.c             |    2 -
>  plugins/wavecom.c           |    2 -
>  src/ofono.h                 |   17 ---
>  src/ssn.c                   |  247 -------------------------------------=
------
>  22 files changed, 2 insertions(+), 605 deletions(-)
>  delete mode 100644 drivers/atmodem/ssn.c
>  delete mode 100644 drivers/isimodem/ssn.c
>  delete mode 100644 include/ssn.h
>  delete mode 100644 src/ssn.c
> =


Patch looks good but no longer applies due to changes that Aki pushed
recently.

Regards,
-Denis

--===============7821024789337879752==--

