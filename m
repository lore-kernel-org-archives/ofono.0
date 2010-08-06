Content-Type: multipart/mixed; boundary="===============7877712750969519802=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/6] calypsomodem: Add a Calypso STK driver.
Date: Fri, 06 Aug 2010 19:45:08 +0200
Message-ID: <AANLkTikwiBJcnL+--zUABnRRgcYBNXpFxG2e4DZsL-=m@mail.gmail.com>
In-Reply-To: <4C5C441D.1040907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7877712750969519802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 6 August 2010 19:19, Denis Kenzior <denkenz@gmail.com> wrote:
>> +#include <modem.h>
>> +#include <stk.h>
>
> I removed these includes in a later commit as they didn't seem necessary.

Thanks for catching this, they were leftovers from the previous
version where I had a "inject %SATI" additional call.

Regards,
Andrew

--===============7877712750969519802==--

