Content-Type: multipart/mixed; boundary="===============7377859198655616938=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Startup sequence for Online / offline mode
Date: Wed, 18 Aug 2010 10:57:42 +0300
Message-ID: <87sk2cwdxl.fsf@potku.valot.fi>
In-Reply-To: <AANLkTinz3K8naBTnjz-e9LSf_c0O2C4tGxch=x01qoV2@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7377859198655616938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pekka Pessi <ppessi@gmail.com> writes:

> 2010/8/13 Denis Kenzior <denkenz@gmail.com>:
>>> As online state is not supported by connman yet, ofono should default to
>>> online state until connman support is finished. For example, now it's
>>> impossible to use N900 as a modem with connman because the modem is in
>>> offline state.
>>>
>>> Will you accept patches to ofono to change the default state? It can be
>>> reverted once the connman support is finished.
>
>> I'd be fine with that in the interim.
>
> FYI, I've submitted online patches against the ofono plugin to the
> connman list. It seems to work fine with my N900 and isimodem driver,
> scratching Kalle's most immediate itches.

Awesome! I'll test them as soon as they are commited to git.

-- =

Kalle Valo

--===============7377859198655616938==--

