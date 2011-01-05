Content-Type: multipart/mixed; boundary="===============4895077833013789673=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH v2, 6/7] test: Add CDMA SMS Support
Date: Wed, 05 Jan 2011 09:57:00 -0800
Message-ID: <4D24B0EC.3070302@nokia.com>
In-Reply-To: <4D23903B.2030109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4895077833013789673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 01/04/2011 01:25 PM, ext Denis Kenzior wrote:
> Hi Lei,
>
> On 12/21/2010 06:02 PM, Lei Yu wrote:
>> ---
>>   Makefile.am         |    6 ++-
>>   unit/test-cdmasms.c |  137 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   2 files changed, 142 insertions(+), 1 deletions(-)
>>   create mode 100644 unit/test-cdmasms.c
>>
>
> This one looks fine but have you considered using g_test_add_data_func
> instead of g_test_add_func?  That makes it much easier to add new tests...
>

No, have not looked g_test_add_data_func. Will look into that and =

re-submit patch or ask questions. :-)

> Regards,
> -Denis

Regards,
-Lei

--===============4895077833013789673==--

