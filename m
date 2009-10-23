Content-Type: multipart/mixed; boundary="===============0205535801498382552=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: [PATCH] Add voicecall driver for Handsfree profile
Date: Fri, 23 Oct 2009 16:23:29 -0200
Message-ID: <6b53b1990910231123k2d53f94v66d4c320d9aa1706@mail.gmail.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089B9246D3@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0205535801498382552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,



2009/10/23 Zhang, Zhenhua <zhenhua.zhang@intel.com>:
> Hi,
>
> The first patch is to handle right bracket in at command parser. It's
> identical with the previous patch I sent in the list.
>
> The second patch depends on the first one so I resend it again. It implem=
ents
> voicecall driver for handsfree profile and use AT+CIEV indicator to notif=
y call
> status change. A field 'struct ofono_call *call' that point to the curren=
t call
> is used to avoid searching call list each time. A boolean 'mpty_call' is =
to
> indicate whether it is multi call or single call. The first version only
> supports single call. The multicall patch will be based on this patch.
>
> Please review it.

on compiling your code I got this:

cc1: warnings being treated as errors
drivers/hfpmodem/voicecall.c: In function 'chld_cb':
drivers/hfpmodem/voicecall.c:539: error: 'ag_mpty_feature' may be used
uninitialized in this function
make[1]: *** [drivers/hfpmodem/voicecall.o] Error 1
make: *** [all] Error 2


>
> Regards,
> Zhenhua
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>
>



-- =

Gustavo F. Padovan
http://padovan.org

--===============0205535801498382552==--

