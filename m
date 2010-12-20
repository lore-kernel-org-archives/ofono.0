Content-Type: multipart/mixed; boundary="===============4958657613214212293=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 5/9] cdmamodem: Add CDMA MO Call Support
Date: Mon, 20 Dec 2010 15:03:36 -0600
Message-ID: <4D0FC4A8.8030703@gmail.com>
In-Reply-To: <1292627481-9109-6-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4958657613214212293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 12/17/2010 05:11 PM, Dara Spieker-Doyle wrote:
> ---
>  Makefile.am                   |    7 ++
>  configure.ac                  |    5 +
>  drivers/cdmamodem/cdmamodem.c |   48 ++++++++++
>  drivers/cdmamodem/cdmamodem.h |   25 ++++++

Please separate this out into two patches, one for adding the cdmamodem
stubs and one for the voicecall driver.

>  drivers/cdmamodem/voicecall.c |  190 +++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 275 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/cdmamodem/cdmamodem.c
>  create mode 100644 drivers/cdmamodem/cdmamodem.h
>  create mode 100644 drivers/cdmamodem/voicecall.c
> =


Regards,
-Denis

--===============4958657613214212293==--

