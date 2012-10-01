Content-Type: multipart/mixed; boundary="===============7296630306700982799=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: PinRequired value during sim initialization
Date: Mon, 01 Oct 2012 11:29:53 +0200
Message-ID: <CABvLYuDp4pVJpAnkO=ofchsKEx_3QR9nDQSxzduCsgto=ts3Zw@mail.gmail.com>
In-Reply-To: <5065C0F7.6000007@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7296630306700982799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> In general oFono does not use 'unknown' states for any properties unless
> that is an explicit state that can be obtained from the network.  The bes=
t I
> can suggest right now is that we can make PinRequired an optional propert=
y;
> e.g. it will not be present until the PIN has been queried.

I think this is a good idea. This way there's no doubt in the pin
state when 'PinRequired' is 'none'.

Thanks,
Cedric

--===============7296630306700982799==--

