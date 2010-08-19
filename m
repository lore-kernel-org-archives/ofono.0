Content-Type: multipart/mixed; boundary="===============5845793153953604427=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: UIM manager atom APIs review request
Date: Thu, 19 Aug 2010 09:32:11 +0300
Message-ID: <87y6c3un84.fsf@potku.valot.fi>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE8055DC99D@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5845793153953604427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"Zhang, Caiwen" <Caiwen.Zhang@windriver.com> writes:

> I am going to implement an UIM manager atom for CDMA extension. Its APIs =
will be almost the same as =

> current SIM manger atom's APIs. =C2=A0But I suggest maybe will can do som=
e changes:
>
> 	1. Add PIN remain retry count support

Doesn't GSM also support this? If yes, any pointers/tips how to access
the retry count from the modem/SIM? I need this in my UI and I would
like to give a shot implementing this in ofono, but I don't know where
to start.

(Actually I doubt that my Huawei E1552 even supports this, but miracles
do happen some times...)

-- =

Kalle Valo

--===============5845793153953604427==--

