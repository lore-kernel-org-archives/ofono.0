Content-Type: multipart/mixed; boundary="===============6046298278326800391=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] atmodem: add signal strength support for huawei
Date: Fri, 23 Apr 2010 16:22:59 +0200
Message-ID: <1272032579.22838.70.camel@localhost.localdomain>
In-Reply-To: <20100423134013.2107.51323.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6046298278326800391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Huawei doesn't support CIND indications, so use CSQ instead. But naturally
> the response from modem is not according to standard:

is this true for all Huawei modems?

> ofonod[6401]: < \r\n^BOOT:38645652,0,0,0,87\r\n
> ofonod[6401]: < \r\n^RSSI:23\r\n
> =

> Support for this format is not yet implemented.

You see these on the same TTY? Normally they happen on the second TTY.

Regards

Marcel



--===============6046298278326800391==--

