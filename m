Content-Type: multipart/mixed; boundary="===============7964478180266843452=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: UIM manager atom APIs review request
Date: Thu, 19 Aug 2010 10:15:08 +0200
Message-ID: <1282205708.23399.159.camel@localhost.localdomain>
In-Reply-To: <87y6c3un84.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7964478180266843452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> > I am going to implement an UIM manager atom for CDMA extension. Its API=
s will be almost the same as =

> > current SIM manger atom's APIs.  But I suggest maybe will can do some c=
hanges:
> >
> > 	1. Add PIN remain retry count support
> =

> Doesn't GSM also support this? If yes, any pointers/tips how to access
> the retry count from the modem/SIM? I need this in my UI and I would
> like to give a shot implementing this in ofono, but I don't know where
> to start.

yes, GSM modems support this as well. It is just vendor specific.

> (Actually I doubt that my Huawei E1552 even supports this, but miracles
> do happen some times...)

Yes, the Huawei supports this as well. Check $QCPINSTAT or ^CPIN
commands.

Regards

Marcel



--===============7964478180266843452==--

