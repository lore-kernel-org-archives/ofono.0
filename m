Content-Type: multipart/mixed; boundary="===============6520719585188470411=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [PATCH] Fix compile warning at MeeGo The gcc version is MeeGo
 4.5.1
Date: Fri, 07 Jan 2011 14:52:11 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD34CC46AC@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1294370910.2501.16.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6520719585188470411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel:
> it is a false positive.
> =

> The only caller that uses the cond value is sim_set_cf_indicator. And it
> only uses conf if the return value is TRUE. So where can this go wrong?
You are right.
I will ask MeeGo tool chain guy to resolve it.
> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============6520719585188470411==--

