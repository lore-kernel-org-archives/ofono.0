Content-Type: multipart/mixed; boundary="===============7012704251779718805=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] atmodem: add a huawei hack to check attachment status
Date: Fri, 23 Apr 2010 16:24:14 +0200
Message-ID: <1272032654.22838.71.camel@localhost.localdomain>
In-Reply-To: <20100423134020.2107.54598.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7012704251779718805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Huawei doesn't seem to send CGREG notifications (or I wasn't able to
> properly configure the modem to do it), so add an ugly to hack poll the
> state with CGATT.

shouldn't be polling AT+CGREG? the better way to do this?

Regards

Marcel



--===============7012704251779718805==--

