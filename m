Content-Type: multipart/mixed; boundary="===============1251696702968735181=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [fix-isi-udev PATCH 0/3] Improve udev with isi
Date: Thu, 07 Oct 2010 22:41:01 +0300
Message-ID: <1286480461.9665.558.camel@tucson.research.nokia.com>
In-Reply-To: <1286197866-19572-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1251696702968735181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On Mon, 2010-10-04 at 15:11 +0200, ext Pekka.Pessi(a)nokia.com wrote:
> [fix-isi-udev PATCH 1/3] udev: do not use post-143 libudev features
> [fix-isi-udev PATCH 2/3] udev: refactor add_isi

These two were applied. Thanks!

> [fix-isi-udev PATCH 3/3] ofono.rules: assign isigen driver by USB ids

This one was left dangling; let's see if we can come up with a better
way to match the modems driven by cdc_phonet. (Although, admittedly this
same approach is already used with some AT modems.)

Cheers,
Aki


--===============1251696702968735181==--

