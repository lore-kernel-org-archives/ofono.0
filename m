Content-Type: multipart/mixed; boundary="===============6893895831710309578=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH] Add voicecall driver for Handsfree profile
Date: Sat, 24 Oct 2009 06:05:05 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089B924718@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <6b53b1990910231123k2d53f94v66d4c320d9aa1706@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6893895831710309578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Padovan,

Gustavo F. Padovan wrote:
> Hi Zhenhua,
> =

> on compiling your code I got this:
> =

> cc1: warnings being treated as errors
> drivers/hfpmodem/voicecall.c: In function 'chld_cb':
> drivers/hfpmodem/voicecall.c:539: error: 'ag_mpty_feature' may be used
> uninitialized in this function
> make[1]: *** [drivers/hfpmodem/voicecall.o] Error 1
> make: *** [all] Error 2
> =


The ag_mpty_feature should be initialized as 0 in chld_cb. Thanks for your
comments. I will update patch and send out later.
 =

>> =

>> Regards,
>> Zhenhua
>> =

>> =

>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua

--===============6893895831710309578==--

