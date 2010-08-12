Content-Type: multipart/mixed; boundary="===============6112368182291272133=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: maximum number of gsm 7 bit character in a concatenate sms
 message, supported by Ofono
Date: Thu, 12 Aug 2010 11:59:43 -0500
Message-ID: <4C64287F.10309@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D40187032190253@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6112368182291272133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alain,

On 08/12/2010 08:13 AM, Kouassu, AlainX wrote:
> All,
> =

>  =

> =

> Could someone tell me the maximum number  of characters in a
> concatenated  sms message containing standard gsm 7 bit  characters , I
> could send using ofono ?

Please see unit/test-sms.c test_prepare_limits() for a comprehensive
answer to your question.

Regards,
-Denis

--===============6112368182291272133==--

