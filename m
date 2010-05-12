Content-Type: multipart/mixed; boundary="===============4223415979015043301=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 6/8] test-stkutil: Add unit test for Get Inkey response
 encoding.
Date: Wed, 12 May 2010 14:56:22 +0200
Message-ID: <AANLkTinAMjMhrIMBuqfzQULMOQNlH_NjlICXQrjUsIix@mail.gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731DE13DF8@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4223415979015043301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 11 May 2010 05:01, Gu, Yang <yang.gu@intel.com> wrote:
> Hi Andrew,
>
>>+#define NO_DURATION { .interval =3D 0x00, }
>>+#define NO_TEXT { .text =3D NULL, .yesno =3D FALSE, }
>
> There is no need to define these as static variables will be initialized =
to zero automatically. We must guarentee zero means non-existence.
> If some meaningful initialization happens to be missed, later check would=
 catch them. Hope this can save several lines of code;)

Good point, I'll resend without the initialisations to zero.  (I swear
I had one test fail at one point, but it succeeded when running in
gdb, so I added the initialisations and it started to work... now it
works either way)

Regards

--===============4223415979015043301==--

