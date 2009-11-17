Content-Type: multipart/mixed; boundary="===============0637540828819111324=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 2/4] Fix: No need to put active call on hold
Date: Tue, 17 Nov 2009 08:39:51 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089CD17C18@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200911161126.08068.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0637540828819111324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>> First, call->status should be 1 stead of 2 in the loop. Second, it's
>> incorrect to set status to hold because later callheld=3D1 will swap
>> call status back. So active->hold->active again is not correct.
> =

> Unfortunately we do need to put the calls on hold otherwise
> the core might pick the wrong call as the 'dialed' call. Instead we
> now ignore the callheld=3D1 indicator in this situation.  Let me know
> if this still doesn't fix this issue. =


Ok. So let's extend the ignore_callheld_1 to another case. If we already
put current active call on hold, user dial out another call from phone,
we also need set ignore_callheld_1 as TRUE so the held call won't
be active again.

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


Regards,
Zhenhua


--===============0637540828819111324==--

