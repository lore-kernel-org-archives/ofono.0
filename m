Content-Type: multipart/mixed; boundary="===============2479091909863399566=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 20:26:22 +0300
Message-ID: <a32762a21003301026t33586d81j27c33eee7efec424@mail.gmail.com>
In-Reply-To: <1269963903.11714.254.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2479091909863399566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/3/30 Marcel Holtmann <marcel@holtmann.org>:
>> It seems to me that Marcel thinks "Powered" should control the RF
>> state, too. So, a separate property for enabling he RF would be nice,
>> too.
>
> That is what I call RFKILL and we have a proper subsystem for that. And
> it is different from your Power-1 and Power-2 thing? Sorry, but you
> really lost me now.

RF is controlled using ISI protocol and the PN_MTC service. Like
sending AT+CFUN=3D1/4 in the ste modem plugin's enable() and disable()
ops.

I suppose we'll do the same, then, too.

Cheers,
Aki

--===============2479091909863399566==--

