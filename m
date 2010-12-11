Content-Type: multipart/mixed; boundary="===============1823730251394710997=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] Skip unsolicied CREG/CGREG correctly while checking
 GPRS attach status
Date: Sat, 11 Dec 2010 08:52:13 -0600
Message-ID: <4D03901D.9060105@gmail.com>
In-Reply-To: <AANLkTimrnKDQTyN8DudYiBVpc51Ca2S2nbEu_JuHVz6j@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1823730251394710997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tonny,

> In your proposed patch, it bypass the unsolicited response only if the
> 2nd number after +CGREG: is not single digit, however if the lac is
> single digit, we will still get the wrong state number.

The lac is given as a 2 byte number and should always be printed as four
hexadecimal letters.  If this is not the case, then you should have a
serious talk with your vendor.

> =

> So I still believe we should check whether we are at the end of the
> return string before parsing the unquoted lac and ci.  If we are at the
> end of the string, then this is a unsolicited code and we should ignore
> it.  How do you think?
>  =


I'm against this, if you really want to guard against this, then use the
approach similar to comprehension_tlv_iter_copy in src/simutil.[ch].
You can use that to 'peek' ahead and figure out whether the response
contains 3 or 4 elements.

But again, you would not be having this issue in the first place if your
vendor followed standards ;)

Regards,
-Denis

--===============1823730251394710997==--

