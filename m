Content-Type: multipart/mixed; boundary="===============8082466130288744982=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] util: Fix GSM to UTF8 conversion mechanism
Date: Tue, 17 Jul 2012 13:14:17 -0500
Message-ID: <5005AB79.20805@gmail.com>
In-Reply-To: <5006C01F.4050404@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8082466130288744982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>> and can someone please run the unit tests if we are touching this:
>>
>> /testutil/Invalid Conversions: **
>> ERROR:unit/test-util.c:362:test_invalid: assertion failed: (res =3D=3D N=
ULL)
>> Aborted (core dumped)
>
> The purpose of this test was to check if we were failing to convert an
> invalid GSM extended character.
> As this was not the 3GPP recommended behavior, it sounds senseless to
> have it in test_invalid() now.
>
> Denis, should we modify it in checking the character of the main default
> alphabet is returned and add it in test_valid() section?

Yes, please update the tests.

Regards,
-Denis

--===============8082466130288744982==--

