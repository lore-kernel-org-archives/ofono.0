Content-Type: multipart/mixed; boundary="===============7587360905556199998=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 5/6] atmodem: add signal strength support for huawei
Date: Fri, 30 Apr 2010 15:38:56 +0200
Message-ID: <1272634736.22838.196.camel@localhost.localdomain>
In-Reply-To: <20100430125524.30019.86894.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7587360905556199998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Huawei doesn't support CIND indications, instead it uses some non-standard
> RSSI messages:
> =

> ofonod[6401]: < \r\n^RSSI:23\r\n
> =

> Add support for this to atmodem.

please use ofono_netreg_strength_notify for this.

The Huawei specific details with this stupid extra channel need to be
handled inside the Huawei plugin. Cluttering the core with it is not a
good idea.

Regards

Marcel



--===============7587360905556199998==--

