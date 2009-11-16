Content-Type: multipart/mixed; boundary="===============0397109482534212345=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Fix: No need to put active call on hold
Date: Mon, 16 Nov 2009 11:26:07 -0600
Message-ID: <200911161126.08068.denkenz@gmail.com>
In-Reply-To: <1258380704.5437.1.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0397109482534212345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> First, call->status should be 1 stead of 2 in the loop. Second,
> it's incorrect to set status to hold because later callheld=3D1
> will swap call status back. So active->hold->active again is
> not correct.

Unfortunately we do need to put the calls on hold otherwise the core might =

pick the wrong call as the 'dialed' call.  Instead we now ignore the =

callheld=3D1 indicator in this situation.  Let me know if this still doesn'=
t fix =

this issue.

Regards,
-Denis

--===============0397109482534212345==--

