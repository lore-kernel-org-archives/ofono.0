Content-Type: multipart/mixed; boundary="===============2888912494805814683=="
MIME-Version: 1.0
From: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: Re: ofono-qt - anything to add/improve?
Date: Mon, 04 Jul 2011 20:55:02 +0300
Message-ID: <CANNYZj996p8gMx=xMfKd-PoyOHOr-_wKWXDi_2VwmaSx=SdH8Q@mail.gmail.com>
In-Reply-To: <20110704172153.GC6727@debut.europalab.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2888912494805814683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/7/4 Michael <ofonoconn@encambio.com>:
>>I am the maintainer of ofono-qt library, which provides Qt bindings
>>to ofono services and licensed under LGPL 2.1:
>>http://meego.gitorious.org/meego-cellular/ofono-qt
>>
>>I would like to get in touch with everyone who is using it, or perhaps
>>would like to use it, and find out if there is anything incomplete,
>>missing or possible to improve there. Let me know please.
>>
> Looking at the link you gave, its hard to understand what your
> technology does (without digging into the sources.) Can you please
> give us a summary about it? Maybe a typical use case and a ten line
> 'easiest implementation' scenario?

It's a library that you would perhaps be interested to use if you are
writing your code in Qt C++ and want to access oFono d-bus services.
It abstracts away details of d-bus communication, selects the modem
for you and takes care of asynchronous operations. And there's also a
test suite for catching API breaks.


-- =

Alexander

--===============2888912494805814683==--

