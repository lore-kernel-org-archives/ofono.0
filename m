Content-Type: multipart/mixed; boundary="===============4941141023242186487=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: Supporting STK without PDUs
Date: Fri, 10 Sep 2010 18:21:55 -0500
Message-ID: <4C8ABD93.7010307@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C901145BEDBE@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4941141023242186487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

On 09/10/2010 05:33 PM, Bastian, Waldo wrote:
>> We have already had a discussion on this one when designing the current
>> stk modem API.  The bottom line is that oFono tries to keep its core <->
>> modem interfaces minimal and exposing the entirety of stkutil.h as
>> official API is definitely too much.
>>
>> So right now you will need to re-encode into PDU form to support such
>> modems (or ask the vendor to give the raw pdus)  While this is a bit of
>> a performance hit, it isn't too bad as the PDUs are always smaller than
>> 256 bytes.
> =

> In that case we would still want to use functionality from stkutil.c to d=
o the actual re-encoding. So in my mind it is a trade-off between forking s=
tkutil.c for one or more modem-plugins or exporting stkutil.h Given that th=
e type definitions in stkutil.h are a relative straightforward mapping of T=
S 102.223 and friends, it may not qualify as a "minimal" API but it will be=
 a rather stable API. So I would like to ask to reconsider exposing the typ=
e definitions as part of the official oFono modem API.
> =


Unfortunately the answer is still no at this time.  stkutil is simply
too big to make into public API.

Please keep in mind that you don't have to 'fork' anything if your modem
driver is builtin.  You can still use that file to perform the encoding.
 However, oFono does not mandate the use of only builtin drivers, and
hence our need to keep the public API minimal and stable.

Regards,
-Denis

--===============4941141023242186487==--

