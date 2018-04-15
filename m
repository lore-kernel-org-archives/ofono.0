Content-Type: multipart/mixed; boundary="===============7286000641494970731=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/2] gobi: support SMD devices (smartphone SoC)
Date: Sun, 15 Apr 2018 10:29:14 +0200
Message-ID: <C8CE41E8-67DD-47F0-BDA2-C5501C611FEC@holtmann.org>
In-Reply-To: <cover.1523728975.git.joey@joeyhewitt.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7286000641494970731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joey,

> These add support for Qualcomm-based smartphone modems.
> =

> The first is fairly straightforward: searching for "rpmsg"-subsystem devi=
ces and supporting them in gobi as a serial device. A friend has tested it =
on the mainline kernel, with the help of something like `rpmsgexport /dev/r=
pmsg_ctrl0 DATA5_CNTL` (https://github.com/andersson/rpmsgexport) and then =
giving the created rpmsg node OFONO_DRIVER=3Dgobi property.

I would actually prefer that the functionality of RPMSG_CREATE_EPT_IOCTL ge=
ts done inside oFono=E2=80=99s plugin. Also lifetime rules of that created =
node are wonky. I would expect that oFono quits, they are returned back to =
RPMSG subsystem.

> The second is uglier, and maybe controversial, since it's for Qualcomm's =
forked kernel. The smdpkt device doesn't support polling for write, so oFon=
o would wait forever on the poll. This would probably be a 5-line fix in th=
e kernel, but there are thousands of kernel forks, so I thought it might be=
 better to workaround in oFono. I've tested it on Samsung S4 Mini LTE, runn=
ing a kernel based on the MSM fork.

I would still fix this upstream and only workaround devices blacklisted wit=
h a quirk.

This reminds me also why RPMSG is not actually exported as a socket in the =
first. Creating a device node first and then using it later is always prone=
 to race conditions. An alternative is to open the control character device=
 and turn it into a proper pipe for QMI. I would like to see some proper fi=
xes in the RPMSG subsystem to allow for proper handling by a telephony daem=
on.

On a side note, we had all these race conditions and issues with GSM 07.07 =
multiplexer code before. Having to wait for a device node to be create is c=
rap. One reason why oFono comes with a builtin GSM 07.07 implementation.

Regards

Marcel


--===============7286000641494970731==--

