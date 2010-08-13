Content-Type: multipart/mixed; boundary="===============4501765766378672656=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Startup sequence for Online / offline mode
Date: Fri, 13 Aug 2010 21:19:02 +0300
Message-ID: <AANLkTinz3K8naBTnjz-e9LSf_c0O2C4tGxch=x01qoV2@mail.gmail.com>
In-Reply-To: <4C655ED6.1000801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4501765766378672656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,


2010/8/13 Denis Kenzior <denkenz@gmail.com>:
>> As online state is not supported by connman yet, ofono should default to
>> online state until connman support is finished. For example, now it's
>> impossible to use N900 as a modem with connman because the modem is in
>> offline state.
>>
>> Will you accept patches to ofono to change the default state? It can be
>> reverted once the connman support is finished.

> I'd be fine with that in the interim.

FYI, I've submitted online patches against the ofono plugin to the
connman list. It seems to work fine with my N900 and isimodem driver,
scratching Kalle's most immediate itches.

-- =

Pekka.Pessi mail at nokia.com

--===============4501765766378672656==--

