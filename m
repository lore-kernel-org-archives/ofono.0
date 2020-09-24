Content-Type: multipart/mixed; boundary="===============7381879920910304413=="
MIME-Version: 1.0
From: janez.zupan@etrel.si
Subject: Re: [PATCH 2/2] quectel: Power on/off with a gpio pulse
Date: Thu, 24 Sep 2020 14:21:57 +0000
Message-ID: <20200924142157.2835.26973@ml01.vlan13.01.org>
In-Reply-To: <a603596b-df00-a546-950c-8aae753e1806@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7381879920910304413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,
I've ask Quectel support about reset signal (active low) on EC21 and this w=
as the answer:
----
R&D said that if the reset low time is more than 480ms, the module will res=
et again.
We suggest use PERST# only when failed to turn off the module by AT+QPOWD c=
ommand and PWRKEY pin for protecting the internal flash. The fewer reset ti=
mes of the module, the better.

So we suggest the reset low time to be no more than 460ms and 20ms margin r=
eserved.
---
--===============7381879920910304413==--

