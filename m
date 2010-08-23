Content-Type: multipart/mixed; boundary="===============3866571887514424933=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Support text mode sms send and receive
Date: Mon, 23 Aug 2010 11:25:59 +0200
Message-ID: <1282555559.23399.230.camel@localhost.localdomain>
In-Reply-To: <C6FAFDDBC4402D44BFC43E57565F0219039D85CD@ala-mail09.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3866571887514424933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yong,

> Our project used ZTE EVDO modem. But this modem only supports sending
> and receiving sms with text mode. =


That is pretty sad. ZTE modems have the SMS PDU mode for GSM.

> I have modify oFono gatchat code to support this. But it conflicted
> with original gatchat architecture.

Send the patches and Denis can have a look at it.

> Does oFono plan to support text mode sms send&receive?

So for oFono and GSM we were not planning to use text mode all. The only
case where we use text mode is USSD since there is no PDU mode. For all
other pieces we prefer the binary PDU mode. Text mode has caused too
many problems in the past with various hardware that it is just not
worth support it. In the long run it was a lot simple to just write the
PDU SMS support and caused less of a headache.

We need to dig into this. My personal position would be to tell ZTE to
enable PDU mode. Since CDMA will use PDUs over the air as well as GSM.
Or is it sending SMS as text?

Regards

Marcel



--===============3866571887514424933==--

