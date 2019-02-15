Content-Type: multipart/mixed; boundary="===============8274963751308105379=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [PATCH] qmi: support sim hotplug
Date: Fri, 15 Feb 2019 16:30:53 +0100
Message-ID: <c6c795c9-cb47-dd6f-42df-907ab9128fdd@kerlink.fr>
In-Reply-To: <CAKSBH7HQp4bmiE6CKrz6pTK80uCVp8p09G1vrd-A4pNNXVrrrA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8274963751308105379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 2/15/19 4:16 PM, Giacinto Cifelli wrote:
> Hi Christophe,
>
> On Fri, Feb 15, 2019 at 3:37 PM Christophe Ronco <c.ronco@kerlink.fr> w=
rote:
>> Hi,
>>
>> Here is a small patch to support SIM removal and insertion for QMI modem=
s.
>> I think indication used is not supported by all QMI modems.
>> It has been tested on EG25G after enabling feature using AT+QSIMDET AT c=
ommand.
> I suppose it also requires some hardware: removal can be caught on the
> periodic STATUS command, but the re-insertion would require polling
> the interface without a dedicated switch.

You are right. On EG25G, USIM_PRESENCE pin must be connected to SIM module.

Best Regards,

Christophe

>
> Regards,
> Giacinto

--===============8274963751308105379==--

