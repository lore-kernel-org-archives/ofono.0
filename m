Content-Type: multipart/mixed; boundary="===============8181542993583123300=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2 1/4] cdmamodem: Add sim driver implementation
Date: Tue, 29 Nov 2011 15:20:10 +0100
Message-ID: <4ED4EA1A.8010202@linux.intel.com>
In-Reply-To: <4ED226D9.2070502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8181542993583123300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 27/11/2011 13:02, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 11/21/2011 04:54 AM, Guillaume Zajac wrote:
>> ---
>>   Makefile.am                   |    3 +-
>>   drivers/cdmamodem/cdmamodem.c |    2 +
>>   drivers/cdmamodem/cdmamodem.h |    3 +
>>   drivers/cdmamodem/sim.c       |  582 +++++++++++++++++++++++++++++++++=
++++++++
>>   4 files changed, 589 insertions(+), 1 deletions(-)
>>   create mode 100644 drivers/cdmamodem/sim.c
>>
> I really don't like us copy-pasting this much code for no good reason.
> Let me toy with a few ideas, but the obvious start would be to refactor
> this code into a library.

Ok I will create a library to factorize the code.
I will send you a first version of the library used only by AT modems.
If it sounds ok I will create the CDMA sim driver using this library.

Kind regards,
Guillaume

--===============8181542993583123300==--

