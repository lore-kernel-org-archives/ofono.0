Content-Type: multipart/mixed; boundary="===============5119068684402580885=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/7] Add quectel EC21 in serial mode
Date: Tue, 26 May 2020 16:09:21 +0000
Message-ID: <9e359184-199b-1b36-6aee-0fd165e49df4@gmail.com>
In-Reply-To: <20200526101625.31871-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5119068684402580885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 5/26/20 5:16 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> This patchset adds support for the quectel EC21 LTE modem connected
> through its serial port.
> =

> Lars Poeschel (7):
>    quectel: Add Quectel EC21 to known serial modems
>    quectel: use lte atom on EC21
>    quectel: Query the model before setting up the mux
>    quectel: EC21 needs aux channel to be the first mux channel
>    quectel: EC21 does not understand AT+QIURC
>    voicecall: Quectel modem do not understand AT+CNAP
>    quectel: EC21 add ussd with atmodem driver
> =

>   drivers/atmodem/voicecall.c |   4 +-
>   plugins/quectel.c           | 153 +++++++++++++++++++++++-------------
>   2 files changed, 101 insertions(+), 56 deletions(-)
> =



So I went ahead and applied everything except patch 4.  See my comments =

in the reply to that patch....

Regards,
-Denis
--===============5119068684402580885==--

