Content-Type: multipart/mixed; boundary="===============8363474733430269378=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC v2 5/7] STE-plugin: Voice-call driver.
Date: Tue, 19 Jan 2010 11:52:01 -0800
Message-ID: <1263930721.5591.194.camel@localhost.localdomain>
In-Reply-To: <1263917513-6756-6-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8363474733430269378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Updates after review:
> Use at_util_call_compare.
> =

> So far, we have only done the trivial changes to voice call driver.
> We agree on moving more of the state logic to core,
> but this is complex and we need more time to discuss and look into this,
> particularly regarding call release.

so this needs a bit more detailed review from Denis once he is back. I
propose that you update all the patches except voice call and GPRS and
make a separate series of patches from them. Then we can merge them and
discuss voicecall and GPRS after that.

Regards

Marcel



--===============8363474733430269378==--

