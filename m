Content-Type: multipart/mixed; boundary="===============7272445121505151091=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] qmi: support sim hotplug
Date: Fri, 15 Feb 2019 16:16:13 +0100
Message-ID: <CAKSBH7HQp4bmiE6CKrz6pTK80uCVp8p09G1vrd-A4pNNXVrrrA@mail.gmail.com>
In-Reply-To: <1550241444-14106-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7272445121505151091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Fri, Feb 15, 2019 at 3:37 PM Christophe Ronco <c.ronco@kerlink.fr> wro=
te:
>
> Hi,
>
> Here is a small patch to support SIM removal and insertion for QMI modems.
> I think indication used is not supported by all QMI modems.
> It has been tested on EG25G after enabling feature using AT+QSIMDET AT co=
mmand.

I suppose it also requires some hardware: removal can be caught on the
periodic STATUS command, but the re-insertion would require polling
the interface without a dedicated switch.

Regards,
Giacinto

>
> Christophe Ronco (1):
>   qmi: support sim hotplug
>
>  drivers/qmimodem/sim.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  drivers/qmimodem/uim.h |  2 +-
>  2 files changed, 41 insertions(+), 5 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============7272445121505151091==--

